\name{Users-class}
\Rdversion{1.1}

\docType{class}

\alias{Users}
\alias{Users-class}

\alias{userItem}
\alias{userItem-class}

\alias{Users}
\alias{Users,missing-method}
\alias{Users,AppAuth-method}
\alias{Users,Response-method}


\title{\code{Users} objects and resources}

\description{
  Class to manage the Users resource.
}

\details{
  ...
}

\section{Constructor}{
  \describe{
    \item{}{
      \code{Users()}:
      Instantiates an empty \code{Users} object. Same as \code{new("Users")}.
    }
    \item{}{
      \code{Users(x)}:
      \code{x} is an AppAuth object. This constructor
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
  \code{\linkS4class{Response}}.
}
\examples{

## empty object
Users()

## handle to communicate with BaseSpace server
data(aAuth)

## Quering the Users resource using the AppAuth handler
u <- Users(aAuth)
u

## Accesors
Id(u)
Name(u)
## Using the general '$' accesor
u$Id
u$Email # there is no accesor method Email(), so '$' is useful here!

## Quering the resource unsing a Response object
Users(u) # u is of class Users which extends Response

## specifying a user ID
Users(aAuth, id = 1463464) # must work if given as an integer(even of mode numeric)
Users(aAuth, id = "1463464") # must work

#Users(aAuth, id = "660666") # fails since is not the proper user

}
\keyword{classes}
\keyword{methods}
