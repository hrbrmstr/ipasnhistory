#' Retrieve IP ASN advertisement history
#'
#' @note If you want to resolve more than 1000 IPs, use [mass_cache()] and [mass_query()]
#' @param ip (required) IP to lookup
#' @param source (optional) Source to query (defaults to 'caida') - currently, only caida is supported
#' @param address_family (optional) `v4` or `v6` (defaults to v4)
#' @param date (optional) Exact date to lookup (defaults to most recent available). Can
#'        be a date-y/time-y-ish R object or a "YYYY-mm-dd" string
#' @param first,last (optional) First/last date in the interval. Same value format restrictions as `date` param
#' @param precision_delta (optional) Max delta allowed between the date queried and the one we have in the database.
#'        Use [timedelta()] to construct the value for this parameter.
#' @param ip_asn_history_endpoint supply or your own or use the default circl.lu
#'        server provided.
#' @export
#' @examples
#' ip_history("146.185.222.49")
#' ip_history("146.185.222.49", first="2018-11-01", last="2018-11-25")
ip_history <- function(ip,
                       source = "caida",
                       address_family = c("v4", "v6"),
                       date = NULL,
                       first = NULL,
                       last = NULL,
                       precision_delta = NULL,
                       ip_asn_history_endpoint =
                         "https://bgpranking-ng.circl.lu/ipasn_history/") {

  ip <- ip[1]
  source <- match.arg(source[1], "caida")
  address_family <- match.arg(address_family[1], c("v4", "v6"))

  if (!is.null(date)) date <- as.character(as.Date(date[1]))
  if (!is.null(first)) first <- as.character(as.Date(first[1]))
  if (!is.null(last)) last <- as.character(as.Date(last[1]))
  if (!is.null(precision_delta)) {
    stopifnot(
      all(
        names(precision_delta) %in%
          c("days", "seconds", "microseconds",
            "milliseconds", "minutes", "hours", "weeks")
      )
    )
  }

  httr::POST(
    url = ip_asn_history_endpoint,
    encode = "json",
    body = list(
      ip = ip,
      source = source,
      address_family = address_family,
      date = date,
      first = first,
      last = last,
      precision_delta = precision_delta
    ),
    .IPASNHISTORY_UA
  ) -> res

  httr::stop_for_status(res)

  out <- httr::content(res, as = "text", encoding = "UTF-8")

  out <- jsonlite::fromJSON(out)

  out

}
