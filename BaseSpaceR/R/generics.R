############################################################           
## Generics
############################################################           
if(!isGeneric("as.list"))
  setGeneric("as.list", function(x, ...) standardGeneric("as.list"),
             useAsDefault = function(x, ...) base::as.list(x, ...))

## ServiceURI methods
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


## AppAuth methods
if(!isGeneric("requestAccessToken"))
  setGeneric("requestAccessToken", function(x, ...) standardGeneric("requestAccessToken"))
if(!isGeneric("initializeAuth"))
  setGeneric("initializeAuth", function(x, ...) standardGeneric("initializeAuth"))
if(!isGeneric("hasAccess"))
  setGeneric("hasAccess", function(x, ...) standardGeneric("hasAccess"))



## !!! Do not export !!!
## for internal use as an 'accessor' - recursive slot() ?
if(!isGeneric("element"))
  setGeneric("element", function(x, ...) standardGeneric("element"))

## Item methods
if(!isGeneric("Id"))
  setGeneric("Id", function(x, ...) standardGeneric("Id"))
if(!isGeneric("Name"))
  setGeneric("Name", function(x, ...) standardGeneric("Name"))
if(!isGeneric("Href"))
  setGeneric("Href", function(x, ...) standardGeneric("Href"))
if(!isGeneric("DateCreated"))
  setGeneric("DateCreated", function(x, ...) standardGeneric("DateCreated"))
if(!isGeneric("UserOwnedBy"))
  setGeneric("UserOwnedBy", function(x, ...) standardGeneric("UserOwnedBy"))
if(!isGeneric("Status"))
  setGeneric("Status", function(x, ...) standardGeneric("Status"))
if(!isGeneric("HrefBaseSpaceUI"))
  setGeneric("HrefBaseSpaceUI", function(x, ...) standardGeneric("HrefBaseSpaceUI"))

## Collection methods
if(!isGeneric("Items"))
  setGeneric("Items", function(x, ...) standardGeneric("Items"))
if(!isGeneric("DisplayedCount"))
  setGeneric("DisplayedCount", function(x, ...) standardGeneric("DisplayedCount"))
if(!isGeneric("TotalCount"))
  setGeneric("TotalCount", function(x, ...) standardGeneric("TotalCount"))
if(!isGeneric("Offset"))
  setGeneric("Offset", function(x, ...) standardGeneric("Offset"))
if(!isGeneric("Limit"))
  setGeneric("Limit", function(x, ...) standardGeneric("Limit"))
if(!isGeneric("SortDir"))
  setGeneric("SortDir", function(x, ...) standardGeneric("SortDir"))
if(!isGeneric("SortBy"))
  setGeneric("SortBy", function(x, ...) standardGeneric("SortBy"))

## Response methods
if(!isGeneric("auth"))
  setGeneric("auth", function(x, ...) standardGeneric("auth"))


## API calls - methods for Resources
## Displacement is done on AppAuth and Response 
if(!isGeneric("Users"))
  setGeneric("Users", function(x, ...) standardGeneric("Users"))

if(!isGeneric("Runs"))
  setGeneric("Runs", function(x, ...) standardGeneric("Runs"))
if(!isGeneric("listRuns"))
  setGeneric("listRuns", function(x, ...) standardGeneric("listRuns"))

if(!isGeneric("Projects"))
  setGeneric("Projects", function(x, ...) standardGeneric("Projects"))
if(!isGeneric("listProjects"))
  setGeneric("listProjects", function(x, ...) standardGeneric("listProjects"))
if(!isGeneric("createProject"))
  setGeneric("createProject", function(x, ...) standardGeneric("createProject"))

if(!isGeneric("Samples"))
  setGeneric("Samples", function(x, ...) standardGeneric("Samples"))
if(!isGeneric("listSamples"))
  setGeneric("listSamples", function(x, ...) standardGeneric("listSamples"))

if(!isGeneric("AppResults"))
  setGeneric("AppResults", function(x, ...) standardGeneric("AppResults"))
if(!isGeneric("listAppResults"))
  setGeneric("listAppResults", function(x, ...) standardGeneric("listAppResults"))
if(!isGeneric("createAppResults"))
  setGeneric("createAppResults", function(x, ...) standardGeneric("createAppResults"))

if(!isGeneric("AppSessions"))
  setGeneric("AppSessions", function(x, ...) standardGeneric("AppSessions"))
if(!isGeneric("listAppSessions"))
  setGeneric("listAppSessions", function(x, ...) standardGeneric("listAppSessions"))
if(!isGeneric("updateAppSessions"))
  setGeneric("updateAppSessions", function(x, ...) standardGeneric("updateAppSessions"))

if(!isGeneric("Genomes"))
  setGeneric("Genomes", function(x, ...) standardGeneric("Genomes"))
if(!isGeneric("listGenomes"))
  setGeneric("listGenomes", function(x, ...) standardGeneric("listGenomes"))


if(!isGeneric("Files"))
  setGeneric("Files", function(x, ...) standardGeneric("Files"))
if(!isGeneric("listFiles"))
  setGeneric("listFiles", function(x, ...) standardGeneric("listFiles"))
if(!isGeneric("getFiles"))
  setGeneric("getFiles", function(x, ...) standardGeneric("getFiles"))
if(!isGeneric("putFiles"))
  setGeneric("putFiles", function(x, ...) standardGeneric("putFiles"))


if(!isGeneric("getVariantSet"))
  setGeneric("getVariantSet", function(x, ...) standardGeneric("getVariantSet"))
if(!isGeneric("getVariants"))
  setGeneric("getVariants", function(x, ...) standardGeneric("getVariants"))


if(!isGeneric("getCoverage"))
  setGeneric("getCoverage", function(x, ...) standardGeneric("getCoverage"))
if(!isGeneric("getCoverageStats"))
  setGeneric("getCoverageStats", function(x, ...) standardGeneric("getCoverageStats"))

