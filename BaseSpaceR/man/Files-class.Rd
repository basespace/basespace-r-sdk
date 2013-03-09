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



\title{Classes \code{"Files"}, \code{"fileItem"} and \code{"fileCollection"}}

\description{
  Classes and methods to hadle the Files resource.
}

\section{Methods}{
  \describe{
    \item{Files}{\code{signature(x = "AppAuth")}: ... }
    \item{listFiles}{\code{signature(x = "AppAuth")}: ... }
  }
}
\references{
  https://developer.basespace.illumina.com/docs/content/documentation/rest-api/api-reference
}
\author{
  Adrian Alexa
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
  \code{\linkS4class{Users}} and \code{\linkS4class{Projects}}.
}
\examples{
showClass("AppAuth")
}
\keyword{classes}
\section{Fields}{
  \describe{
    \item{\code{client_id}:}{Object of class \code{character} ~~ }
    \item{\code{client_secret}:}{Object of class \code{character} ~~ }
    \item{\code{uri}:}{Object of class \code{ServiceURI} ~~ }
  }
}
\section{Class-Based Methods}{
  \describe{
    \item{\code{show()}:}{ ~~ }
  }
}
