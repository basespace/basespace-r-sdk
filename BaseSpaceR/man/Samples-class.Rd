\name{Samples-class}
\Rdversion{1.1}

\docType{class}

\alias{sampleItem}
\alias{sampleItem-class}
\alias{sampleCollection}
\alias{sampleCollection-class}

\alias{SamplesSummary-class}
\alias{Samples-class}
\alias{Samples}
\alias{Samples,AppAuth-method}
\alias{Samples,SamplesSummary-method}

\alias{listSamples}
\alias{listSamples,AppAuth-method}
\alias{listSamples,Projects-method}


\title{Classes \code{"Samples"}, \code{"sampleItem"} and \code{"sampleCollection"}}

\description{
  Classes and methods to hadle the Samples resource.
}

\section{Methods}{
  \describe{
    \item{Samples}{\code{signature(x = "AppAuth")}: ... }
    \item{listSamples}{\code{signature(x = "AppAuth")}: ... }
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
