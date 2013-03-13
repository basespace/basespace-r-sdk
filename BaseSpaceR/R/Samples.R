############################################################           
##  S A M P L E S
############################################################           
## A sample is a collection of .fastq files of Reads. Sample
## contains metadata about the physical subject. Samples files
## are generally used as inputs to applications.

setClass("sampleItem", contains = "Item",
         representation = representation(
           HrefGenome =  "character", # The genome to which this sample was referenced, this field is optional and if it is empty it will not be exposed
           SampleNumber = "integer", # The sample number of this sample within the project
           ExperimentName = "character", # The name of the run from which this sample was taken
           HrefFiles = "character", # The location of the files for this sample
           ## We might use an objet of type 'appSessionItem' here
           AppSession = "list", # Information about the appsession that created this sample
           IsPairedEnd = "logical", # Designates whether or not the read is a paired end read
           Read1 = "integer", # The length of the first Read, the number of bases
           Read2 = "integer", # The length of the second Read, the number of bases
           NumReadsRaw = "integer", # The number of Reads for this Sample
           NumReadsPF = "integer", # The number of Reads that have passed filters
           SampleId =  "character", # The Id of the Sample from the samplesheet, this is specified by the user at the flow cell level
           Reference = "list")) # The Reference field shows this Sample's relation to other Samples or AppResults in BaseSpace 


## The Items is a list of sampleItem objects
## We'll have to implement a validator for this
setClass("sampleCollection", contains = "Collection")

## The main Samples object
setClass("Samples", contains = "Response",
         representation = representation(
           data = "sampleItem"))

## Top level object - the metadata
setClass("SamplesSummary", contains = "Response",
         representation = representation(
           data = "sampleCollection"))


############################################################           
## Methods / Constructors
############################################################           

## We need to find a better way to instantiate the object ...
sampleItem <- function(...) ItemFromJList("sampleItem", list(...))

## Same for the sampleCollection
sampleCollection <- function(...) {
  CollectionFromJList("sampleCollection", items = list(...))
}


###################################
## Selecting Samples

## Trivial constructor
setMethod("Samples", "missing",  function() new("Samples"))

## Constructor from AppAuth
setMethod("Samples", "AppAuth",
          function(x, id, simplify = FALSE) {
            ## 'id' must be specified !!! 
            .queryResource(x = new("Samples", auth = x), "samples", id, simplify)
          })

## Selects all samples listed in the SamplesSummary instance
setMethod("Samples", "SamplesSummary",
          function(x, simplify = FALSE) {
            .queryResource(x = new("Samples", auth = x@auth), "samples", Id(x), simplify)
          })



## Samples belong to a Project, so one needs to know the project id to access the samples
## We allow for multiple project ids to be specified, in which case we return a list

## List from AppAuth
setMethod("listSamples", "AppAuth",
          function(x, projectId, simplify = TRUE, ...) {
            projectId <- as_id(projectId)
            res <- lapply(projectId, function(i) {
              res <- x$doGET(resource = make_resource("projects", i, "samples"), ...)
              if(is.null(res))
                return(NULL)
              
              if(!"Items" %in% names(res))
                stop("Response is not a proper JSON representation of a collection. 'Items' missing!")
              ## each entry in Items must be a sampleItem instance
              res$Items <- lapply(res$Items, function(l) ItemFromJList("sampleItem", l))
              
              new("SamplesSummary", data = CollectionFromJList("sampleCollection", l = res), auth = x)
            })
  
            if(length(projectId) == 1L && simplify) 
              return(res[[1L]])
            
            names(res) <- projectId
            return(res)
          })

## List from Projects
## Do we vectorize this?
setMethod("listSamples", "Projects",
          function(x, ...) listSamples(x@auth, projectId = Id(x), simplify = TRUE, ...))
          



