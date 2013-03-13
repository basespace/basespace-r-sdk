\name{AppAuth-class}
\Rdversion{1.1}

\docType{class}

\alias{AppAuth-class}
\alias{AppAuth}

\alias{initializeAuth,AppAuth-method}
\alias{initializeAuth}

\alias{requestAccessToken,AppAuth-method}
\alias{requestAccessToken}

\alias{hasAccess,AppAuth-method}
\alias{hasAccess}


\title{\code{AppAuth} class}

\description{
  Class to manage the App permissions and communication with the server.
}


\section{Methods}{
  \describe{
    \item{initializeAuth}{\code{signature(x = "AppAuth")}: ... }
    \item{requestAccessToken}{\code{signature(x = "AppAuth")}: ... }
    \item{hasAccess}{\code{signature(x = "AppAuth")}: ... }
  }
}
\references{
  https://developer.basespace.illumina.com/docs/content/documentation/rest-api/api-reference
}
\author{
  Adrian Alexa
}


\seealso{
  \code{\linkS4class{ServiceURI}}.
}
\examples{
showClass("AppAuth")

data(aAuth)
aAuth

hasAccess(aAuth)
}
\keyword{classes}
\keyword{methods}
