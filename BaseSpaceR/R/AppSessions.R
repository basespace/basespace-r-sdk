############################################################           
## A p p S e s s i o n s 
############################################################           
## AppSession extends information about each Sample and AppResult
## and allows grouping by showing the instance of an application.

setClass("appSessionItem", contains = "Item",
         representation = representation(
           References = "list", # The resources that are referenced by the appsession
           ## Status is defined by Item, but here it is a list (will be a class at a later point)
           Status = "character", # Status of the AppSession, the Samples or AppResults created by it wil inherit this property. This parameter is REQUIRED otherwise an error will be thrown.
           StatusSummary = "character", # A summary of the status of the appsession
           Application = "list")) # The application that created this appsession, includes information about the application


## Top level object - the metadata
setClass("AppSessions", contains = "Response",
         representation = representation(
           data = "appSessionItem"))


## Do we really need a class for this? 
##.AppSession <- setRefClass("AppSession",
##                           fields = list(session_id = "character"),
##                           contains = "AppAuth")

############################################################           
## Methods
############################################################           

####  Constructors   ####

## We need to find a better way to instantiate the object ...
appSessionItem <- function(...) ItemFromJList("appSessionItem", list(...))


## Constructor from an AppResults 
setMethod("AppSessions", "AppResults",
          function(x) {
            new("AppSessions", data = ItemFromJList("appSessionItem", x@data@AppSession), auth = x@auth)
          })

## Constructor from AppAuth
setMethod("AppSessions", "AppAuth",
          function(x, ...) {
            ####
            stop("Resource not yet implemented!")
            ####
            return(new("AppSessions"))
          })


############################################################
## Under development ... need to see the use cases !!!

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
            
            cat("\nApp statuts successfully updated. New status:", res$Status, "\n\n")
            return(res)
          })


