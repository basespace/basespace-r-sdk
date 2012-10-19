############################################################           
##  G E N O M E S
############################################################           

setMethod("listGenomes", "AppAuth",
          function(x, id, ...) {

            if(missing(id))
              return(x$doGET(resource = "genomes", ...))

            if(length(list(...)))
              warning("Query parameters ignored when quering selected genomes!")
            
            res <- lapply(id, function(gid) {
              x$doGET(resource = make_resource("genomes", gid))
            })

            if(length(id) == 1L) 
              res <- res[[1L]]
            else
              names(res) <- id
            return(res)
          })


