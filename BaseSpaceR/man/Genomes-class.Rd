\name{Genomes-class}
\Rdversion{1.1}

\docType{class}

\alias{genomeItem}
\alias{genomeItem-class}
\alias{genomeCollection}
\alias{genomeCollection-class}

\alias{GenomesSummary-class}
\alias{Genomes-class}
\alias{Genomes}
\alias{Genomes,AppAuth-method}
\alias{Genomes,GenomesSummary-method}

\alias{listGenomes}
\alias{listGenomes,AppAuth-method}
\alias{listGenomes,Response-method}


\title{Classes \code{"Genomes"}, \code{"genomeItem"} and \code{"genomeCollection"}}

\description{
  Classes and methods to hadle the Genomes resource.
}

\section{Methods}{
  \describe{
    \item{Genomes}{\code{signature(x = "AppAuth")}: ... }
    \item{listGenomes}{\code{signature(x = "AppAuth")}: ... }
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
  \code{\linkS4class{Users}}, \code{\linkS4class{Response}}.
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
