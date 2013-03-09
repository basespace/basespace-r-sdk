\name{Users-class}
\Rdversion{1.1}

\docType{class}

\alias{Users}
\alias{Users-class}

\alias{userItem}
\alias{userItem-class}

\alias{Users}
\alias{Users,AppAuth-method}
\alias{Users,Response-method}


\title{Classes \code{"Users"} and \code{"userItem"}}

\description{
  Class to manage the Users resource.
}

\section{Methods}{
  \describe{
    \item{Users}{\code{signature(x = "AppAuth")}: ... }
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
