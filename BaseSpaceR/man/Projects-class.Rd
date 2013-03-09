\name{Projects-class}
\Rdversion{1.1}

\docType{class}

\alias{projectItem}
\alias{projectItem-class}
\alias{projectCollection}
\alias{projectCollection-class}

\alias{ProjectsSummary-class}
\alias{Projects-class}
\alias{Projects}
\alias{Projects,AppAuth-method}
\alias{Projects,ProjectsSummary-method}

\alias{listProjects}
\alias{listProjects,AppAuth-method}
\alias{listProjects,Response-method}

\alias{createProject}
\alias{createProject,AppAuth-method}


\title{Classes \code{"Projects"}, \code{"ProjectsSummary"} and \code{"projectItem"}}

\description{
  Classes and methods to hadle the Projects resource.
}

\section{Methods}{
  \describe{
    \item{Projects}{\code{signature(x = "AppAuth")}: ... }
    \item{listProjects}{\code{signature(x = "AppAuth")}: ... }
    \item{createProject}{\code{signature(x = "AppAuth")}: ... }
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
  \code{\linkS4class{Users}} and \code{\linkS4class{Runs}}.
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
