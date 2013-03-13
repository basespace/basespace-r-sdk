\name{Runs-class}
\Rdversion{1.1}

\docType{class}

\alias{runItem}
\alias{runItem-class}
\alias{runCollection}
\alias{runCollection-class}

\alias{RunsSummary-class}
\alias{Runs}
\alias{Runs-class}
\alias{Runs,missing-method}
\alias{Runs,AppAuth-method}
\alias{Runs,RunsSummary-method}


\alias{listRuns}
\alias{listRuns,AppAuth-method}
\alias{listRuns,Response-method}


\title{\code{Runs} and \code{RunsSummary} objects}

\description{
  Classes and methods to handle the Runs resource.
}

\details{
  The Runs resource contains the raw data produced by the instruments, the base calls,
  together with run metrics, instrument health data, and other information used for
  data processing and analysis.
}


\section{Browsing}{
  \code{listRuns(x, ...)} lists all the available runs visable to the user, returning
  only a small summary for each run.
  \describe{
    \item{x}{is an \code{AppAuth} object.}
    \item{...}{Parameters supported by the REST API, specified as
      \code{name = value}. For example,
      \code{listRuns(x, Limit = 2, Statuses = "Failed")}
    }
  }
}

\section{Constructor}{
  \describe{
    \item{}{
      \code{Runs()}:
      Instantiates an empty \code{Runs} object. Same as \code{new("Runs")}.
    }
    \item{}{
      \code{Runs(x, id)}:
      \code{x} is an \code{AppAuth} object.
      \code{id} is either and integer or a character string storing an
      integer. \code{id} can have length larger that 1.
    }
    \item{}{
      \code{Runs(x)}:
      \code{x} is an \code{RunsSummary} object.
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
  \code{\linkS4class{AppAuth}},
  \code{\linkS4class{Response}}, and \code{\linkS4class{Users}}.
}

\examples{
data(aAuth)

r <- listRuns(aAuth)
r

listRuns(aAuth, Statuses = "Failed") # no faild runs
listRuns(aAuth, Statuses = "Complete")
listRuns(aAuth, SortBy = "Id", SortDir="Desc")

Runs(r)[[1]]


Runs(aAuth, id = 101102)
Runs(r)

Runs(aAuth, id = c(Id(r), "11111")) # the third element must be NULL

}

\keyword{classes}
\keyword{methods}
