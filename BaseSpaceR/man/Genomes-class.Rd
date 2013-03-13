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
\alias{Genomes,missing-method}
\alias{Genomes,AppAuth-method}
\alias{Genomes,GenomesSummary-method}

\alias{listGenomes}
\alias{listGenomes,AppAuth-method}
\alias{listGenomes,Response-method}


\title{\code{Genomes} and \code{GenomesSummary} objects}

\description{
  Classes and methods to handle the Genomes resource.
}


\section{Browsing}{
  \code{listGenomes(x, ...)} lists all the available genomes, returning
  only a small summary for each genome.
  \describe{
    \item{x}{is an \code{AppAuth} object.}
    \item{...}{Parameters supported by the REST API, specified as
      \code{name = value}. For example,
      \code{listGenomes(aAuth, Offset = 5, Limit = 2)}
    }
  }
}

\section{Constructor}{
  \describe{
    \item{}{
      \code{Genomes()}:
      Instantiates an empty \code{Genomes} object. Same as \code{new("Genomes")}.
    }
    \item{}{
      \code{Genomes(x, id)}:
      \code{x} is an \code{AppAuth} object.
      \code{id} is either and integer or a character string storing an
      integer. \code{id} can have length larger that 1.
    }
    \item{}{
      \code{Genomes(x)}:
      \code{x} is an \code{GenomesSummary} object.
    }
  }
}


\references{
  https://developer.basespace.illumina.com/docs/content/documentation/rest-api/api-reference
}

\author{
  Adrian Alexa
}

\seealso{
  \code{\linkS4class{AppAuth}}, \code{\linkS4class{Response}}.
}

\examples{

data(aAuth)

## list all available genomes
g <- listGenomes(aAuth)
g$SpeciesName

## using the REST API query parameters
listGenomes(aAuth, Limit = 2)
g <- listGenomes(aAuth, Offset = 5, Limit = 2, SortBy = "Build")
g

## get the details for the listed geneomes
Genomes(g)

## get the genomes based on their ID
Genomes(aAuth, id = 4)
## if the ID is missing thean NULL is returned for that particular ID
Genomes(aAuth, id = c(4, 1, 110))

}
\keyword{classes}
\keyword{methods}

