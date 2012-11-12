############################################################           
##  P R O J E C T S
############################################################           

setMethod("listProjects","AppAuth",
          function(x, id, ...) {
            
            if(missing(id))
              return(x$doGET(resource = "users/current/projects", ...))
            
            if(length(list(...)))
              warning("Query parameters ignored when quering selected projects!")
            
            res <- lapply(id, function(i) {
              x$doGET(resource = make_resource("projects", i))
            })
            
            if(length(id) == 1L) 
              res <- res[[1L]]
            else
              names(res) <- id
            
            return(res)
          })




setMethod("createProject", "AppAuth", 
          function(x, name) {
            if(missing(name))
              stop("Project name required via 'name' parameter!")
            
            res <- x$doPOST(resource = "projects", .params = list(name = name))
            if(is.null(res))
              return(invisible(NULL))

            message("\nProject ", sQuote(name), " successfully created. Assigned Id: ", res$Id, "\n")
            return(res)
          })


