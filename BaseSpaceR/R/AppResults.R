############################################################           
## A p p R e s u l t s
############################################################           
## An AppResult is an output of an App. It contains BAMs,
## VCFs and other output file formats produced by an App. 


setClass("appResultItem", contains = "Item",
         representation = representation(
           HrefGenome =  "character", # The genome to which this sample was referenced, this field is optional and if it is empty it will not be exposed
           HrefFiles = "character", # The location of the files for this sample
           ## We might use an objet of type 'appSessionItem' here
           AppSession = "list", # Information about the appsession that created this sample
           Reference = "list")) # The Reference field shows this Sample's relation to other Samples or AppResults in BaseSpace 

## The Items is a list of appResultItem objects
## We'll have to implement a validator for this
setClass("appResultCollection", contains = "Collection")

## The main AppResults object
setClass("AppResults", contains = "Response",
         representation = representation(
           data = "appResultItem"))

## Top level object - the metadata
setClass("AppResultsSummary", contains = "Response",
         representation = representation(
           data = "appResultCollection"))


############################################################           
## Methods / Constructors
############################################################           

## We need to find a better way to instantiate the object ...
appResultItem <- function(...) ItemFromJList("appResultItem", list(...))

## Same for the projectCollection
appResultCollection <- function(...) {
  CollectionFromJList("appResultCollection", items = list(...))
}


###################################
## Selecting AppResults

## Trivial constructor
setMethod("AppResults", "missing",  function() new("AppResults"))

## Constructor from AppAuth
setMethod("AppResults", "AppAuth",
          function(x, id, simplify = FALSE) {
            ## 'id' must be specified
            .queryResource(x = new("AppResults", auth = x), "appresults", id, simplify)
          })

## Selects all appResults listed in the AppReultsSummary instance
setMethod("AppResults", "AppResultsSummary", 
          function(x, simplify = TRUE) {
            .queryResource(x = new("AppResults", auth = x@auth), "appresults", Id(x), simplify)
          })



## AppResults belong to a Project, so one needs to know the project id to access the AppResult
## We allow for multiple project ids to be specified, in which case we return a list

## List from AppAuth
setMethod("listAppResults", "AppAuth", 
          function(x, projectId, simplify = TRUE, ...) {
            projectId <- as_id(projectId)
            res <- lapply(projectId, function(i) {
              res <- x$doGET(resource = make_resource("projects", i, "appresults"), ...)
              if(is.null(res))
                return(NULL)
              
              if(!"Items" %in% names(res))
                stop("Response is not a proper JSON representation of a collection. 'Items' missing!")
              ## each entry in Items must be a appResultItem instance
              res$Items <- lapply(res$Items, function(l) ItemFromJList("appResultItem", l))
              
              new("AppResultsSummary", data = CollectionFromJList("appResultCollection", l = res), auth = x)
            })
            
            if(length(projectId) == 1L && simplify) 
              return(res[[1L]])
            
            names(res) <- projectId
            return(res)
          })

## List from Projects
setMethod("listAppResults", "Projects",
          function(x, ...) listAppResults(x@auth, projectId = Id(x), simplify = TRUE, ...))



############################################################           
## POST methods
############################################################           

## Creating an AppResults
## 'value' must be a JSON representation of the AppResults metadata
## v1pre3/projects/{ProjectId}/appresults
setMethod("createAppResults", "AppAuth", 
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
            cat("\nAppResults:\n", value, "\nsuccessfully created. Assigned Id:", res$Id, "\n\n")

            new("AppResults", data = ItemFromJList(class = "appResultItem", res), auth = x)
          })


setMethod("createAppResults", "Projects", 
          function(x, value) createAppResults(x@auth, Id(x), value))
