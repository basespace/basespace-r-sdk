\name{Response-class}
\Rdversion{1.1}
\docType{class}

\alias{Response-class}
\alias{Item-class}
\alias{Collection-class}
%%\alias{Response}


\alias{Id}
\alias{Id,Item-method}
\alias{Id,Collection-method}
\alias{Id,Response-method}

\alias{Name}
\alias{Name,Item-method}
\alias{Name,Collection-method}
\alias{Name,Response-method}

\alias{Href}
\alias{Href,Item-method}
\alias{Href,Collection-method}
\alias{Href,Response-method}

\alias{DateCreated}
\alias{DateCreated,Item-method}
\alias{DateCreated,Collection-method}
\alias{DateCreated,Response-method}

\alias{UserOwnedBy}
\alias{UserOwnedBy,Item-method}
\alias{UserOwnedBy,Collection-method}
\alias{UserOwnedBy,Response-method}

\alias{Status}
\alias{Status,Item-method}
\alias{Status,Collection-method}
\alias{Status,Response-method}

\alias{HrefBaseSpaceUI}
\alias{HrefBaseSpaceUI,Item-method}
\alias{HrefBaseSpaceUI,Collection-method}
\alias{HrefBaseSpaceUI,Response-method}

\alias{Items}
\alias{Items,Item-method}
\alias{Items,Collection-method}
\alias{Items,Response-method}

\alias{DisplayedCount}
\alias{DisplayedCount,Item-method}
\alias{DisplayedCount,Collection-method}
\alias{DisplayedCount,Response-method}

\alias{TotalCount}
\alias{TotalCount,Item-method}
\alias{TotalCount,Collection-method}
\alias{TotalCount,Response-method}

\alias{Offset}
\alias{Offset,Item-method}
\alias{Offset,Collection-method}
\alias{Offset,Response-method}

\alias{Limit}
\alias{Limit,Item-method}
\alias{Limit,Collection-method}
\alias{Limit,Response-method}

\alias{SortDir}
\alias{SortDir,Item-method}
\alias{SortDir,Collection-method}
\alias{SortDir,Response-method}

\alias{SortBy}
\alias{SortBy,Item-method}
\alias{SortBy,Collection-method}
\alias{SortBy,Response-method}

\alias{show,Item-method}
\alias{show,Collection-method}
\alias{show,Response-method}

\alias{as.list,Item-method}
\alias{as.list,Collection-method}

\alias{length,Item-method}
\alias{length,Collection-method}
\alias{length,Response-method}

\alias{$,Item-method}
\alias{$,Collection-method}
\alias{$,Response-method}

\alias{auth}
\alias{auth,Response-method}


\title{Interface \code{"Item"}, \code{"Collection"} and \code{"Response"}}
\description{
  These virtual classes provide the building block for the containers
  return by quering various resources.

  Modeled after the \code{Response} defined in the REST API.
}
\section{Objects from the Class}{
  Virtual class..
}
\section{Slots}{
  \describe{
    \item{\code{Id}:}{Object of class \code{"character"}}
    \item{\code{Name}:}{Object of class \code{"character"}}
    \item{\code{DateCreated}:}{Object of class \code{"character"}}
    \item{\code{UserOwnedBy}:}{Object of class \code{"character"}}
    \item{\code{Status}:}{Object of class \code{"character"}}
    \item{\code{HrefBaseSpaceUI}:}{Object of class \code{"character"}}
    \item{\code{Items}:}{Object of class \code{"character"}}
    \item{\code{DisplayedCount}:}{Object of class \code{"character"}}
    \item{\code{TotalCount}:}{Object of class \code{"character"}}
    \item{\code{Offset}:}{Object of class \code{"character"}}
    \item{\code{Limit}:}{Object of class \code{"character"}}
    \item{\code{SortDir}:}{Object of class \code{"character"}}
    \item{\code{SortBy}:}{Object of class \code{"character"}}
  }
}
\section{Methods}{
  \describe{
    \item{show}{Prints the object... }
    \item{as.list}{List representation of the object... }

    \item{uri}{\code{signature(x = "Item")}: ... }
  }
}
\author{
  Adrian Alexa
}

\examples{
showClass("Item")
showClass("Collection")
showClass("Response")
}
\keyword{classes}
