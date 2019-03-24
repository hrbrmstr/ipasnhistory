#' Construct a time delta value for [ip_history()]
#'
#' @param days,seconds,microseconds,milliseconds,minutes,hours,weeks time delta
#'        components. All default to `0` so just change what you need which
#'        will keep the function call fairly short in most cases.
#' @export
timedelta <- function(days=0, seconds=0, microseconds=0, milliseconds=0,
                      minutes=0, hours=0, weeks=0) {
  list(
    days = days,
    seconds = seconds,
    microseconds = microseconds,
    milliseconds = milliseconds,
    minutes = minutes,
    hours = hours,
    weeks = weeks
  )

}
