## for internal use - replacement for file.path
## will work as paste(..., sep = "/")
## could be optimized such that we cannonize the resource
## !!! Do not export !!!
make_resource <- function(...)  file.path(...)


## Simple function to be sure that ids are not passed as numerics
## Only integers and characters are allowed, but we don't check this here ...
## !!! Do not export !!!
as_id <- function(id) { if(is.numeric(id)) as.integer(id) else id }


## Creates a named list with the same length as 'lnames'
## !!! Do not export !!!
named_list <- function(lnames = character()) {
  l <- vector("list", length(lnames))
  names(l) <- lnames
  return(l)
}


## for internal use - list the metadata for a resource and given id(s)
## @what: c("runs", "projects", "samples", ...)
## @ it retruns a list of object (or one object if simplify = TURE) of the same class as 'x'
## !!! Do not export !!!
.r2I <- c(users = "userItem", runs = "runItem", projects = "projectItem",
          samples = "sampleItem", appresults = "appResultItem",
          files = "fileItem", genomes = "genomeItem")

.queryResource <- function(x, what, id, simplify) {
  id <- as_id(id)
  res <- lapply(id, function(i) {
    obj <- x
    response <- auth(x)$doGET(resource = make_resource(what, i))
    obj@data <- ItemFromJList(.r2I[what], response)
    return(obj)
  })

  if(length(id) == 1L && simplify)
    return(res[[1L]])

  names(res) <- id
  return(res)
}

## .listResource <- function(x, what, id, simplify) {
##   id <- as_id(id)
##   res <- lapply(id, function(i) ItemFromJList(.r2I[what], x$doGET(resource = make_resource(what, i))))

##   if(length(id) == 1L && simplify)
##     return(res[[1L]])

##   names(res) <- id
##   return(res)
## }

