############################################################           
## C O V E R A G E  -  f o r  .b a m
############################################################           

setMethod("getCoverageStats", "AppAuth",
          function(x, id, chrom) {
            ## we could also vectorize it for the 'chrom' ... is it needed ?
            if(length(chrom) > 1L) {
              warning("Only the first element in 'chrom' will be used.")
              chrom <- chrom[1L]
            }
            
            lapply(as_id(id), function(i) x$doGET(resource = make_resource("coverage", i, chrom, "meta")))
          })


setMethod("getCoverage", "AppAuth",
          function(x, id, chrom, ...) {
            if(length(chrom) > 1L) {
              warning("Only the first element in 'chrom' will be used.")
              chrom <- chrom[1L]
            }
            
            lapply(as_id(id), function(i) x$doGET(resource = make_resource("coverage", i, chrom), ...))
          })

