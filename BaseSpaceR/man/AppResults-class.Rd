\name{AppResults-class}
\Rdversion{1.1}

\docType{class}

\alias{appResultItem}
\alias{appResultItem-class}
\alias{appResultCollection}
\alias{appResultCollection-class}

\alias{AppResultsSummary-class}
\alias{AppResults-class}
\alias{AppResults}
\alias{AppResults,AppAuth-method}
\alias{AppResults,AppResultsSummary-method}

\alias{listAppResults}
\alias{listAppResults,AppAuth-method}
\alias{listAppResults,Projects-method}

\alias{createAppResults}
\alias{createAppResults,AppAuth-method}
\alias{createAppResults,Projects-method}


\title{Classes \code{"AppResults"}, \code{"appResultItem"} and \code{"appResultCollection"}}

\description{
  Classes and methods to hadle the AppResults resource.
}

\section{Methods}{
  \describe{
    \item{AppResults}{\code{signature(x = "AppAuth")}: ... }
    \item{listAppResults}{\code{signature(x = "AppAuth")}: ... }
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
