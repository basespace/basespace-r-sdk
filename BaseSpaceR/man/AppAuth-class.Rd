\name{AppAuth-class}
\Rdversion{1.1}

\docType{class}

\alias{AppAuth-class}
\alias{AppAuth}

\alias{initializeAuth,AppAuth-method}
\alias{initializeAuth}

\alias{requestAccessToken,AppAuth-method}
\alias{requestAccessToken}


\title{Class \code{"AppAuth"}}

\description{
  Class to manage the App credentials.
}

\section{Methods}{
  \describe{
    \item{initializeAuth}{\code{signature(x = "AppAuth")}: ... }
    \item{requestAccessToken}{\code{signature(x = "AppAuth")}: ... }
    \item{updateAppSessions}{\code{signature(x = "AppAuth")}: ... }
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
  \code{\linkS4class{ServiceURI}}.
}
\examples{
showClass("AppAuth")

data(aAuth)

}
\keyword{classes}
\section{Fields}{
  \describe{
    \item{\code{client_id}:}{Object of class \code{character} ~~ }
    \item{\code{client_secret}:}{Object of class \code{character} ~~ }
    \item{\code{uri}:}{Object of class \code{ServiceURI} ~~ }
    \item{\code{response}:}{Object of class \code{list} ~~ }
    \item{\code{curl_handle}:}{Object of class \code{CURLHandleORNULL} ~~ }
    \item{\code{access_token}:}{Object of class \code{character} ~~ }
  }
}
\section{Class-Based Methods}{
  \describe{
    \item{\code{dup_handle(headerFields)}:}{ ~~ }
    \item{\code{requestAccessToken(resource)}:}{ ~~ }
    \item{\code{show()}:}{ ~~ }
    \item{\code{doPOST(..., headerFields, postbody)}:}{ ~~ }
    \item{\code{initializeAuth(scope, resource)}:}{ ~~ }
    \item{\code{doGET(...)}:}{ ~~ }
    \item{\code{set_handle()}:}{ ~~ }
  }
}
