.onAttach <- function(libname, pkgname) {
  packageStartupMessage("BaseSpaceR version ", packageVersion("BaseSpaceR"), 
                        ", ?BaseSpaceR for help")
  
  options(stringsAsFactors = FALSE)

  ## address bug in Windows RCurl
  if(.Platform$OS.type == "windows")
    options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"), verbose = TRUE))
}
