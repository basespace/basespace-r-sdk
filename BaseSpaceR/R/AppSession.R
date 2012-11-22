############################################################           
## A p p S e s s i o n s 
############################################################           


## Do we really need a class for this? 
##.AppSession <- setRefClass("AppSession",
##                           fields = list(session_id = "character"),
##                           contains = "AppAuth")

## Might be good to have a class for this though ... need to see the use cases !!!

setMethod("listAppSessions", "AppAuth",
          function(x, id) {
            ####
            stop("Resource not yet implemented!")
            ####
            return(x$doGET(resource = make_resource("appsessions", as_id(id))))
          })



setMethod("updateAppSessions", "AppAuth", 
          function(x, id, status, statusSummary) {
            if(missing(status))
              stop("Please specify the App status required via 'status' parameter!")

            .params <- list(status = status)
            if(!missing(statusSummary))
              .params <- c(.params, list(statussummary = statusSummary))
            
            res <- x$doPOST(resource = make_resource("appsessions", id), .params = .params)

            if(is.null(res))
              return(invisible(NULL))
            
            message("\nApp statuts successfully updated. New status: ", res$Status, "\n")
            return(res)
          })


