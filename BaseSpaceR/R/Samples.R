setMethod("listSamples","AppAuth",
          function(x, id, projectID, ...) {

            stop("Dispatch on 'id', and if 'id' is missing, we must have the projectID")
            
            if(missing(id))
              return(x$doGET(resource = make_resource("projects", projectID, "samples"), ...))
            
            if(length(list(...)))
              warning("Query parameters ignored when quering selected samples!")
            
            res <- lapply(id, function(i) {
              x$doGET(resource = make_resource("samples", i))
            })
            
            if(length(id) == 1L) 
              res <- res[[1L]]
            else
              names(res) <- id
            
            return(res)
          })

