% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/gapsMapRun.R
\name{gapsMapRun}
\alias{gapsMapRun}
\title{\code{gapsMapRun} calls the C++ MCMC code and performs Bayesian
matrix factorization returning the two matrices that reconstruct
the data matrix; as opposed to gapsRun, this method takes an
additional input specifying set patterns in the P matrix}
\usage{
gapsMapRun(D, S, FP, ABins = data.frame(), PBins = data.frame(),
  nFactor = 5, simulation_id = "simulation", nEquil = 1000,
  nSample = 1000, nOutR = 1000, output_atomic = "FALSE",
  fixedMatrix = "P", fixedBinProbs = "FALSE", fixedDomain = "N",
  sampleSnapshots = "TRUE", numSnapshots = 100, alphaA = 0.01,
  nMaxA = 1e+05, max_gibbmass_paraA = 100, alphaP = 0.01, nMaxP = 1e+05,
  max_gibbmass_paraP = 100)
}
\arguments{
\item{D}{data matrix}

\item{S}{uncertainty matrix (std devs for chi-squared of Log Likelihood)}

\item{FP}{data.frame with rows giving fixed patterns for P}

\item{ABins}{a matrix of same size as A which gives relative
probability of that element being non-zero}

\item{PBins}{a matrix of same size as P which gives relative
probability of that element being non-zero}

\item{nFactor}{number of patterns (basis vectors, metagenes), which must be
greater than or equal to the number of rows of FP}

\item{simulation_id}{name to attach to atoms files if created}

\item{nEquil}{number of iterations for burn-in}

\item{nSample}{number of iterations for sampling}

\item{nOutR}{how often to print status into R by iterations}

\item{output_atomic}{whether to write atom files (large)}

\item{fixedMatrix}{character indicating whether A or P matrix
has fixed columns or rows respectively}

\item{fixedBinProbs}{Boolean for using relative probabilities
given in Abins and Pbins}

\item{fixedDomain}{character to indicate whether A or P is
domain for relative probabilities}

\item{sampleSnapshots}{Boolean to indicate whether to capture
individual samples from Markov chain during sampling}

\item{numSnapshots}{the number of individual samples to capture}

\item{alphaA}{sparsity parameter for A domain}

\item{nMaxA}{PRESENTLY UNUSED, future = limit number of atoms}

\item{max_gibbmass_paraA}{limit truncated normal to max size}

\item{alphaP}{sparsity parameter for P domain}

\item{nMaxP}{PRESENTLY UNUSED, future = limit number of atoms}

\item{max_gibbmass_paraP}{limit truncated normal to max size}
}
\description{
\code{gapsMapRun} calls the C++ MCMC code and performs Bayesian
matrix factorization returning the two matrices that reconstruct
the data matrix; as opposed to gapsRun, this method takes an
additional input specifying set patterns in the P matrix
}


\details{The decomposition in GAPS is achieved by finding amplitude and pattern matrices (\eqn{{\bf{A}}} and \eqn{{\bf{P}}}, respectively) for which \deqn{{\bf{D}} = {\bf{A}}{\bf{P}} + \Sigma}, where \eqn{\Sigma} is the matrix of uncertainties given by S.  The matrices \eqn{\bf{A}} and \eqn{\bf{P}} are assumed to have the atomic prior described in Sibisi and Skilling (1997) and are found with MCMC sampling. However, some rows of \eqn{\bf{P}} are fixed to be the values specified in the input argument \code{FP} after rescaling to have norm 1.}

\value{
  A list containing:
  \item{Amean}{Sampled mean value of the amplitude matrix \eqn{{\bf{A}}}.}
  \item{Asd}{Sampled standard deviation of the amplitude matrix \eqn{{\bf{A}}}.}
  \item{Pmean}{Sampled mean value of the amplitude matrix \eqn{{\bf{P}}}.}
  \item{Psd}{Sampled standard deviation of the amplitude matrix \eqn{{\bf{P}}}.}
  \item{atomsAEquil}{Number of atoms in \eqn{{\bf{A}}} during each iteration of the equilibration phase.}
  \item{atomsASamp}{Number of atoms in \eqn{{\bf{A}}} during each iteration of the sampling phase.}
  \item{atomsPEquil}{Number of atoms in \eqn{{\bf{P}}} during each iteration of the equilibration phase.}
  \item{atomsPSamp}{Number of atoms in \eqn{{\bf{P}}} during each iteration of the sampling phase.}
  \item{chiSqValues}{Value of \eqn{chi^2} at each step during equilibration and sampling.} 
  \item{meanChi2}{Value of \eqn{chi^2} for Amean and Pmean.}
  \item{ASnapshots}{Samples of A matrices taken during sampling.}
  \item{PSnapshots}{Samples of P matrices taken during sampling.}
}

\examples{
\dontrun{
## Load data
data('SimpSim')

## Specify the fixed pattern
mapP <- matrix(0,nrow=2,ncol=20)
mapP[1,1:10] <- 1
mapP[2,11:20] <- 1

## Run the GAPS matrix decomposition
testmap <- gapsMapRun(SimpSim.D, SimpSim.S, FP=mapP, 
                      nFactor=3,nEquil = 1000,nSample = 1000)


## Compare fixed patterns to input patterns (after scaling)
summary(t(testmap$Pmean[2:3,] - sweep(mapP,1,apply(mapP,1,sum),FUN="/")))
}
}

\seealso{\code{\link{CoGAPS}},\code{\link{gapsRun}}}
\keyword{misc}


