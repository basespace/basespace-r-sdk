############################################################           
##  P R O J E C T S
############################################################           
## A project is a logical grouping of Samples and
## AppResults for a user.


setClass("projectItem", contains = "Item",
         representation = representation(
           HrefSamples = "character", # The location of the samples associated with this project
           HrefAppResults = "character")) # The appresults in this project

## The Items is a list of projectItem objects
## We'll have to implement a validator for this
setClass("projectCollection", contains = "Collection")


## The main Projects object
setClass("Projects", contains = "Response",
         representation = representation(
           data = "projectItem"))

## Top level object - the metadata
setClass("ProjectsSummary", contains = "Response",
         representation = representation(
           data = "projectCollection"))


############################################################           
## Methods / Constructors
############################################################           

## We need to find a better way to instantiate the object ...
projectItem <- function(...) ItemFromJList("projectItem", list(...))

## Same for the projectCollection
projectCollection <- function(...) {
  CollectionFromJList("projectCollection", items = list(...))
}


###################################
## Selecting Projects
setMethod("Projects", "AppAuth",
          function(x, id, simplify = FALSE) {
            ## if 'id' is missing, first call listProjects to get all the Ids. 
            if(missing(id)) 
              id <- Id(listProjects(x))  # list all Projects
            
            .queryResource(x = new("Projects", auth = x), "projects", id, simplify)
          })

## Selects all the projects listed in the ProjectsSummary instance
setMethod("Projects", "ProjectsSummary",
          function(x, simplify = FALSE) {
            .queryResource(x = new("Projects", auth = x@auth), "projects", Id(x), simplify)
          })



## List from AppAuth
setMethod("listProjects", "AppAuth",
          function(x, ...) {
            res <- x$doGET(resource = "users/current/projects", ...)
            if(is.null(res))
              return(NULL)
            
            if(!"Items" %in% names(res))
              stop("Response is not a proper JSON representation of a collection. 'Items' missing!")
            ## each entry in Items must be a projectItem instance
            res$Items <- lapply(res$Items, function(l) ItemFromJList("projectItem", l))
            
            new("ProjectsSummary", data = CollectionFromJList("projectCollection", l = res), auth = x)
          })
            
## List from any Response instance
setMethod("listProjects", "Response", function(x, ...) listProjects(x@auth, ...))





############################################################           
## POST methods
############################################################           

setMethod("createProject", "AppAuth", 
          function(x, name) {
            if(missing(name))
              stop("Project name required via 'name' parameter!")
            
            res <- x$doPOST(resource = "projects", .params = list(name = name))
            if(is.null(res))
              return(invisible(NULL))
            cat("\nProject", sQuote(name), "successfully created. Assigned Id:", res$Id, "\n\n")

            new("Projects", data = ItemFromJList(class = "projectItem", res), auth = x)
          })


