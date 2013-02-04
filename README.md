Introduction
=========================================

The BaseSpaceR package provides a complete R interface to Illumina's BaseSpace REST API, enabling the fast development of data analysis and visualisation tools. Besides providing an easy to use set of methods for manipulating the data from BaseSpace, it also facilitate the access to a rich environment of statistical and data analysis open source tools.

Features include:
- Persistent connection with the REST server.
- Support for the REST API query parameters.
- Vectorized operations in line with the R semantic. Allows for queries across multiple Projects, Samples, AppResults, Files, etc.
- S4 class system used to represent the BaseSpace data model [under development].
- Templates for uploading and creating AppResults.


Authors
=========================================

Adrian Alexa


Requirements
=========================================

Some familiarity with the BaseSpace API and the R environment is assumed. The R environment (see the R project at http://www.r-project.org) must be already installed. You will need to have R 2.14.0 or later to be able to install and run BaseSpaceR. The following two R packages must also be installed: RCurl and RJSONIO (we recommend using the latest version of these packages). 


Installation
=========================================

This section briefly describe the necessary steps to get BaseSpaceR running on your system. The BaseSpaceR package is available from the Github repository:

	git clone git@github.com:basespace/basespace-r-sdk.git

We can install the package globally by running the following command:

	R CMD INSTALL BaseSpaceR

However, sometimes it is desirable (if the users doesn't have control over the R installation) to install the libraries locally. In order to do this the user needs to set the R_LIBS environment variable.

	export R_LIBS='/path/to/local/Rlibs'

Once this is set, install the package under the R_LIBS directory

	R CMD INSTALL BaseSpaceR -l/path/to/local/Rlibs


Loading the package
=========================================

From within R, load the library using:

	> library(BaseSpaceR)

Note that when the package is loaded, both RCurl and RJSONIO packages are automatically loaded, so the user doesn't need to explicitly load these libraries if he wants to make use of their functionality.


Feature Request and Bugs
=========================================

Please feel free to report any feedback regarding the R SDK directly to the repository R API Repository, we appreciate any and all feedback about the SDKs. We will do anything we can to improve the SDK and make it easy for developers to use the SDK.


Copying / License
=========================================

See LICENSE file in the BaseSpaceR directory for details on licensing and distribution.
