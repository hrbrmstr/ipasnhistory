#' Returns meta informations about the information currently stored in the
#' database at the specified endpoint
#'
#' @note If using your own server do not add the `/meta` at the end of the
#'       `ip_asn_history_endpoint` URL parameter.
#' @param ip_asn_history_endpoint supply or your own or use the default circl.lu
#'        server provided.
#' @export
#' @usage
#' ip_asn_db_meta(
#'   ip_asn_history_endpoint =
#'     "https://bgpranking-ng.circl.lu/ipasn_history/"
#' )
#' @examples
#' ip_asn_db_meta()
ip_asn_db_meta <- function(ip_asn_history_endpoint =
                             "https://bgpranking-ng.circl.lu/ipasn_history/") {


  meta_endpoint <- file.path(ip_asn_history_endpoint, "/meta")
  meta_endpoint <- httr::parse_url(meta_endpoint)
  meta_endpoint$path <- gsub("[/]{2,}", "/", meta_endpoint$path)
  meta_endpoint <- httr::build_url(meta_endpoint)

  httr::GET(
    url = meta_endpoint,
    .IPASNHISTORY_UA
  ) -> res

  httr::stop_for_status(res)

  out <- httr::content(res, as = "text", encoding = "UTF-8")

  out <- jsonlite::fromJSON(out)

  out
}