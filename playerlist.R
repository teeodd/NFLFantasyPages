library(nflfastR)
library(jsonlite)

# Determine the current NFL season based on the current date
current_date <- Sys.Date()
current_year <- as.numeric(format(current_date, "%Y"))

# If we're in January - April, the "season" still refers to the previous year
if (format(current_date, "%m") %in% c("01", "02", "03", "04")) {
  season_year <- current_year - 1
} else {
  season_year <- current_year
}

# Fetch roster data for the determined season year
players <- fast_scraper_roster(season_year)

# Filter to include only specific offensive positions
skill_positions <- c("QB", "WR", "TE", "RB", "FB")
players <- players[players$position %in% skill_positions, ]

# Define the path for saving the JSON file within the Blazor project
output_path <- "wwwroot/sample-data/players.json"

# Save the data to JSON format
write_json(players, output_path)