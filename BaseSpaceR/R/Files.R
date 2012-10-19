setMethod("listFiles",
          signature(x = "AppAuth", id = "missing"),
          function(x, runId, ...) {
            return(x$doGET(resource = make_resource("runs", runId, "files"), ...))
          })


setMethod("listFiles",
          signature(x = "AppAuth", id = "ANY"),
          function(x, id) {

            res <- lapply(id, function(i) {
              x$doGET(resource = make_resource("files", i))
            })
            
            if(length(id) == 1L) 
              res <- res[[1L]]
            else
              names(res) <- id
            
            return(res)
          })


setMethod("getFiles", "AppAuth",
          function(x, id) {

            res <- lapply(id, function(i) {
              x$doGET(resource = make_resource("files", i, "content"), redirect = "meta")
            })
            
            if(length(id) == 1L) 
              res <- res[[1L]]
            else
              names(res) <- id
            
            return(res)
          })

