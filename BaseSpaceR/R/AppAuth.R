############################################################           
##  A p p A u t h    C L A S S
############################################################           

setClassUnion("CURLHandleORNULL", c("NULL", "CURLHandle"))

.AppAuth <- setRefClass("AppAuth",
                        fields = list(
                          client_id = "character", 
                          client_secret = "character", 
                          uri = "ServiceURI", 
                          ## stores the last response from the server - the current state?
                          response = "list",
                          ## curl handler to allow for persistant connections
                          curl_handle = "CURLHandleORNULL",
                          access_token = "character"),
                        methods = list(
                          
                          show = function() {
                            'Method for printing the AppAuth class.'
                            cat("Object of class", classLabel(class(.self)), "with:\n")
                            cat("\nClient Id:      ", client_id, "\n")
                            cat("Client Secrete: ", client_secret, "\n")
                            cat("\nServer\n")
                            methods::show(uri)
                            cat("\nAuthorized:     ", length(access_token) > 0L, "\n")
                          },
                          
                          set_handle = function() {
                            'Sets the curl handle.'
                            if(length(access_token) == 0L) 
                              stop("No access tocken available! Run initializeAuth() to start the authentication!")
                            
                            curl_handle <<- getCurlHandle(httpheader = c("x-access-token" = access_token))
                          },
                          
                          dup_handle = function(headerFields) {
                            'Duplicates the current curl handle.'
                            if (is.null(curl_handle)) 
                              set_handle()
                            
                            if(missing(headerFields))
                              return(dupCurlHandle(curl = curl_handle))
                                                        
                            dupCurlHandle(curl = curl_handle,
                                          httpheader = c("x-access-token" = access_token, headerFields))
                          },

                          initializeAuth = function(scope = "browse global",
                            resource = "oauthv2/deviceauthorization") {
                            'Method that initialize the authentication process.
                             It is automaticaly run by the class generic constructor.
                            '
                            ## send request for the verification code
                            res <- POSTForm(uri, resource = resource,
                                            .params = list(response_type = "device_code",
                                              client_id = client_id, scope = scope))

                            ## store the body in the .self$response
                            response <<- res$body
                            
                            ## check if we get a response containing the verification_uri
                            if(!("verification_uri" %in% names(res$body))) {
                              message("Initialization for the device failed!")
                              cat(toJSON(res$body, pretty = TRUE), "\n")
                              return()
                            }

                            ## since the request is succesful we should rest the access_token
                            access_token <<- character()
                            
                            ## present the verification URI
                            message("\nPerform App grant access using the following URI:")
                            message("\t", res$body$verification_with_code_uri, "\n")
                            
                            return(invisible(list(uri = res$body$verification_uri,
                                                  code = res$body$user_code)))
                          },
                          
                          requestAccessToken = function(resource = "oauthv2/token") {
                            'Retrives and sets the access token.'
                            
                            if(length(access_token)) {
                              warning("Access tocken already available! Run initializeAuth() for a new authentication!")
                              return(invisible())
                            }
                              
                            ## retrieve the device_code from the current state: .self$response
                            device_code <- response$device_code
                            if(is.null(device_code)) 
                              stop("'device_code' not available in the current state!")
                            
                            ## send request for the verification code
                            res <- POSTForm(uri, resource = resource,
                                            .params = list(client_id = client_id,
                                              client_secret = client_secret,
                                              grant_type = "device",
                                              code = device_code))
                            
                            if(res$header[["status"]] != "200") {
                              message(res$header[["statusMessage"]])
                              cat(toJSON(res$body, pretty = TRUE), "\n")
                              return(invisible())
                            }
                            
                            ## store the current state in the .self$response
                            response <<- res$body

                            message("\nAccess token successfully acquired!\n")
                            access_token <<- res$body$access_token
                            
                            ## DO we also set the curl handler?
                            set_handle()
                            
                            return(invisible())
                          }
                          )
                        )


## For now the GET and POST will return the R list representation of the JSON object
## At a later stage we might return a class for each type of request ... 

.AppAuth$methods(doGET = function(...) {
  'Perform a GET request to the server  
  '
  if(is.null(curl_handle))
    set_handle()
  
  res <- GET(uri, curl = curl_handle, ...)
  
  if(res$header[["status"]] != "200") {
    message("\n", res$header[["statusMessage"]], "\n",
            toJSON(res$body, pretty = TRUE))
    return(invisible(NULL)) # Should we return the response body?
  }
  
  ## store the current state in the .self$response
  ##response <<- res$body

  ## we return only the Response element
  ## the Notifications element can be returned as an attribute if necessary
  ## the ResponseStatus is empty at this step ...
  return(res$body$Response)
})
  

## doPOST will call either POSTForm or POST depending if 'postbody' is set or not 
.AppAuth$methods(doPOST = function(..., headerFields, postbody) {
  'Perform a POST request to the server'
  if(is.null(curl_handle))
    set_handle()

  ## update the header if necessary 
  h <- if(missing(headerFields)) curl_handle
  else dup_handle(headerFields)

  ## call either POST or POSTForm
  res <- if(missing(postbody))
    POSTForm(uri, curl = h, ...)
  else
    POST(uri, curl = h, postfields = postbody, ...)
  
  
  ## accept any HTTP 2xx code (Success)
  if(!grepl("^2[[:digit:]]{2}$", res$header[["status"]])) {
    message("\n", res$header[["statusMessage"]], "\n", 
            toJSON(res$body, pretty = TRUE))
    return(invisible(NULL)) # Should we return the response body?
  }
  
  ## we return only the Response element
  ## the Notifications element can be returned as an attribute if necessary
  ## the ResponseStatus is empty at this step ...
  return(res$body$Response)
})




## Constructor - user level
## @...  parameters to pass to initializeAuth() method - we might have to change this later!
AppAuth <- function(client_id, client_secret, uri = ServiceURI(),
                    ..., doOAuth = TRUE) {
  
  ## instance of AppAuth class
  app <- .AppAuth$new(client_id = client_id, client_secret = client_secret, uri = uri)
  
  ## initialize the OAuth process
  if(doOAuth)
    app$initializeAuth(...)

  return(app)
}


## User level function for starting the OAuth process and obtaining the access tocken
setMethod("requestAccessToken", "AppAuth", function(x, ...) x$requestAccessToken(...))
setMethod("initializeAuth", "AppAuth", function(x, ...) x$initializeAuth(...))



