############################################################           
## V A R I A N T S
############################################################           

setMethod("getVariantSet", "AppAuth",
          function(x, id, ...) {
            if(length(id) > 1L) {
              warning("Only the first element in 'id' will be used.")
              id <- id[1L]
            }

            ## Format = "json" - at the moment we don't allow for any other type of response ...
            return(x$doGET(resource = make_resource("variantset", as_id(id))))
          })

## should we ask for and check 'Chrom', 'StartPos', 'EndPos' ???
setMethod("getVariants", "AppAuth",
          function(x, id, chrom, ...) {
            if(length(id) > 1L) {
              warning("Only the first element in 'id' will be used.")
              id <- id[1L]
            }

            return(x$doGET(resource = make_resource("variantset", as_id(id), "variants", chrom), ...))
          })

## Alternatively to the two 'generic' functions above, we could have some fuctions
## that format the input at the R level .... 

