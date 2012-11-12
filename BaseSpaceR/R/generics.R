if(!isGeneric("uri"))
  setGeneric("uri", function(x, ...) standardGeneric("uri"))



## basic wrappers to getForm and postForm
## both will return a list with two components: 'header' and 'body'
## JSON processing of the body is also done at this level
if(!isGeneric("GET"))
  setGeneric("GET", function(x, ...) standardGeneric("GET"))
if(!isGeneric("POST"))
  setGeneric("POST", function(x, ...) standardGeneric("POST"))
if(!isGeneric("POSTForm"))
  setGeneric("POSTForm", function(x, ...) standardGeneric("POSTForm"))


## methods for AppAuth
if(!isGeneric("requestAccessToken"))
  setGeneric("requestAccessToken", function(x, ...) standardGeneric("requestAccessToken"))
if(!isGeneric("initializeAuth"))
  setGeneric("initializeAuth", function(x, ...) standardGeneric("initializeAuth"))



## API calls - methods for AppAuth
if(!isGeneric("listUsers"))
  setGeneric("listUsers", function(x, ...) standardGeneric("listUsers"))

if(!isGeneric("listGenomes"))
  setGeneric("listGenomes", function(x, ...) standardGeneric("listGenomes"))

if(!isGeneric("listRuns"))
  setGeneric("listRuns", function(x, ...) standardGeneric("listRuns"))

if(!isGeneric("listProjects"))
  setGeneric("listProjects", function(x, ...) standardGeneric("listProjects"))
if(!isGeneric("createProject"))
  setGeneric("createProject", function(x, ...) standardGeneric("createProject"))

if(!isGeneric("listResults"))
  setGeneric("listResults", function(x, id, ...) standardGeneric("listResults"))
if(!isGeneric("createResults"))
  setGeneric("createResults", function(x, ...) standardGeneric("createResults"))

if(!isGeneric("listAppSessions"))
  setGeneric("listAppSessions", function(x, ...) standardGeneric("listAppSessions"))
if(!isGeneric("updateAppSessions"))
  setGeneric("updateAppSessions", function(x, ...) standardGeneric("updateAppSessions"))

if(!isGeneric("listSamples"))
  setGeneric("listSamples", function(x, id, ...) standardGeneric("listSamples"))

if(!isGeneric("listFiles"))
  setGeneric("listFiles", function(x, id, ...) standardGeneric("listFiles"))
if(!isGeneric("getFiles"))
  setGeneric("getFiles", function(x, ...) standardGeneric("getFiles"))


if(!isGeneric("getVariantSet"))
  setGeneric("getVariantSet", function(x, ...) standardGeneric("getVariantSet"))
if(!isGeneric("getVariants"))
  setGeneric("getVariants", function(x, ...) standardGeneric("getVariants"))


if(!isGeneric("getCoverage"))
  setGeneric("getCoverage", function(x, ...) standardGeneric("getCoverage"))
if(!isGeneric("getCoverageStats"))
  setGeneric("getCoverageStats", function(x, ...) standardGeneric("getCoverageStats"))

