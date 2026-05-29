library(dplyr)
library(tidyr)
library(readr)

gdp_raw <- read_csv("data/raw/tl3-gdp.csv")
pop_raw <- read_csv("data/raw/tl3-pop.csv")
emp_raw <- read_csv("data/raw/tl3-emp.csv")
map_raw <- duckplyr::read_parquet_duckdb("data/raw/local-data-portal/sau_geo_tl_mapping.parquet") |> collect()

pop <- pop_raw |>
  select(
    territorial_level = TERRITORIAL_LEVEL,
    code = REF_AREA,
    country = COUNTRY,
    name = `Reference area`,
    time = TIME_PERIOD,
    unit = UNIT_MEASURE,
    pop = OBS_VALUE,
    age = Age,
    sex = Sex
  ) |>
  filter(
    territorial_level == "TL3",
    unit == "PS",
    age == "Total",
    sex == "Total"
  ) |>
  select(-territorial_level, -unit, -age, -sex)

gdp <- gdp_raw |>
  select(
    territorial_level = TERRITORIAL_LEVEL,
    code = REF_AREA,
    country = COUNTRY,
    name = `Reference area`,
    time = TIME_PERIOD,
    measure = MEASURE,
    prices = PRICES,
    unit = UNIT_MEASURE,
    gdp = OBS_VALUE
  ) |>
  filter(
    prices == "V",
    measure == "GDP",
    unit %in% c("USD_PPP", "USD_PPP_PS"),
    territorial_level == "TL3"
  ) |>
  select(-c(measure, prices, territorial_level)) |>
  pivot_wider(
    names_from = unit,
    values_from = gdp
  ) |>
  rename(
    gdp = USD_PPP,
    gdp_pc = USD_PPP_PS
  )

emp <- emp_raw |>
  select(
    code = REF_AREA,
    territorial_level = TERRITORIAL_LEVEL,
    country = COUNTRY,
    name = `Reference area`,
    time = TIME_PERIOD,
    activity_code = ACTIVITY,
    activity = `Economic activity`,
    unit = UNIT_MEASURE,
    emp = OBS_VALUE
  ) |>
  filter(
    unit == "PS",
    territorial_level == "TL3"
  ) |>
  select(-c(unit, territorial_level))


dat <- left_join(pop, gdp)
dat <- left_join(dat, emp)

dat <- dat |>
  select(-activity) |>
  pivot_wider(
    names_from = activity_code,
    values_from = emp,
    names_prefix = "emp_"
  )

map <- select(
  map_raw, pk, tl3_id, iso3, launame_lat,
  DEGURBA_L1, DEGURBA_L2,
  fuacode, fuaname_en,
  citycode, cityname_en
)

fua <- summarize(map, fua = any(!is.na(fuacode)), .by = tl3_id)

dat <- left_join(
  dat, fua,
  by = c("code" = "tl3_id")
)

arrow::write_parquet(dat, "data/processed/data.parquet")
