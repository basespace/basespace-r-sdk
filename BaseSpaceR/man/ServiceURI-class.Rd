\name{ServiceURI-class}
\Rdversion{1.1}
\docType{class}

\alias{ServiceURI-class}
\alias{ServiceURI}



%%\alias{GET,ServiceURI-method}
%%\alias{POST,ServiceURI-method}
%%\alias{POSTForm,ServiceURI-method}
\alias{show,ServiceURI-method}
\alias{uri,ServiceURI-method}
\alias{uri}


\title{Class \code{"ServiceURI"}}
\description{
  The ServiceURI class is a general container for storing the URI of a
  REST based Web service.
}
\section{Objects from the Class}{
  Objects can be created by calls of the form \code{ServiceURI()}.
  \code{ServiceURI()} creates an \code{ServiceURI} instances out of
  an URL and an API resource.
}
\section{Slots}{
  \describe{
    \item{\code{url}:}{Object of class \code{"character"} ~~ }
    \item{\code{version}:}{Object of class \code{"character"} ~~ }
  }
}
\section{Methods}{
  \describe{
    \item{show}{\code{signature(object = "ServiceURI")}: ... }
    \item{uri}{\code{signature(x = "ServiceURI")}: ... }
    
  }
}
\author{
  Adrian Alexa
}

\examples{
showClass("ServiceURI")
}
\keyword{classes}
\keyword{methods}
