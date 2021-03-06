% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/db-meta.R
\name{ip_asn_db_meta}
\alias{ip_asn_db_meta}
\title{Returns meta informations about the information currently stored in the
database at the specified endpoint}
\usage{
ip_asn_db_meta(
  ip_asn_history_endpoint =
    "https://bgpranking-ng.circl.lu/ipasn_history/"
)
}
\arguments{
\item{ip_asn_history_endpoint}{supply or your own or use the default circl.lu
server provided.}
}
\description{
Returns meta informations about the information currently stored in the
database at the specified endpoint
}
\note{
If using your own server do not add the \code{/meta} at the end of the
\code{ip_asn_history_endpoint} URL parameter.
}
\examples{
ip_asn_db_meta()
}
