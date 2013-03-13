\name{Samples-class}
\Rdversion{1.1}

\docType{class}

\alias{sampleItem}
\alias{sampleItem-class}
\alias{sampleCollection}
\alias{sampleCollection-class}

\alias{SamplesSummary-class}
\alias{Samples-class}
\alias{Samples}
\alias{Samples,AppAuth-method}
\alias{Samples,missing-method}
\alias{Samples,SamplesSummary-method}

\alias{listSamples}
\alias{listSamples,AppAuth-method}
\alias{listSamples,Projects-method}


\title{\code{Samples} and \code{SamplesSummary} objects }

\description{
  Classes and methods to handle the Samples resource.
}


\details{
  In general samples are the result of demultiplexing and are thought as the holding the
  input data for an App. One example of data within a Samples resource are the FASTQ files.
}

\section{Browsing}{
  \code{listSamples(x, projectId, ...)} lists all the available samples
  associated with a particular project. It returns a small summary for
  each existing sample.
  \describe{
    \item{x}{is an \code{AppAuth} object.}
    \item{projectId}{the ID of the project we want to explore.}
    \item{...}{Parameters supported by the REST API, specified as
      \code{name = value}.
      For example, \code{listSamples(x, projectId = "1", Limit = 2)}
    }
  }
  
  \code{listSamples(x, ...)}
  \describe{
    \item{x}{is an \code{Projects} object.}
    \item{...}{Parameters supported by the REST API.}
  }
}

\section{Constructor}{
  \describe{
    \item{}{
      \code{Samples()}:
      Instantiates an empty \code{Samples} object. Same as \code{new("Samples")}.
    }
    \item{}{
      \code{Samples(x, id)}:
      \code{x} is an \code{AppAuth} object.
      \code{id} is either and integer or a character string storing an
      integer. \code{id} can have length larger that 1.
    }
    \item{}{
      \code{Samples(x)}:
      \code{x} is an \code{SamplesSummary} object.
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
  \code{\linkS4class{AppAuth}} and \code{\linkS4class{Projects}}.
}
\examples{
data(aAuth)

## list all the available projects and select one
p <- Projects(listProjects(aAuth, Limit = 1), simplify = TRUE)
p

## list the samples available in this project
allS <- listSamples(aAuth, projectId = Id(p))

##  we can call listSamples() directly using 'p'
identical(allS, listSamples(p))


oneS <- listSamples(aAuth, projectId = Id(p), Limit = 1)
oneS
Samples(oneS) # list with one Samples object
Samples(oneS, simplify = TRUE) # Samples object

}
\keyword{classes}
\keyword{methods}

