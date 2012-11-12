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
            return(x$doGET(resource = make_resource("appsessions", id)))
          })



setMethod("updateAppSessions", "AppAuth", 
          function(x, id, status, statusSummary) {
            ## ##
            stop("Resource not yet implemented!")
            ## ##
            
            if(missing(status))
              stop("New App status required via 'status' parameter!")
            
            res <- x$doPOST(resource = make_resource("appsessions", id),
                            .params = list(status = status, statussummary = statusSummary))
            if(is.null(res))
              return(invisible(NULL))
            
            message("\nApp statuts successfully updated ..... Assigned Id: ", res$Id, "\n")
            return(res)
          })


