#List files to be processed
# .aprt is a 4-letter ICAO designator, set "*" for all
# .year is a 4-digit year, set "*" for all
# . opr is either "DEP" for departures or "ARR" for arrivals/landings

list_apt_files <- function(.year = "*", .path = "./data-raw/"){
  ptn <- paste0("flightlist_*.", .year, ".*.")
  fns <- list.files(.path, ptn)
  full_fns <- c(paste0(.path, fns))
  return(full_fns)
}

