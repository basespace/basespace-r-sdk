\name{BaseSpaceR-package}
\alias{BaseSpaceR-package}
\alias{BaseSpaceR}

\docType{package}

\title{R SDK for BaseSpace RESTful API}

\description{
  The \code{BaseSpaceR} package provides a complete R interface to Illumina's BaseSpace 
  REST API, enabling the fast development of data analysis and visualisation tools.
}

\details{
  
  BaseSpace is Illumina's next-generation sequencing cloud computing
  environment designed with biologists in mind. Researcher can easily
  store, analyze, collaborate, and share genetic data
  (https://basespace.illumina.com).

  The package is intended to be a SDK, ofering methods and data
  structures for working with the data resources BaseSpace has to offer.
  
  Features include:
  \describe{
    \item{*}{Persistent connection with the REST server.}
    \item{*}{Support for the REST API query parameters.}
    \item{*}{Vectorized operations in line with the R semantic. Allows for queries across multiple Projects, Samples, AppResults, Files, etc.}
    \item{*}{S4 class system used to represent the BaseSpace data model.}
  }
}

\author{
  Adrian Alexa
  
  Maintainer: Adrian Alexa <aalexa@illumina.com>
}

\references{
  BaseSpace: https://basespace.illumina.com
  
  BaseSpace API: https://developer.basespace.illumina.com
}

\seealso{
  \code{\link{AppAuth-class}}, etc...
}


\keyword{package}
