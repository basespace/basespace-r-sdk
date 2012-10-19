## for internal use - replacement for file.path
## will work as paste(..., sep = "/")
## do not export!
## could be optimized such that we cannonize 
make_resource <- function(...)  file.path(...)

