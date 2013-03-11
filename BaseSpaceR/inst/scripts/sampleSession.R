library(BaseSpaceR)


data(aAuth)
aAuth

## we could make a generic and method hasAccess(aAuth) == aAuth#has_access()



########################################
## USERS

## Empty instance
Users()

## Quering the Users resource using the AppAuth handler
u <- Users(aAuth)
u

## Accesors
Id(u)
Name(u)
## Using the general '$' accesor
u$Id
u$Email # there is no accesor method Email(), so '$' is useful here!

## Quering the resource unsing a Response object
Users(u) # u is of class Users which extends Response

## specifying a user ID
Users(aAuth, id = 1463464) # must work if given as an integer(even of mode numeric)
Users(aAuth, id = "1463464") # must work

#Users(aAuth, id = "660666") # fails since is not the proper user



########################################
## GENOMES

g <- listGenomes(aAuth)
g

listGenomes(aAuth, Limit = 2)
listGenomes(aAuth, Offset = 5, SortBy = "Build")


Genomes(g)
Genomes(aAuth, id = 5) # same as Genomes(app, 5)
Genomes(aAuth, id = c(5, 1, 110))



########################################
## RUNS

listRuns()

r <- listRuns(aAuth)
r

listRuns(aAuth, Statuses = "Failed") # no faild runs
listRuns(aAuth, Statuses = "Complete")
listRuns(aAuth, SortBy = "Id", SortDir="Desc")

Runs(aAuth, id = 101102)
Runs(r)

## BUG
Runs(aAuth, id = c(Id(r), "11111")) # the third element must be NULL




########################################
## PROJECTS

listProjects(aAuth)

Projects(aAuth, id = c(2, 12, 1012))

## Make a new project ...
createProject(aAuth) # must fail!
createProject(aAuth, name = "My Project X")

## We need 'write global' access to be able to create a new project
##initializeAuth(aAuth, scope = "write global")
##requestAccessToken(aAuth)

createProject(aAuth, name = "My Project Y")



########################################
## SAMPLES

## list all the available projects and select one
pid <- sapply(listProjects(aAuth)$Items, "[[", "Id")
pid
pid <- pid[1]
## check the details of the project
str(listProjects(aAuth, id = pid))

## most probably we need read access to the selected project
##initializeAuth(aAuth, scope = paste("browse global, read project", pid))
##requestAccessToken(aAuth)

## list the samples available in this project
str(listSamples(aAuth, projectId = pid))
s <- sapply(listSamples(aAuth, projectId = pid)$Items, "[[", "Id")

str(listSamples(aAuth, id = s[1]))

str(listSamples(aAuth, id = s[1])$AppSession)
str(listSamples(aAuth, id = s[2])$AppSession)
str(listSamples(aAuth, id = s[length(s)])$AppSession)

str(listSamples(aAuth, id = s[1])$Id)





########################################
## VARIANTS

## Find the Id of the appresult which the app would like to find the variants in.
arid <- sapply(listResults(aAuth, projectId = 2)$Items, "[[", "Id")[1]
arid
str(listResults(aAuth, id = arid))

## Use GET: appresults/{id}/files, search for the vcf extension
## and find the Id of the specific vcf file within that appresult.
vcfs <- listFiles(aAuth, resultId = arid, Extensions = ".vcf")$Items
fid <- sapply(vcfs, "[[", "Id")

## Use GET: files/{id} and within that there will be an `HrefVariants` field
## which shows the Id of the variant for this appresult.

## we can download the file ...
x <- getFiles(aAuth, id = fid)
## look at the file content
invisible(lapply(x, function(f) message(rawToChar(f$Content))))

## Or we can get the Variant id and pull the variants out from the DB.
##vid <- sapply(listFiles(aAuth, id = fid), "[[", "HrefVariants") # this give the full resource/path ....
## use the file Id ...
vid <- fid
str(getVariantSet(aAuth, vid[1]))

## get the variants
str(getVariants(aAuth, vid[1], chrom = "chr"))

v <- getVariants(aAuth, vid[1], chrom = "chr", EndPos = 1000000L, Limit = 5)
v$DisplayedCount
str(v)
v <- getVariants(aAuth, vid[1], chrom = "chr", EndPos = 10000000L, Limit = 1000L)





########################################
## Coverage

## get the Ids of some BAM files
arid <- sapply(listResults(aAuth, projectId = 12)$Items, "[[", "Id")[1]
arid
str(listResults(app, id = arid))

## find the Id of the bam files within that appresult.
bams <- listFiles(aAuth, resultId = arid, Extensions = ".bam")$Items
bid <- sapply(bams, "[[", "Id")
bid


## get a Read access to the AppResult
##initializeAuth(aAuth, scope = paste("browse global, read project", 12))
##requestAccessToken(aAuth)


##getFiles(aAuth, id = bid, destDir = "oneBam", verbose = TRUE)
getCoverageStats(aAuth, id = bid, "phix")

readcov <- getCoverage(aAuth, id = bid, "phix", StartPos = 1L, EndPos = 5e3L)[[1]]
##barplot(readcov$MeanCoverage, col = "lightblue1", border = NA)
plot(readcov$MeanCoverage, col = "lightblue2", type = "l", lwd = 2)

############################################################

