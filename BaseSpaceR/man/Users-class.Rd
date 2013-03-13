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
  The Users resource allows the client to get basic information about the user
  that is currently using the application.

  To query this resource we use the \code{Users()} method.
}

\section{Constructor}{
  \describe{
    \item{}{
      \code{Users()}:
      Instantiates an empty \code{Users} object. Same as \code{new("Users")}.
    }
    \item{}{
      \code{Users(x)}:
      \code{x} is an AppAuth object. The function returns a
      \code{Response} object of class \code{Users}.
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

data(aAuth)

## Empty instance
Users()

## Quering the Users resource using the AppAuth handler
u <- Users(aAuth)
## Printing the object shows the response elements
u


## Accesors
Id(u)
Name(u)
## Using the general '$' accesor, same interface as 'list'
u$Id
u$Email # there is no accesor method Email(), so '$' is useful here!
u$fakeElement # returns NULL (to keep the same semantic as 'list')


## Quering the resource unsing a Response object
Users(u) # u is of class Users which extends Response


## Specifying a user ID. ID can be specify either as an integer or as a string
Users(aAuth, id = 1463464) # must work if given as an integer(even of mode numeric)
Users(aAuth, id = "1463464") # must work

## This should fail since is not the current user
tryCatch(Users(aAuth, id = "660666"), error = function(e) cat("No access to this user data!\n"))

}
\keyword{classes}
\keyword{methods}
