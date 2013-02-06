## Introduction ##

The `BaseSpaceR` package provides a complete R interface to Illumina's BaseSpace REST API, enabling the fast development of data analysis and visualisation tools. Besides providing an easy to use set of functions/methods for manipulating the data from BaseSpace, it also facilitate the access to a rich environment of statistical and data analysis open source tools.

Features include:
- Persistent connection with the REST server.
- Support for the REST API query parameters.
- Vectorized operations in line with the R semantic. Allows for queries across multiple Projects, Samples, AppResults, Files, etc.
- S4 class system used to represent the BaseSpace data model [under development].
- Integration with Bioconductor libraries and data containers [under development].
- Templates for uploading and creating AppResults.
- Portability works on most platforms, Linux, Windows, Mac OS X [under development].

We assume the user has some familiarity with the [BaseSpace API](https://developer.basespace.illumina.com/docs/content/documentation/rest-api/api-reference#API_Resources_and_Methods) and the R environment. Many of the exposed R functions take the same parameters as the REST methods they implement/use.


## Installation ##

This section briefly describe the necessary steps to get `BaseSpaceR` running on your system. We assume that the user have the R environment (see the R project at [http://www.r-project.org](http://www.r-project.org)) already installed and its familiar with it. You will need to have R 2.14.0 or later to be able to install and run BaseSpaceR, and the following two packages installed: `RCurl` and `RJSONIO`. The `BaseSpaceR` package is available from the Github repository [R SDK Repository](http://github.com/basespace/basespace-r-sdk) and can be cloned by
```
git clone git@github.com:basespace/basespace-r-sdk.git
```
We can install the package globally by running the following command.
```
R CMD INSTALL BaseSpaceR
```
However, sometimes it is desirable (if the users doesn't have control over the R installation) to install the libraries locally. In order to do this the user needs to set the `R_LIBS` environment variable.
```
export R_LIBS='/path/to/local/Rlibs'
```
Once this is set, install the package under the `R_LIBS` directory
```
R CMD INSTALL BaseSpaceR -l /path/to/local/Rlibs
```
From within R, load the package using

```
> library(BaseSpaceR)
```
Note that when the package is loaded, both `RCurl` and `RJSONIO` packages are automatically loaded, so the user doesn't need to explicitly load these libraries if he wants to make use of their functionality.


## Quick Start Guide ##

This section describes a simple working session using `BaseSpaceR`. There are only a handful of commands necessary to build a simple App which will be briefly presented below. The remaining sections provide more details on these functions as well as showing other advanced functionality available with this SDK.

A typical session can be divided into the following steps:
- Authentication
- Data retrieval and access
- Data processing
- Uploading results back to BaseSpace


### Q-score per cycle ###

In this sample session we'll show how to select the FastQ file(s) from a specific sample, compute and plot the average Q-score per cycle, create an `AppResults` resource and link the generated image to it. For a more comprehensive example, see the `makeAppResult_Qscore.R` file in the scripts directory of the `BaseSpaceR` package.


#### Load the library ####

```
> library(BaseSpaceR)
```
The first step is the authentication of the client application using the *OAuth2* process. The authentication and communication between the client and the server is handled by an instance of an object of class `AppAuth` [or any objects inheriting from it - under development]. It is easy to create an `AppAuth` instance and to start the *OAuth2* process:
```
> aAuth <- AppAuth(client_id = "5aacd8acb37a441fa71af5072fd7432b",
                   client_secret = "c6c8a20d194d415dba0f40ae2d0b2a92",
                   scope = "create global")
```
The scope we use here is `create global` since the aim is to create a new `AppResults` instance and to upload some data to this resource. If the command is successful, the user is shown the following message:
```
Perform OAuth authentication using the following URI:
    https://basespace.illumina.com/oauth/device?code=xxxxx
```
Once the user has granted access using the *OAtuh2* authentication dialog box, we can request the access token from the server.
```
> requestAccessToken(aAuth)
```
If the authentication process went through without any problem we should be able to see it by printing the `AppAuth` object.
```
> aAuth
Object of class "AppAuth" with:
Client Id: 5aacd8acb37a441fa71af5072fd7432b
Client Secrete: c6c8a20d194d415dba0f40ae2d0b2a92

Server
URL: https://api.basespace.illumina.com
Version: v1pre3

Authorized: TRUE
```
We now have our client App authenticated and we can start manipulating the resources the user has granted access to.


#### View the available projects ####
One of the first steps is to inspect the resources available to the user under the current scope. Lets assume we need to browse all the projects accessible to the user. We can do this using the `listProjects()` function.
```
> res <- listProjects(aAuth)
> str(res)
List of 7
$ Items :List of 5
..$ :List of 5
.. ..$ Id : chr "2"
.. ..$ UserOwnedBy:List of 3
.. .. ..$ Id : chr "1001"
.. .. ..$ Href: chr "v1pre3/users/1001"
.. .. ..$ Name: chr "Illumina Inc"
.. ..$ Href : chr "v1pre3/projects/2"
.. ..$ Name : chr "BaseSpaceDemo"
.. ..$ DateCreated: chr "2012-08-19T21:14:57.0000000"
..$ :List of 5
.. ..$ Id : chr "12"
.. ..$ UserOwnedBy:List of 3
.. .. ..$ Id : chr "1001"
.. .. ..$ Href: chr "v1pre3/users/1001"
.. .. ..$ Name: chr "Illumina Inc"
.. ..$ Href : chr "v1pre3/projects/12"
.. ..$ Name : chr "ResequencingPhixRun"
.. ..$ DateCreated: chr "2012-08-19T21:14:57.0000000"
..................................................................
$ DisplayedCount: num 5
$ TotalCount: num 5
$ Offset : num 0
$ Limit : num 10
$ SortDir : chr "Asc"
$ SortBy : chr "Id"
```
For this instance there are 5 projects available to the user. For each available project we also get some summary information. Lets assume we are interested in project *BaseSpaceDemo* (it has `Id = 2`) and we want to list the available samples.
```
> projId <- 2
```
To get more details on the selected project we specify the project *Id* as an argument to the `listProjects()` function.
```
> res <- listProjects(aAuth, id = projId)
> str(res)
List of 8
$ HrefSamples: chr "v1pre3/projects/2/samples"
$ HrefAppResults : chr "v1pre3/projects/2/aAuthresults"
$ HrefBaseSpaceUI: chr
"https://basespace.illumina.com/project/2/BaseSpaceDemo"
$ Id : chr "2"
$ UserOwnedBy:List of 3
..$ Id : chr "1001"
..$ Href: chr "v1pre3/users/1001"
..$ Name: chr "Illumina Inc"
$ Href : chr "v1pre3/projects/2"
$ Name : chr "BaseSpaceDemo"
$ DateCreated: chr "2012-08-19T21:14:57.0000000"
```

#### Select samples ####
Once we decided which project we want to work on, we can browse the samples associated with it. We can list all the samples or we can limit the search to a specific number of samples, which can be achieved using the `Limit` query parameter.
```
> samples <- listSamples(aAuth, projectId = projId, Limit = 1)
> str(samples)
List of 7
$ Items :List of 1
..$ :List of 8
.. ..$ Id : chr "16018"
.. ..$ Href : chr "v1pre3/samples/16018"
.. ..$ UserOwnedBy :List of 3
.. .. ..$ Id : chr "1001"
.. .. ..$ Href: chr "v1pre3/users/1001"
.. .. ..$ Name: chr "Illumina Inc"
.. ..$ Name : chr "BC\_1"
.. ..$ SampleId : chr "BC\_1"
.. ..$ Status : chr "Complete"
.. ..$ StatusSummary: chr ""
.. ..$ DateCreated : chr "2012-01-14T03:04:36.0000000"
$ DisplayedCount: num 1
$ TotalCount: num 12
$ Offset : num 0
$ Limit : num 1
$ SortDir : chr "Asc"
$ SortBy : chr "Id"
```
There are a total of 12 samples associated with this project, and the listed sample (given that we restricted the result to one sample) has the Id *BC_1*. We can get more information on this sample by calling the `listSamples()` function with the sample Id as argument.
```
> samplId <- samples$Items[[1]]$Id
> inSample <- listSamples(aAuth, id = samplId)
```
The `inSample` object contains detailed information on the selected sample. To get an idea of the information encapsulated in this object we can look at the list entries.
```
> names(inSample)
[1] "SampleNumber" "ExperimentName" "HrefFiles" "AppSession"
[5] "IsPairedEnd""Read1" "Read2" "NumReadsRaw"
[9] "NumReadsPF" "Id" "Href" "UserOwnedBy"
[13] "Name" "SampleId" "Status" "StatusSummary"
[17] "DateCreated""References"
```
For example, the *References* entry contains the relation between the selected sample and other samples or `AppResults`. So if we want to see how many results are related to the current sample we type:
```
> length(inSample$References)
[1] 4
```

#### Sample files ####
We can now access the files linked to the selected sample. To browse the files we use the `listFiles()` function and the sample Id.
```
> allFiles <- listFiles(aAuth, sampleId = samplId)
```
We can of course use all the query parameters implemented by the API File resource methods. For example, we can select just the *.gz* files (in the context of the `Samples` resource these are FastQ files). Lets also assume that we are only interested in the 3rd file (if any exists). To do this we set the offset at 3 and limit the response to only one result.
```
> f <- listFiles(aAuth, sampleId = samplId, Extensions = ".gz", Limit = 1, Offset = 3)
> str(f)
List of 7
$ Items :List of 1
..$ :List of 7
.. ..$ Id : chr "535645"
.. ..$ Href : chr "v1pre3/files/535645"
.. ..$ Name : chr "s_G1_L001_R1_002.fastq.1.gz"
.. ..$ ContentType: chr "application/octet-stream"
.. ..$ Size : num 43895096
.. ..$ Path : chr "data/intensities/basecalls/s_G1_L001_R1_002.fastq.1.gz"
.. ..$ DateCreated: chr "2012-01-14T03:04:36.0000000"
$ DisplayedCount: num 1
$ TotalCount: num 6
$ Offset : num 3
$ Limit : num 1
$ SortDir : chr "Asc"
$ SortBy : chr "Id"
```
The *Path* entry gives us the complete location of the file(s). We can therefore download the file(s) to a local directory and preserving the path information.
```
> f$Items[[1]]$Path
[1] "data/intensities/basecalls/s_G1_L001_R1_002.fastq.1.gz"
> outDir <- paste0("Samples_", samplId)
```
Next we download the selected file(s) to the `outDir`.
```
> getFiles(aAuth, id = f$Items[[1]]$Id, destDir = outDir, verbose = TRUE)
Downloading 1 files in directory: Samples_16018

Downloading file:
data/intensities/basecalls/s_G1_L001_R1_002.fastq.1.gz ... done!
```

#### Compute the average Q-score at each cycle ####
To compute the average Q-scores we need to read the FastQ file from R and extract the base qualities for each read. The Bioconductor `ShortRead` library offers functionality for this. We use the `readFastq()` function to read the file and `quality()` to extract the base qualities.
```
> library(ShortRead)
> fIn <- file.path(outDir, f$Items[[1]]$Path)
> r <- quality(quality(readFastq(fIn, withIds = FALSE)))
```
Now `r` contains all the read qualities from the fastq file. We further transform the data into an integer matrix where each column gives the qualities for the respective read.
```
> rLen <- width(r)[[1L]]; n <- length(r)
> x <- as.integer(unlist(r, use.names = FALSE)) - 33L
```
Thus our matrix `x` has `rLen` rows (the number of cycles) and `n` columns (the
number of reads). Computing the average Q-score at each cycle is as simple as computing the rows averages. We can simply do this using the `.rowMeans()` R function.
```
> qstat <- .rowMeans(x, m = rLen, n = n)
> str(qstat)
num [1:151] 32.7 32.9 33 36.4 36.4 ...
```
We can now generate a simple plot with the average Q-score. We plot the data into a local *.png* file such that we can later upload this file to BaseSpace.
```
> gfile <- file.path(tempdir(), "Qscore_per_cycle.png")
> png(file = gfile, width = 1000, height = 500, bg = "transparent")
> plot(x = qstat, type = "l", ylim = c(2, max(qstat) + 1),
       xlab = "Cycle", ylab = "Average Q-score",
       main = paste("Q-scores statistics for", basename(fIn)))
> dev.off()
```

#### Create the AppResults ####
We can now store the results that our App generated, the Q-score figure in our case, into BaseSpace. To do this we need to create a new `AppResults` instance (possibly under the current project). Before this, we can browse the available results within the current project to inspect if there are any other `AppResults` instances associated with it.
```
> allRes <- listResults(aAuth, projectId = projId))
> allRes$TotalCount
[1] 13
```
There are 13 `AppResults` for the selected project. The `allRes` object contains detailed information for each of these, for the case in which the user wants to find out more. To create a new `AppResults` instance we first need to create a JSON object with a well defined set of fields (see [Writing back to BaseSpace](
https://developer.basespace.illumina.com/docs/content/documentation/app-integration/writing-back-to-basespace#Writing_back_to_BaseSpace) for
more details).
```
> ar <- list(Name = "Average Q-score",
             Description = "Simple stats on the Q-score at each cycle.",
             References = list(Rel = "using",
             HrefContent = inSample$Href))
> aRes <- createResults(aAuth, projectId = projId, value = toJSON(ar))
```
If the user doesn't have write access to the current project, then the `aRes` object will be `NULL` and the a message similar with the one below will be shown to the user.
```
Forbidden
  {
    "ResponseStatus" : {
    "ErrorCode" : "Forbidden",
    "Message" : "Sorry but this requires CREATE access to this Project resource."
    }
  }
```
If the user has the proper access rights (please see Section *Authentication with BaseSpace* for ways on how to change the scope), then the following message will be shown to the user.
```
AppResults:
  {
     "Name": "Average Q-score",
     "Description": "Q-score average at each cycle.",
     "References": {
     "Rel": "using",
     "HrefContent": "v1pre3/samples/16018"
     }
  }
successfully created. Assigned Id: 348349
```
The `aRes` object contains the response from the server as defined in the [REST
API](https://developer.basespace.illumina.com/docs/content/documentation/rest-api/api-reference#AppResults). We can get the `AppResults` Id and the `AppSession` information from its entries.
```
> resId <- aRes$Id
> str(listResults(aAuth, projectId = projId))
```

#### Upload the PNG file ####
The function used for file uploads is `putFiles()`. [At the moment this function implements only the POST method. Multiple file uploads will be soon supported using the same interface]. To upload the file we need to specify the `AppResults` Id and the file location on the disk.
```
res <- putFiles(aAuth, resultId = resId, fIn = gfile)

File: 'Qscore_per_cycle.png' successfully uploaded! Assigned Id: 28521415
```
We can inspect the `res` object.
```
> str(res)

List of 9
$ UploadStatus: chr "complete"
$ HrefContent : chr "v1pre3/files/28521415/content"
$ Id : chr "28521415"
$ Href : chr "v1pre3/files/28521415"
$ Name : chr "Qscore_per_cycle.png"
$ ContentType : chr "aAuthlication/octet-stream"
$ Size : num 9410
$ Path : chr "Qscore_per_cycle.png"
$ DateCreated : chr "2012-11-28T14:55:39.2533381Z"
```
We can thus finalize the current session and update the status of the `AppResults` instance based on the status of the *UploadStatus* entry of the `res` object.
```
> if(res$UploadStatus != "complete")
     stop("Problem upload the result ...")
> unlink(gfile)
```
To change the status of the current session we need the `AppSessionId`. We can get this from the `aRes` object, or we can use the `listResults()` function and the `AppResult` *Id*.
```
> sessionId <- listResults(aAuth, id = resId)$AppSession$Id
> identical(sessionId, aRes$AppSession$Id)
[1] TRUE
```
We just need to set the status of the `AppSession` to *complete* and we're done.
```
> invisible(updateAppSessions(aAuth, id = sessionId, status = "complete"))

App status successfully updated. New status: Complete
```
We can inspect the `AppResults` instance to check if the information was successfully updated.
```
> str(listResults(aAuth, id = resId))
...................................................
```






## Feature Request and Bugs ##
Please feel free to report any feedback regarding the R SDK directly to the repository [R SDK Repository](https://github.com/basespace/basespace-r-sdk/issues), we appreciate any and all feedback about the SDKs. We will do anything we can to improve the SDK and make it easy for developers to use the SDK.
