############################################################           
## A p p R e s u l t s
############################################################           

setMethod("listResults",
          signature(x = "AppAuth", id = "missing"),
          function(x, projectId, ...) {
            return(x$doGET(resource = make_resource("projects", as_id(projectId), "appresults"), ...))
          })

setMethod("listResults",
          signature(x = "AppAuth", id = "ANY"),
          function(x, id, simplify = TRUE) {

            id <- as_id(id)
            res <- lapply(id, function(i) x$doGET(resource = make_resource("appresults", i)))
            
            if(length(id) == 1L && simplify) 
              return(res[[1L]])
            
            names(res) <- id
            return(res)
          })

## 'value' must be a JSON representation of the AppResults metadata
##v1pre3/projects/{ProjectId}/appresults
setMethod("createResults", "AppAuth", 
          function(x, projectId, value) {
            if(missing(value))
              stop("AppResults JSON body required via 'value' parameter!")

            ## we need to update the header !!!
            ## -H "Content-Type: application/json"
            res <- x$doPOST(resource = make_resource("projects", as_id(projectId), "appresults"),
                            headerFields = c("Content-Type" = "application/json"),
                            postbody = value)
            if(is.null(res))
              return(invisible(NULL))  

            message("\nAppResults:\n", value, "\nsuccessfully created. Assigned Id: ", res$Id, "\n")
            return(res)
          })


