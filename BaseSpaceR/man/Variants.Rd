\name{Variants}
\Rdversion{1.1}

\alias{getVariants,AppAuth-method}
\alias{getVariantSet,AppAuth-method}
\alias{getVariants}
\alias{getVariantSet}



\title{Methods for accessing varinant data}

\description{
  Manipulating variant data.
}

\usage{
getVariantSet(x, ...)
getVariants(x, ...)
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
  These methods return a list with a representation of variant data.
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

## get the ids of VCF files (within an AppResult? )
reseq <- listAppResults(aAuth, projectId = 12, Limit = 1)
AppResults(reseq)

vcfs <- listFiles(AppResults(reseq), Extensions = ".vcf")
Name(vcfs)
Id(vcfs)
vcfs

\dontrun{
## variant metadata
getVariantSet(aAuth, vid)

## get the variants
getVariants(aAuth, vid, chrom = "chr")

v <- getVariants(aAuth, vid, chrom = "chr", EndPos = 1000000L, Limit = 5)
v
}
}
\keyword{misc}
