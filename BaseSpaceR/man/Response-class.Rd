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


\title{\code{Item}, \code{Collection} and \code{Response} objects}

\description{
  These virtual classes provide the building block for the containers
  return by quering various resources.

  Modeled after the \code{Response} defined in the REST API.
}

\section{Objects from the Class}{
  Virtual class..
}

\section{Accessors}{
  In the following \code{x} is an Item object.

  \describe{
    \item{}{
      \code{$}:
      The \code{$} operator can be used to access the class slots. When
      \code{x} is an Item object this is equivalet to \code{@}. But you
      can think at it as user level operator. Unlike \code{@} the
      replace method is not implemented for \code{$}.
    }
    \item{}{
      \code{Id(x)}:
      Id of the resource. Character string, though it will always be an integer.
    }
    \item{}{
      \code{Name(x)}:
      Name of the selected resource.
    }
    \item{}{
      \code{Href(x)}:
      Location of the resource in the API. The first component of the
      URI is the version of the REST API.
    }
    \item{}{
      \code{DateCreated(x)}:
      When this resource was created. Character string. It can be
      converted to a \code{Date} instace by \code{as.Date(DateCreated(x))}.
    }
    \item{}{
      \code{UserOwnedBy(x)}:
      Information about the User who owns this resource. At this moment
      this is a \code{list} object, but it might be replace with
      an object at a future point.
    }
    \item{}{
      \code{Status(x)}:
      The status of the resource. Can be of any type and it will be
      defined by the classes extended Item.
    }
    \item{}{
      \code{HrefBaseSpaceUI(x)}:
      The location of this project in BaseSpace. Character string giving
      the complete URL within the BaseSpace dashboard.
    }
  }


  In the following \code{x} is a Collection object.
  \describe{
    \item{}{
      All accesor implemented by the item class are implemented by
      Collection class. however here the return value is a vector. If
      \code{x} has 2 elements, then Id(x) will be a vector with 2
      elements. The same stands for the general accessor \code{$}.
    }
    \item{}{
      \code{length(x)}:
      Returns the number of elements in Collection \code{x}.
    }
    \item{}{
      \code{Items(x)}:
      List of Item objects.
    }
    \item{}{
      \code{TotalCount(x)}:
      The total number of items in the collection as reported by the
      queried resource.
    }
    \item{}{
      \code{Offset(x)}:
      The starting point the collection was read from.
    }
    \item{}{
      \code{Limit(x)}:
      The maximum number of items returned. Ranges from 0 to 1024.
    }
    \item{}{
      \code{SortDir(x)}:
      The way the collection is sorted, either ascending or descending.
    }
    \item{}{
      \code{SortBy(x)}:
      The field to use to sort the collection.
    }
  }
  In the following \code{x} is a Collection object.
}


\section{Subsetting}{
  Comming soon ...
}


\section{Methods}{
  \describe{
    \item{}{
      \code{length(x)}:
      Returns the number of elements in Collection \code{x}.
    }

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
\keyword{methods}
