\name{AppSessions-class}
\Rdversion{1.1}

\docType{class}

\alias{AppSessions-class}
\alias{AppSessions}
\alias{AppSessions,AppAuth-method}
\alias{AppSessions,AppResults-method}

\alias{appSessionItem}
\alias{appSessionItem-class}

\alias{listAppSessions}
\alias{listAppSessions,AppAuth-method}

\alias{updateAppSessions}
\alias{updateAppSessions,AppAuth-method}


\title{Classes \code{"AppSessions"}, \code{"appSessionItem"} and \code{"appSessionCollection"}}

\description{
  Classes and methods to hadle the AppSessions resource.
}

\section{Methods}{
  \describe{
    \item{AppSessions}{\code{signature(x = "AppAuth")}: ... }
    \item{listAppSessions}{\code{signature(x = "AppAuth")}: ... }
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
