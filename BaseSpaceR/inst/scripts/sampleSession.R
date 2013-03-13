library(BaseSpaceR)


data(aAuth)
## we can see if the handle can connect to BaseSpace server
hasAccess(aAuth)
## printing the object gives more information
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
## Using the general '$' accesor, same interface as 'list'
u$Id
u$Email # there is no accesor method Email(), so '$' is useful here!
u$fakeElement # returns NULL (to keep the same semantic as 'list')

## Quering the resource unsing a Response object
Users(u) # u is of class Users which extends Response

## Specifying a user ID. ID can be specify either as an integer or as a string
Users(aAuth, id = 1463464) # must work if given as an integer(even of mode numeric)
Users(aAuth, id = "1463464") # must work

## This should fail since is not the current user
tryCatch(Users(aAuth, id = "660666"), error = function(e) cat("No access to this user data!\n"))



########################################
## GENOMES

g <- listGenomes(aAuth)
g$SpeciesName

## using the REST API query parameters
listGenomes(aAuth, Limit = 2)
g <- listGenomes(aAuth, Offset = 5, Limit = 2, SortBy = "Build")
g

## get the details for the listed geneomes
Genomes(g)

## get the genomes based on their ID
Genomes(aAuth, id = 4)
## if the ID is missing thean NULL is returned for that particular ID
Genomes(aAuth, id = c(4, 1, 110))





########################################
## RUNS

r <- listRuns(aAuth)
r

listRuns(aAuth, Statuses = "Failed") # no faild runs
listRuns(aAuth, Statuses = "Complete")
listRuns(aAuth, SortBy = "Id", SortDir="Desc")

Runs(r)[[1]]


Runs(aAuth, id = 101102)
Runs(r)

Runs(aAuth, id = c(Id(r), "11111")) # the third element must be NULL




########################################
## PROJECTS

p <- listProjects(aAuth)
p

Projects(aAuth, id = c(2, 12, 1012))
Projects(p)

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
p <- Projects(listProjects(aAuth, Limit = 1), simplify = TRUE)
p

## list the samples available in this project
allS <- listSamples(aAuth, projectId = Id(p))
##  we can call listSamples() directly using 'p'
identical(allS, listSamples(p))


oneS <- listSamples(aAuth, projectId = Id(p), Limit = 1)
oneS
Samples(oneS) # list with one Samples object
Samples(oneS, simplify = TRUE) # Samples object







########################################
## VARIANTS


## get the Ids of some VCF files
reseq <- listAppResults(aAuth, projectId = 12, Limit = 1)
AppResults(reseq)


## find the Id of the VCF files within that appresult.
vcfs <- listFiles(AppResults(reseq), Extensions = ".vcf")
Name(vcfs)
Id(vcfs)
vcfs


getVariantSet(aAuth, Id(vcfs)[1])


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



## Use GET: files/{id} and within that there will be an `HrefVariants` field
## which shows the Id of the variant for this appresult.

## we can download the file ...
x <- getFiles(aAuth, id = fid)
## look at the file content
invisible(lapply(x, function(f) message(rawToChar(f$Content))))





########################################
## Coverage

## get the Ids of some BAM files
reseq <- listAppResults(aAuth, projectId = 12, Limit = 1)
AppResults(reseq)


## find the Id of the bam files within that appresult.
bamFiles <- listFiles(AppResults(reseq), Extensions = ".bam")
Name(bamFiles)
Id(bamFiles)
bamFiles

## get a Read access to the AppResult
##initializeAuth(aAuth, scope = paste("browse global, read project", 12))
##requestAccessToken(aAuth)

getCoverageStats(aAuth, id = Id(bamFiles), "phix")
readcov <- getCoverage(aAuth, id = Id(bamFiles), "phix", StartPos = 1L, EndPos = 5e3L)[[1]]


##barplot(readcov$MeanCoverage, col = "lightblue1", border = NA)
plot(readcov$MeanCoverage, col = "lightblue2", type = "l", lwd = 2)

############################################################

