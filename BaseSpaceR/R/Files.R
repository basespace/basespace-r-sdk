############################################################           
##  F I L E S
############################################################           
## The files associated with a Run, Sample, or AppResult.
## All files for each resource are in the File resource.

setClass("fileItem", contains = "Item",
         representation = representation(
           UploadStatus = "character", # The status of the upload of this file
           HrefContent = "character", # There in the API the content of the file is located
           HrefCoverage = "character", # The location in the API of the coverage for this file
           Size = "integer", # The size, in bytes, of this file
           Path = "character", # The path to this file in the BaseSpace UI
           HrefVariants = "character", # The location in the API of the variants for this file
           ContentType = "character", # The type of content contained within this file
           OriginalScope = "character")) # A field that shows information about sample merging, generally populated with info about the origin of this file from sample merging. It gives a logical way to group these merged files together to show where exactly they came from.


## The Items is a list of fileItem objects
## We'll have to implement a validator for this
setClass("fileCollection", contains = "Collection")

## The main Files object 
setClass("Files", contains = "Response",
         representation = representation(
           data = "fileItem"))

## Top level object - the metadata
setClass("FilesSummary", contains = "Response",
         representation = representation(
           data = "fileCollection"))


############################################################           
## Methods / Constructors
############################################################           

## We need to find a better way to instantiate the object ...
fileItem <- function(...) ItemFromJList("fileItem", list(...))

## Same for the fileCollection
fileCollection <- function(...) {
  CollectionFromJList("fileCollection", items = list(...))
}



###################################
## Selecting Files
setMethod("Files", "AppAuth", 
          function(x, id, simplify = FALSE) {
            ## 'id' must be specified
            .queryResource(x = new("Files", auth = x), "files", id, simplify)
          })

setMethod("Files", "FilesSummary", 
          function(x, simplify = FALSE) {
            .queryResource(x = new("Files", auth = x@auth), "files", Id(x), simplify)
          })

## Ideally we'll like to have Files dispatch for Runs, Samples, AppResults
## But we first need to find some use cases!!!
## this will be equivalent with Files(listFiles(projX, ...))




## Files are associated with Runs, AppResults and Samples. So given the id for such
## a resource we can list the files associated with it. 
## As with Samples, we allow for multiple ids to be specified,
## in which case we return a list
## Dispatchment will be done on AppAuth, Runs, Samples and AppResults 

.FilesByResource <- function(x, what, id, simplify = TRUE, ...) {
  id <- as_id(id)
  res <- lapply(id, function(i) {
    res <- x$doGET(resource = make_resource(what, i, "files"), ...)
    if(is.null(res))
      return(NULL)
    
    if(!"Items" %in% names(res))
      stop("Response is not a proper JSON representation of a collection. 'Items' missing!")
    ## each entry in Items must be a fileItem instance
    res$Items <- lapply(res$Items, function(l) ItemFromJList("fileItem", l))
    
    new("FilesSummary", data = CollectionFromJList("fileCollection", l = res), auth = x)
  })
  
  if(length(id) == 1L && simplify) 
    return(res[[1L]])
  
  names(res) <- id
  return(res)
}


## TODO: check that only one of the 3 ids is specified 
setMethod("listFiles", "AppAuth", 
          function(x, runId, sampleId, appResultId, simplify = TRUE, ...) {
            ## by Run Id
            if(!missing(runId)) 
              return(.FilesByResource(x = x, what = "runs", id = runId, simplify = simplify, ...))

            ## by Sample Id
            if(!missing(sampleId))
              return(.FilesByResource(x = x, what = "samples", id = sampleId, simplify = simplify, ...))
            
            ## by AppResult Id
            if(!missing(appResultId))
              return(.FilesByResource(x = x, what = "appresults", id = appResultId, simplify = simplify, ...))
          })

## by runId
setMethod("listFiles", "Runs",
          function(x, simplify = TRUE, ...) listFiles(x@auth, runId = Id(x), simplify = simplify, ...))

## by sampleId
setMethod("listFiles", "Samples",
          function(x, simplify = TRUE, ...) listFiles(x@auth, sampleId = Id(x), simplify = simplify, ...))

## by appResultId
setMethod("listFiles", "AppResults",
          function(x, simplify = TRUE, ...) listFiles(x@auth, appResultId = Id(x), simplify = simplify, ...))



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
            fInfo <- lapply(id, function(i) x$doGET(resource = make_resource("files", i)))
            
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
                cat("Downloading", length(fInfo), "files in directory:", destDir, "\n\n")
              
              for(i in seq_along(fInfo)) {
                fpath <- fInfo[[i]]$Path
                if(!file.exists(dirname(fpath)))
                  dir.create(file.path(destDir, dirname(fpath)),
                             showWarnings = FALSE, recursive = TRUE)
                
                if(verbose)
                  cat("Downloading file:", fpath, "... ")
                .toDisk(res[[i]]$HrefContent,
                        file.path(destDir, fpath),
                        fInfo[[i]]$Size)
                if(verbose)
                  cat("done!")
              }
              return(invisible())
            }
            
            ## retrun the file content as a raw() vector
            for(i in seq_along(fInfo)) {
              if(verbose)
                cat("Downloading file:", fInfo[[i]]$Name, "... ")
              fInfo[[i]]$Content <- .toMem(res[[i]]$HrefContent, fInfo[[i]]$Size)
              if(verbose)
                cat("done!")
            }
            
            if(length(fInfo) == 1L) 
              return(fInfo[[1L]])

            names(fInfo) <- id
            return(fInfo)
          })



## The File is first loaded into memory and then POSTed as the postbody.
## We restrict the file size to 100MB for now.
## TODO: we should vectorize this function w.r.t the fIn.
##       For now only the the first element of fIn is uploaded!
## The file will use the same name. User can only specify the directory!
setMethod("putFiles", "AppAuth",
          function(x, resultId, fIn, directory, verbose = FALSE) {

            ## Basic checks ...
            if(missing(resultId))
              stop("Please specify the AppResult Id ('resultId') where to upload the file(s).")

            if(length(fIn) > 1L) {
              warning("Only the first element in 'fIn' will be used.")
              fIn <- fIn[1L]
            }

            if(!file.exists(fIn))
              stop("\nFile ", sQuote(fIn), " doesn't exist!\n")
            
            ## We allow files not larger than 100MB to be uploaded as single file.
            fsize <- file.info(fIn)$size
            if(fsize > 100 * 2^20)
              stop("\nFile size over the allowed limit of 100MB\n")
              
            ## Load the file into the memory
            fcont <- readBin(fIn, what = raw(), n = fsize)

            ## Make resource with query paramenters
            sres <- paste0(make_resource("appresults", as_id(resultId), "files"),
                           "?name=", basename(fIn))
            if(!missing(directory))
              sres <- paste0(sres, "&directory=", directory) # the REST API should check the validity of 'directory'
            
            res <- x$doPOST(resource = sres, headerFields = c("Content-Type" = "application/octet-stream"),
                            postbody = fcont, verbose = verbose)
            if(is.null(res))
              return(invisible(NULL))  

            cat("\nFile:", sQuote(basename(fIn)), "successfully uploaded! Assigned Id:", res$Id, "\n\n")
            return(new("Files", data = ItemFromJList("fileItem", res), auth = x))
          })
