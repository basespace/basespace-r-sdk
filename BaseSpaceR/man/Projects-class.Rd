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
\alias{Projects,missing-method}
\alias{Projects,AppAuth-method}
\alias{Projects,ProjectsSummary-method}

\alias{listProjects}
\alias{listProjects,AppAuth-method}
\alias{listProjects,Response-method}

\alias{createProject}
\alias{createProject,AppAuth-method}


\title{\code{Projects} and \code{ProjectsSummary} objects}

\description{
  Classes and methods to handle the Projects resource.
}

\details{
  The Projects resource provides a logical grouping of the Samples resource and the
  AppResults resource for a given user.
}

\section{Browsing}{
  \code{listProjects(x, ...)} lists all the available projects visable
  to the user, returning only a small summary for each project.
  \describe{
    \item{x}{is an \code{AppAuth} object.}
    \item{...}{Parameters supported by the REST API, specified as
      \code{name = value}. For example,
      \code{listProjects(x, Limit = 2)}
    }
  }
}

\section{Constructor}{
  \describe{
    \item{}{
      \code{Projects()}:
      Instantiates an empty \code{Projects} object. Same as \code{new("Projects")}.
    }
    \item{}{
      \code{Projects(x, id)}:
      \code{x} is an \code{AppAuth} object.
      \code{id} is either and integer or a character string storing an
      integer. \code{id} can have length larger that 1.
    }
    \item{}{
      \code{Projetcs(x)}:
      \code{x} is an \code{ProjectsSummary} object.
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
  \code{\linkS4class{AppAuth}}, \code{\linkS4class{Response}},
  \code{\linkS4class{Users}} and \code{\linkS4class{Runs}}.
}
\examples{
data(aAuth)

p <- listProjects(aAuth)
p

Projects(aAuth, id = c(2, 12, 1012))
Projects(p)


## Make a new project ...
createProject(aAuth, name = "My Project X")


## We need 'write global' access to be able to create a new project
\dontrun{
initializeAuth(aAuth, scope = "write global")
requestAccessToken(aAuth)

createProject(aAuth, name = "My Project X")
}

}
\keyword{classes}
\keyword{methods}
