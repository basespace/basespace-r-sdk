.onAttach <- function(libname, pkgname) {
  packageStartupMessage("BaseSpaceR version ", packageVersion("BaseSpaceR"), 
                        ", ?BaseSpaceR for help")
  
  options(stringsAsFactors = FALSE)
}
