\name{Coverage}
\Rdversion{1.1}

\alias{getCoverage,AppAuth-method}
\alias{getCoverage}
\alias{getCoverageStats,AppAuth-method}
\alias{getCoverageStats}

\title{Methods for accessing coverage data from BAM files}

\description{
  This methods are used to provide mean read coverage depth in a
  particular chromosomal region.
}

\usage{
getCoverageStats(x, ...)
getCoverage(x, ...)
}

\arguments{
  \item{x}{An object of class \code{AppAuth}.}
  \item{...}{Adiditional arguments supported by the REST API.
      \describe{
	\item{id}{File id (for a BAM file) within BaseSpace.}
	\item{chrom}{Character string given the chromosome name (UCSC).}
      }
    }
}


\details{
  Coming soon...
}

\value{
  These methods return a list with a representation of coverage histogram.
}

\references{
  https://developer.basespace.illumina.com/docs/content/documentation/rest-api/api-reference
}
\author{
  Adrian Alexa
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
  \code{\linkS4class{AppAuth}}.
}

\examples{

data(aAuth)

## get the Ids of some BAM files
##...


## You might require Read access to the AppResult
#initializeAuth(aAuth, scope = paste("browse global, read project", 12))
#requestAccessToken(aAuth)


#getCoverageStats(aAuth, id = bid, "phix")

#readcov <- getCoverage(aAuth, id = bid, "phix", StartPos = 1L, EndPos = 5e3L)[[1]]
#barplot(readcov$MeanCoverage, col = "lightblue1", border = NA)
#plot(readcov$MeanCoverage, col = "lightblue2", type = "l", lwd = 2)

}
\keyword{methods}
