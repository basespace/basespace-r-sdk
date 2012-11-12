\name{AppAuth-class}
\Rdversion{1.1}

\docType{class}

\alias{AppAuth-class}
\alias{AppAuth}

\alias{initializeAuth,AppAuth-method}
\alias{initializeAuth}

\alias{requestAccessToken,AppAuth-method}
\alias{requestAccessToken}


\alias{getCoverage,AppAuth-method}
\alias{getCoverage}
\alias{getCoverageStats,AppAuth-method}
\alias{getCoverageStats}

\alias{getVariants,AppAuth-method}
\alias{getVariantSet,AppAuth-method}
\alias{getVariants}
\alias{getVariantSet}

\alias{listAppSessions,AppAuth-method}
\alias{listAppSessions}
\alias{updateAppSessions,AppAuth-method}
\alias{updateAppSessions}


\alias{listFiles,AppAuth,ANY-method}
\alias{listFiles,AppAuth,missing-method}
\alias{listFiles}
\alias{getFiles,AppAuth-method}
\alias{getFiles}

\alias{listGenomes,AppAuth-method}
\alias{listGenomes}

\alias{listProjects,AppAuth-method}
\alias{listProjects}
\alias{createProject,AppAuth-method}
\alias{createProject}

\alias{listResults,AppAuth,ANY-method}
\alias{listResults,AppAuth,missing-method}
\alias{listResults}
\alias{createResults,AppAuth-method}
\alias{createResults}


\alias{listRuns,AppAuth-method}
\alias{listRuns}

\alias{listSamples,AppAuth,ANY-method}
\alias{listSamples,AppAuth,missing-method}
\alias{listSamples}

\alias{listUsers,AppAuth-method}
\alias{listUsers}



\title{Class \code{"AppAuth"}}

\description{
  Class to manage the App credentials.
}

\section{Methods}{
  \describe{
    \item{createProject}{\code{signature(x = "AppAuth")}: ... }
    \item{createResults}{\code{signature(x = "AppAuth")}: ... }
    \item{getCoverage}{\code{signature(x = "AppAuth")}: ... }
    \item{getCoverageStats}{\code{signature(x = "AppAuth")}: ... }
    \item{getFiles}{\code{signature(x = "AppAuth")}: ... }
    \item{getVariants}{\code{signature(x = "AppAuth")}: ... }
    \item{getVariantSet}{\code{signature(x = "AppAuth")}: ... }
    \item{initializeAuth}{\code{signature(x = "AppAuth")}: ... }
    \item{listAppSessions}{\code{signature(x = "AppAuth")}: ... }
    \item{listFiles}{\code{signature(x = "AppAuth", id = "ANY")}: ... }
    \item{listFiles}{\code{signature(x = "AppAuth", id = "missing")}: ... }
    \item{listGenomes}{\code{signature(x = "AppAuth")}: ... }
    \item{listProjects}{\code{signature(x = "AppAuth")}: ... }
    \item{listResults}{\code{signature(x = "AppAuth", id = "ANY")}: ... }
    \item{listResults}{\code{signature(x = "AppAuth", id = "missing")}: ... }
    \item{listRuns}{\code{signature(x = "AppAuth")}: ... }
    \item{listSamples}{\code{signature(x = "AppAuth", id = "ANY")}: ... }
    \item{listSamples}{\code{signature(x = "AppAuth", id = "missing")}: ... }
    \item{listUsers}{\code{signature(x = "AppAuth")}: ... }
    \item{requestAccessToken}{\code{signature(x = "AppAuth")}: ... }
    \item{updateAppSessions}{\code{signature(x = "AppAuth")}: ... }
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
  \code{\linkS4class{ServiceURI}}.
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
    \item{\code{response}:}{Object of class \code{list} ~~ }
    \item{\code{curl_handle}:}{Object of class \code{CURLHandleORNULL} ~~ }
    \item{\code{access_token}:}{Object of class \code{character} ~~ }
  }
}
\section{Class-Based Methods}{
  \describe{
    \item{\code{dup_handle(headerFields)}:}{ ~~ }
    \item{\code{requestAccessToken(resource)}:}{ ~~ }
    \item{\code{show()}:}{ ~~ }
    \item{\code{doPOST(..., headerFields, postbody)}:}{ ~~ }
    \item{\code{initializeAuth(scope, resource)}:}{ ~~ }
    \item{\code{doGET(...)}:}{ ~~ }
    \item{\code{set_handle()}:}{ ~~ }
  }
}
