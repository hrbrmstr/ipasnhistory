#' Mass query IP ASN history info
#'
#' Use this path when you have lots of query to run and (>1000)
#' in order to resolve all of them at once and wait for the results.
#' See Details for how to specify parameter values
#'
#' This is a bulk cache/lookup function. If `source`, `address_family`, `date`,
#' `first`, `last`, `precision_delta` are not either `NULL` or length 1 (
#' for `precision_delta` that means a single list retrieved from [timedelta()])
#' then they *must be the same length as `ips`*, since the API expects
#' a full parameter list for each IP being queried for and there's no way
#' for this function to intuit what you need outside of these specified rules.
#'
#' @note If using your own server do not add the `/mass_query` at the end of the
#'       `ip_asn_history_endpoint` URL parameter.
#' @param ips (required) character vector of IPs to lookup
#' @param source (optional) Source to query (defaults to 'caida') - currently, supports CAIDA & RIPE NCC sources
#' @param address_family (optional) `v4` or `v6` (defaults to v4)
#' @param date (optional) Exact date to lookup (defaults to most recent available). Can
#'        be a date-y/time-y-ish R object or a "YYYY-mm-dd" string
#' @param first,last (optional) First/last date in the interval. Same value format restrictions as `date` param
#' @param precision_delta (optional) Max delta allowed between the date queried and the one we have in the database.
#'        Use [timedelta()] to construct the value for this parameter.
#' @param ip_asn_history_endpoint supply or your own or use the default circl.lu
#'        server provided.
#' @export
mass_query <- function(ips,
                       source = NULL,
                       address_family = NULL,
                       date = NULL,
                       first = NULL,
                       last = NULL,
                       precision_delta = NULL,
                       ip_asn_history_endpoint =
                         "https://bgpranking-ng.circl.lu/ipasn_history/") {

  stopifnot(is.null(source) || length(source) == 1 || length(source) == length(ips))
  stopifnot(is.null(address_family) || length(address_family) == 1 || length(address_family) == length(ips))
  stopifnot(is.null(date) || length(date) == 1 || length(date) == length(ips))
  stopifnot(is.null(first) || length(first) == 1 || length(first) == length(ips))
  stopifnot(is.null(last) || length(last) == 1 || length(last) == length(ips))

  if (!is.null(date)) date <- as.character(as.Date(date))
  if (!is.null(first)) first <- as.character(as.Date(first))
  if (!is.null(last)) last <- as.character(as.Date(last))

  if (!is.null(source) && (length(source) == 1)) source <- rep(source, length(ips))
  if (!is.null(address_family) && (length(address_family) == 1)) address_family <- rep(address_family, length(ips))
  if (!is.null(date) && (length(date) == 1)) date <- rep(date, length(ips))
  if (!is.null(first) && (length(first) == 1)) first <- rep(first, length(ips))
  if (!is.null(last) && (length(last) == 1)) last <- rep(last, length(ips))
  if (!is.null(precision_delta)) {
    if (all(names(precision_delta) %in%
            c("days", "seconds", "microseconds",
              "milliseconds", "minutes", "hours", "weeks"))) { # "length 1"
      precision_delta <- rep(list(precision_delta), length(ips))
    } else {
      stopifnot(length(precision_delta) == length(ips))
    }
  }

  lapply(1:length(ips), function(i) {

    ret <- list(ip = ips[1])

    if (!is.null(source)) ret[["source"]] <- source[i]
    if (!is.null(address_family)) ret[["address_family"]] <- address_family[i]
    if (!is.null(date)) ret[["date"]] <- date[i]
    if (!is.null(first)) ret[["first"]] <- first[i]
    if (!is.null(last)) ret[["last"]] <- last[i]
    if (!is.null(precision_delta)) ret[["precision_delta"]] <- precision_delta[i]

    ret

  }) -> dict

  mass_query_endpoint <- file.path(ip_asn_history_endpoint, "/mass_query")
  mass_query_endpoint <- httr::parse_url(mass_query_endpoint)
  mass_query_endpoint$path <- gsub("[/]{2,}", "/", mass_query_endpoint$path)
  mass_query_endpoint <- httr::build_url(mass_query_endpoint)

  httr::POST(
    url = mass_query_endpoint,
    encode = "json",
    body = dict,
    .IPASNHISTORY_UA
  ) -> res

  httr::stop_for_status(res)

  out <- httr::content(res, as = "text", encoding = "UTF-8")

  out <- jsonlite::fromJSON(out)

  out

}
