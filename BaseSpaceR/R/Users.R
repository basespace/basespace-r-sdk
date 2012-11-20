############################################################           
##  U S E R S
############################################################           
## A user is the individual performing the analysis in BaseSpace. 

## Do we need to treat the case in which the 'id' is vector? 
setMethod("listUsers", "AppAuth",
          function(x, id = "current") {
            
            if(length(id) > 1L) {
              warning("Multiple 'id' not handled at the moment. Using the first!")
              id <- id[1L]
            }
            
            return(x$doGET(resource = make_resource("users", as_id(id))))
          })

