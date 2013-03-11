############################################################
##  U S E R S
############################################################
## A user is the individual performing the analysis in BaseSpace.

##EL_USERS <- c("Email", "HrefRuns", "HrefProjects")

setClass("userItem", contains = "Item",
         representation = representation(
           ## Current user's email address
           Email = "character",
           ## The runs that the user owns or has access to
           HrefRuns = "character",
           ## The projects that the user owns or has access to
           HrefProjects = "character"))

## The Items is a list of userItem objects
## We'll have to implement a validator for this
##setClass("userCollection", contains = "Collection")

## Since we have only one user we don't need to use a Collection
setClass("Users", contains = "Response",
         representation = representation(
           data = "userItem"))

############################################################
## Methods
############################################################

## userResponse methods - do we really need to implement these???
##setMethod("Email", "userItem", function(x) x@Email)
##setMethod("HrefRuns", "userItem", function(x) x@HrefRuns)
##setMethod("HrefProjects", "userItem", function(x) x@HrefProjects)


####   Constructors   ####

## We need to find a better way to instantiate the object ...
userItem <- function(...) ItemFromJList("userItem", list(...))


## Trivial constructor
setMethod("Users", "missing", function() new("Users"))

## Constructor from AppAuth
## Do we need to treat the case in which the 'id' is vector?
setMethod("Users", "AppAuth",
          function(x, id = "current") {
            if(length(id) > 1L) {
              warning("Multiple 'id' not handled at the moment. Using the first!")
              id <- id[1L]
            }

            .queryResource(x = new("Users", auth = x), what = "users", id = id, simplify = TRUE)
          })

## Constructor from any Response instance
setMethod("Users", "Response", function(x, id = "current") Users(x@auth, id))


