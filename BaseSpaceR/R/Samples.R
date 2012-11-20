setMethod("listSamples",
          signature(x = "AppAuth", id = "missing"),
          function(x, projectId, ...) {
            return(x$doGET(resource = make_resource("projects", as_id(projectId), "samples"), ...))
          })

setMethod("listSamples",
          signature(x = "AppAuth", id = "ANY"),
          function(x, id, simplify = TRUE) {

            id <- as_id(id)
            
            res <- lapply(id, function(i) x$doGET(resource = make_resource("samples", i)))
            
            if(length(id) == 1L && simplify) 
              return(res[[1L]])
            
            names(res) <- id
            return(res)
          })

            
