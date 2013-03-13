\name{Files-class}
\Rdversion{1.1}

\docType{class}

\alias{fileItem}
\alias{fileItem-class}
\alias{fileCollection}
\alias{fileCollection-class}

\alias{FilesSummary-class}
\alias{Files-class}
\alias{Files}
\alias{Files,missing-method}
\alias{Files,AppAuth-method}
\alias{Files,FilesSummary-method}

\alias{listFiles}
\alias{listFiles,AppAuth-method}
\alias{listFiles,Runs-method}
\alias{listFiles,Samples-method}
\alias{listFiles,AppResults-method}

\alias{getFiles,AppAuth-method}
\alias{getFiles}
\alias{putFiles,AppAuth-method}
\alias{putFiles}



\title{\code{Files} and \code{FilesSummary} objects}

\description{
  Classes and methods to handle the Files resource.
}

\references{
  https://developer.basespace.illumina.com/docs/content/documentation/rest-api/api-reference
}
\author{
  Adrian Alexa
}


\seealso{
  \code{\linkS4class{AppAuth}}, \code{\linkS4class{Runs}},
  \code{\linkS4class{Samples}} and \code{\linkS4class{AppResults}}.
}

\examples{
showClass("Files")
}
\keyword{classes}
\keyword{methods}
