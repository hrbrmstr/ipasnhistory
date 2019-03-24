context("API calls function as expected")

expect_is(ip_asn_db_meta(), "list")

expect_is(ip_history("146.185.222.49"), "list")

expect_is(
  ip_history("146.185.222.49", first="2018-11-01", last="2018-11-25"),
  "list"
)

