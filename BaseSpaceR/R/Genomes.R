############################################################           
##  G E N O M E S
############################################################           
## These are the reference genomes that exist in BaseSpace,
## this resource gives information about the origin and build
## for each genome


setClass("genomeItem", contains = "Item",
         representation = representation(
           SpeciesName = "character", # The name of the species whos genome this is
           Source = "character", # The source from which this genome was uploaded
           Build = "character")) # Tracks the version or build of the genome

## The Items is a list of genomeItem objects
## We'll have to implement a validator for this
setClass("genomeCollection", contains = "Collection")

## The main Genomes object
setClass("Genomes", contains = "Response",
         representation = representation(
           data = "genomeItem"))

## Top level object - the metadata
setClass("GenomesSummary", contains = "Response",
         representation = representation(
           data = "genomeCollection"))


############################################################           
## Methods / Constructors
############################################################           

## We need to find a better way to instantiate the object ...
genomeItem <- function(...) ItemFromJList("genomeItem", list(...))

## for runCollection !!!!
genomeCollection <- function(...) {
  CollectionFromJList("genomeCollection", items = list(...))
}


##############################
## Selecting Genomes

## Trivial constructor
setMethod("Genomes", "missing", function() new("Genomes"))

## Constructor from AppAuth
setMethod("Genomes", "AppAuth",
          function(x, id, simplify = FALSE) {
            ## if 'id' is missing, first call Genomes to get all the Ids. 
            if(missing(id))
              id <- Id(listGenomes(x))  # list all Genomes
            .queryResource(x = new("Genomes", auth = x), "genomes", id, simplify)
          })

## Selects all the genomes listed in the GenomesSummary instance
setMethod("Genomes", "GenomesSummary",
          function(x, simplify = FALSE) {
            .queryResource(x = new("Genomes", auth = x@auth), "genomes", Id(x), simplify)
          })



## List from AppAuth
setMethod("listGenomes", "AppAuth",
          function(x, ...) {
            res <- x$doGET(resource = "genomes", ...)
            if(is.null(res))
              return(NULL)
            
            if(!"Items" %in% names(res))
              stop("Response is not a proper JSON representation of a collection. 'Items' missing!")
            ## each entry in Items must be a genomeItem instance
            res$Items <- lapply(res$Items, function(l) ItemFromJList("genomeItem", l))

            new("GenomesSummary", data = CollectionFromJList("genomeCollection", l = res), auth = x)
          })

## List from any Response instance
setMethod("listGenomes", "Response", function(x, ...) listGenomes(x@auth, ...))



