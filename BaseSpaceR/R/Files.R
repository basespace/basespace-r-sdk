.listFilesById <- function(x, id) {
  lapply(id, function(i) x$doGET(resource = make_resource("files", i)))
}

## if 'id' is missing we have 3 cases to list the files
## 1) by runId
## 2) by sampleId
## 3) by appresultId
## TODO: check that only one of the 3 ids is specified 
setMethod("listFiles",
          signature(x = "AppAuth", id = "missing"),
          function(x, runId, sampleId, resultId, ...) {
            ## by Runs Id
            if(!missing(runId))
              return(x$doGET(resource = make_resource("runs", as_id(runId), "files"), ...))

            ## by Sample Id
            if(!missing(sampleId))
              return(x$doGET(resource = make_resource("samples", as_id(sampleId), "files"), ...))
            
            ## by Appresult Id
            if(!missing(resultId))
              return(x$doGET(resource = make_resource("appresults", as_id(resultId), "files"), ...))
          })


setMethod("listFiles",
          signature(x = "AppAuth", id = "ANY"),
          function(x, id, simplify = TRUE) {

            id <- as_id(id)
            res <- .listFilesById(x, id)
            
            if(length(id) == 1L && simplify) 
              return(res[[1L]])
            
            names(res) <- id
            return(res)
          })


## if destDir is missing the function downloads the files into memory
## and return the contend as a raw() vector, with additional metadata
## TODO: when downloading multiple files we should enable
##       asynchronous downloads !!!
setMethod("getFiles", "AppAuth",
          function(x, id, destDir, verbose = FALSE) {

            .toDisk <- function(loc, fname, fsize) {
              cf <- CFILE(fname, mode = "w")
              err <- curlPerform(url = loc, writedata = cf@ref)
              invisible(close(cf))
              if(err != 0L)
                stop("Problem downloading file: ", fname)
              
              if((dsize <- file.info(fname)$size) != fsize)
                warning("Expected file size: ", fsize, " bytes - got: ", dsize, " bytes.")
              
              return(invisible())
            }

            .toMem <- function(loc, fsize) {
              fcontent <- getURLContent(loc, isHTTP = TRUE)
              if(length(fcontent) != fsize)
                warning("Expected file size: ", fsize, " bytes - got: ", dsize, " bytes.")
              return(fcontent)
            }
            
            if(missing(id))
              stop("Please specify the file(s) 'id'")

            id <- as_id(id)
            ## get the file information / metadata
            fInfo <- .listFilesById(x, id)
            
            if(is.null(fInfo) || all(sapply(fInfo, is.null)))
              stop("Wrong file 'id' or resource scope!")
            
            ## get the url of the file
            res <- lapply(id, function(i) {
              x$doGET(resource = make_resource("files", i, "content"), redirect = "meta")
            })
            
            if(!missing(destDir)) {
              if(!file.exists(destDir))
                dir.create(destDir, showWarnings = FALSE, recursive = TRUE)
              if(verbose)
                message("Downloading ", length(fInfo), " files in directory: ", destDir, "\n")
              
              for(i in seq_along(fInfo)) {
                fpath <- fInfo[[i]]$Path
                if(!file.exists(dirname(fpath)))
                  dir.create(file.path(destDir, dirname(fpath)),
                             showWarnings = FALSE, recursive = TRUE)
                
                if(verbose)
                  message("Downloading file: ", fpath, " ...", appendLF = FALSE)
                .toDisk(res[[i]]$HrefContent,
                        file.path(destDir, fpath),
                        fInfo[[i]]$Size)
                if(verbose)
                  message(" done!")
              }
              return(invisible())
            }
            
            ## retrun the file content as a raw() vector
            for(i in seq_along(fInfo)) {
              if(verbose)
                message("Downloading file: ", fInfo[[i]]$Name, " ...", appendLF = FALSE)
              fInfo[[i]]$Content <- .toMem(res[[i]]$HrefContent, fInfo[[i]]$Size)
              if(verbose)
                message(" done!")
            }
            
            if(length(fInfo) == 1L) 
              return(fInfo[[1L]])

            names(fInfo) <- id
            return(fInfo)
          })

