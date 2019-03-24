httr::user_agent(
  sprintf(
    "ipasnhistory package v%s: (<%s>)",
    utils::packageVersion("ipasnhistory"),
    utils::packageDescription("ipasnhistory")$URL
  )
) -> .IPASNHISTORY_UA