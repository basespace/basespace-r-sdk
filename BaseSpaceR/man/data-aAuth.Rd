\name{aAuth}

\alias{aAuth}

\docType{data}

\title{Sample \code{AppAuth} instance with 'browse global' scope}

\description{
  The \code{aAuth} is an instance of a \code{AppAuth} object.
  It can be used to browse some of the public resources available
  in BaseSpace without requireing user authentication.
}

\usage{data(aAuth)}

\source{
  Build from a pre-generated access token. See
  \code{\link{AppAuth-class}} for code examples on how-to generate
  such an object.
}

\examples{
data(aAuth)

## print the object
aAuth
}

\keyword{datasets}