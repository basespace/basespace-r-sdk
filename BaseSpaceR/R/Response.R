##setClassUnion("listORNULL", c("list", "NULL"))

############################################################           
## Item - virtual class 
############################################################           
## Interface and main data container storing the HTTP response
## See: https://developer.basespace.illumina.com/docs/content/documentation/rest-api/api-reference#Common_Response_Elements
## All furter classes will inherit from this class

##EL_Item <- c("Id", "Name", "Href", "DateCreated",
##                   "UserOwnedBy", "Status", "HrefBaseSpaceUI")

setClass("Item", 
         representation = representation(
           "VIRTUAL",
           ## Id of the resource - unique identifier
           Id = "character",
           ## Name of the selected resource
           Name = "character",
           ## Location of the resource in the API
           Href = "character",
           ## When this resource was created
           DateCreated = "character", # we could use POSIX ...
           ## Information about the User who owns this resource
           UserOwnedBy = "list", # this looks like an internal structure 
           ## The status of the resource, if it is inside of an appsession it is the status of the appsession
           Status = "ANY",
           ## The location of this project in BaseSpace
           HrefBaseSpaceUI = "character"))


##setClassUnion("ItemORNULL", c("Item", "NULL"))

############################################################           
## Collection - virtual class 
############################################################           
## Collection is a list of Item objects with additional metadata

setClass("Collection",
         representation = representation(
           "VIRTUAL",
           ## Main container or the response, basically a 'list',
           ## but can be an object sharing the 'list' interface.
           Items = "list",
           ## The total number of items in the collection
           TotalCount = "integer",
           ## The starting point of the collection to read, there is no maximum value for Offset. Default: 0
           Offset = "integer",
           ## The maximum number of items to return. Range 0-1024
           Limit = "integer", 
           ## The way to sort the resulting collection, either ascending or descending. Default: 'Asc', Can be 'Asc' or 'Desc'
           SortDir = "character",
           ## The field to use to sort the resulting collection.
           SortBy = "character"),
         prototype = prototype(Items = list(), TotalCount = integer(),
           Offset = 0L, Limit = integer()))

setClassUnion("ItemORCollection", c("Item", "Collection"))


############################################################           
## Response - virtual class 
############################################################           
## Response is a general interface which will be used to model
## the response from each resource.

setClassUnion("AppAuthORNULL", c("AppAuth", "NULL"))

setClass("Response",
         representation = representation(
           "VIRTUAL",
           ## Main container or the response
           data = "ItemORCollection",
           ## The AppAuth instance used to generate the Item
           auth = "AppAuthORNULL"))




############################################################           
## Accessors
############################################################           
## For in internal use -- DO NOT EXPORT!
.selectFromItemList <- function(x, MET) {
  s <- lapply(x, function(r) MET(r))
  ## some elements might be lists!
  if(max(unlist(lapply(s, length), use.names = FALSE)) > 1L)
    return(s)
  return(unlist(s, use.names = FALSE))
}

####  Item   ####
setMethod("Id", "Item", function(x) x@Id)
setMethod("Name", "Item", function(x) x@Name)
setMethod("Href", "Item", function(x) x@Href)
setMethod("DateCreated", "Item", function(x) x@DateCreated)
setMethod("UserOwnedBy", "Item", function(x) x@UserOwnedBy)
setMethod("Status", "Item", function(x) x@Status)
setMethod("HrefBaseSpaceUI", "Item", function(x) x@HrefBaseSpaceUI)


####  Collection   ####
setMethod("Items", "Collection", function(x) x@Items)
setMethod("TotalCount", "Collection", function(x) x@TotalCount)
setMethod("Offset", "Collection", function(x) x@Offset)
setMethod("Limit", "Collection", function(x) x@Limit)
setMethod("SortDir", "Collection", function(x) x@SortDir)
setMethod("SortBy", "Collection", function(x) x@SortBy)

setMethod("Id", "Collection", function(x) .selectFromItemList(x@Items, Id))
setMethod("Name", "Collection", function(x) .selectFromItemList(x@Items, Name))
setMethod("Href", "Collection", function(x) .selectFromItemList(x@Items, Href))
setMethod("DateCreated", "Collection", function(x) .selectFromItemList(x@Items, DateCreated))
setMethod("UserOwnedBy", "Collection", function(x) .selectFromItemList(x@Items, UserOwnedBy))
setMethod("Status", "Collection", function(x) .selectFromItemList(x@Items, Status))
setMethod("HrefBaseSpaceUI", "Collection", function(x) .selectFromItemList(x@Items, HrefBaseSpaceUI))


## We see Item as a collection of size 1
## this will make it fit easier in the Response element
setMethod("Items", "Item", function(x) x)
setMethod("TotalCount", "Item", function(x) as.integer(NA))
setMethod("Offset", "Item", function(x) NA)
setMethod("Limit", "Item", function(x) as.integer(NA))
setMethod("SortDir", "Item", function(x) NA)
setMethod("SortBy", "Item", function(x) NA)
setMethod("DisplayedCount", "Item", function(x) 1L)


####  Response   ####
## Accesor for the auth slot (should we implement all the S4 methods from AppAuth) ???
setMethod("auth", "Response", function(x) x@auth)




############################################################           
## Constructor
############################################################           

####  Item   ####
## !!! Do not export !!! - for in internal use only
## This is quite general, and should apply for all classes inheriting from 'Item'
ItemFromJList <- function(class = "Item", l) {
  if(is.null(l))
    return(NULL)
  
  object <- new(class)
  for(el in intersect(names(l), slotNames(object)))
    slot(object, el, check = TRUE) <- as_id(l[[el]])
  
  return(object)
}


####  Collection   ####
## !!! Do not export !!! - for in internal use only
## This is quite general, and should apply for all classes inheriting from 'Collection'
## @l:  if pressent, it must be a list containing all the slots in the class
## @items:  if pressent is the list of Item objects.
##          Only the 'DisplayedCount' is updated in this case
CollectionFromJList <- function(class = "Collection", l, items) {
  object <- new(class)
  
  if(!missing(l)) {
    if(length(l$Items) != as.integer(l$DisplayedCount))
      stop("'Items' must have the same length as given by the 'DisplayedCount'")
    for(el in intersect(names(l), slotNames(object)))
      slot(object, el, check = TRUE) <- as_id(l[[el]])
  } else {
    if(!missing(items)) {
      object@Items <- l$Items
      object@DisplayedCount <- length(l$Items)
    }
  }
  
  return(object)
}



############################################################           
## Methods
############################################################           


####  Item   ####
.showItem <- function(object) cat(toJSON(as.list(object), pretty = TRUE), "\n") 
setMethod("show", "Item", .showItem)

setMethod("as.list", "Item",
          function(x) {
            l <- named_list(slotNames(x))
            for(el in names(l)) 
              l[[el]] <- slot(x, el)
            
            ## keep only the ones that are not NULL or have length larger than 0
            return(l[unlist(lapply(l, length), use.names = FALSE) > 0L])
          })

setAs("Item", "list", function(from) as.list(from))

## just to be safe
setMethod("length", "Item", function(x) 1L)


## '$' will act as an accesor method. We don't want at this point to define
## generics for all slots in the objects wxtending Item 
## 'list' like operator that will be pushed through the interface
## for Item is just a slot() wrapper 
setMethod("element", "Item", function(x, name) slot(x, name = name))
setMethod("$", "Item", function(x, name) element(x, name = name))


####  Collection   ####

## The usual suspects, R object representation
## length(), as.list(), setAs ...
setMethod("length", "Collection", function(x) length(Items(x)))
setMethod("DisplayedCount", "Collection", function(x) length(x))

setMethod("as.list", "Collection",
          function(x) {
            l <- named_list(c(slotNames(x), "DisplayedCount"))
            l$DisplayedCount <- DisplayedCount(x)
            for(el in slotNames(x)) 
              l[[el]] <- slot(x, el)

            ## Items elements are also converted to a list
            l$Items <- lapply(l$Items, as.list)
            
            ## keep only the ones that are not NULL or have length larger than 0
            return(l[unlist(lapply(l, length), use.names = FALSE) > 0L])
          })

setAs("Collection", "list", function(from) as.list(from))

setMethod("show", "Collection",
          function(object) {
            if(length(object) == 0L) {
              cat("Empty response collection.\n\n")
              return()
            }
            it <- Items(object)
            cat("Collection with", length(object), class(it[[1L]]),
                "objects (out of a total of", TotalCount(object), "objects).\n")
            lapply(it, .showItem)
            cat("\n")
          })

## For collection, '$'/element will work only on Items. '$' it is an Item accessor!
setMethod("element", "Collection",
          function(x, name) {
            s <- lapply(x@Items, slot, name = name)
            if(max(unlist(lapply(s, length), use.names = FALSE)) > 1L)
              return(s)
            return(unlist(s, use.names = FALSE))
          })
setMethod("$", "Collection", function(x, name) element(x, name = name))


####  Response   ####
setMethod("Id", "Response", function(x) Id(x@data))
setMethod("Name", "Response", function(x) Name(x@data))
setMethod("Href", "Response", function(x) Href(x@data))
setMethod("DateCreated", "Response", function(x) DateCreated(x@data))
setMethod("UserOwnedBy", "Response", function(x) UserOwnedBy(x@data))
setMethod("Status", "Response", function(x) Status(x@data))
setMethod("HrefBaseSpaceUI", "Response", function(x) HrefBaseSpaceUI(x@data))

setMethod("Items", "Response", function(x) Items(x@data))
setMethod("DisplayedCount", "Response", function(x) DisplayedCount(x@data))
setMethod("TotalCount", "Response", function(x) TotalCount(x@data))
setMethod("Offset", "Response", function(x) Offset(x@data))
setMethod("Limit", "Response", function(x) Limit(x@data))
setMethod("SortDir", "Response", function(x) SortDir(x@data))
setMethod("SortBy", "Response", function(x) SortBy(x@data))

setMethod("length", "Response", function(x) length(x@data))

setMethod("element", "Response", function(x, name) element(x@data, name = name))
setMethod("$", "Response", function(x, name) element(x@data, name = name))
  


## Simple print method.
setMethod("show", "Response",
          function(object) {
            cat(class(object), "object:\n")
            show(object@data)
          })


