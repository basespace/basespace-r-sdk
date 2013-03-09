\name{Runs-class}
\Rdversion{1.1}

\docType{class}

\alias{runItem}
\alias{runItem-class}
\alias{runCollection}
\alias{runCollection-class}

\alias{RunsSummary-class}
\alias{Runs}
\alias{Runs-class}
\alias{Runs,AppAuth-method}
\alias{Runs,RunsSummary-method}


\alias{listRuns}
\alias{listRuns,AppAuth-method}
\alias{listRuns,Response-method}


\title{Classes \code{"Runs"}, \code{RunsSummary} and \code{"runItem"}}

\description{
  Classes and methods to hadle the Runs resource.
}

\section{Methods}{
  \describe{
    \item{Runs}{\code{signature(x = "AppAuth")}: ... }
    \item{listRuns}{\code{signature(x = "AppAuth")}: ... }
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
  \code{\linkS4class{Users}}.
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
