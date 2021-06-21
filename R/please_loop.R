open_sky <- read.csv("./data-raw/flightlist_20190101_20190131.csv") %>% transmute(ADEP = origin, ADES = destination, TYPE = as.factor(typecode), DATE = date(day), CALL = callsign, ACFT_ID = aircraft_uid)

#Easily "dropping NA's# - this can be further sofisticated
fb <- open_sky %>% drop_na()

#Joining to ADEP
fb2 <- left_join(fb, apt_countries, by = c("ADEP" = "ICAO")) %>% mutate(ADEP_CTRY = CTRY, .keep = "unused", .after = ADEP)
#Joining to ADES
fb3 <- left_join(fb2, apt_countries, by = c("ADES" = "ICAO")) %>% mutate(ADES_CTRY = CTRY, .keep = "unused", .after = ADES)

fb4 <- fb3 %>% drop_na() %>% mutate(ADEP_CTRY = as.factor(ADEP_CTRY), ADES_CTRY = as.factor(ADES_CTRY))

# Associate the regions

base_dataset <- fb4 %>%
  mutate(ADEP_REG = as.factor(case_when(ADEP_CTRY == "US" ~ "US",
                                                              ADEP_CTRY == "BR" ~ "BR",
                                                              ADEP_CTRY %in% eur_countries ~ "EU",
                                                              TRUE ~ "Other")), .after = ADEP_CTRY) %>%
  mutate(ADES_REG = as.factor(case_when(ADES_CTRY == "US" ~ "US",
                                        ADES_CTRY == "BR" ~ "BR",
                                        ADES_CTRY %in% eur_countries ~ "EU",
                                        TRUE ~ "Other")), .after = ADES_CTRY)
rm(fb,fb2, fb3, fb4)
