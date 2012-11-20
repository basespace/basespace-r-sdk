## for internal use - replacement for file.path
## will work as paste(..., sep = "/")
## !!! Do not export !!!
## could be optimized such that we cannonize 
make_resource <- function(...)  file.path(...)



## Simple function to be sure that ids are not passed as numerics
## Only integers and characters are allowed, but we don't check this here ...
## !!! Do not export !!!
as_id <- function(id) { if(is.numeric(id)) as.integer(id) else id }
