library(sp)
library(rgdal)

# Use dir() to find directory name
dir()

# Call dir() with directory name
dir("nynta_16c")

# Read in shapefile with readOGR(): neighborhoods
neighborhoods <- readOGR(dsn = "nynta_16c", layer = "nynta")

# summary() of neighborhoods
summary(neighborhoods)

# Plot neighboorhoods
plot(neighborhoods)

library(raster) 

# Call dir()
dir()

# Call dir() on the directory
dir("nyc_grid_data")

# Use raster() with file path: income_grid
income_grid <- raster("nyc_grid_data/m5602ahhi00.tif")

# Call summary() on income_grid
summary(income_grid)

# Call plot() on income_grid
plot(income_grid)

library(sp)
library(tigris)

# Call tracts(): nyc_tracts
nyc_tracts <- tracts(state = "NY",
                     county = "New York", cb = TRUE)

# Call summary() on nyc_tracts
summary(nyc_tracts)

# Plot nyc_tracts
plot(nyc_tracts)

library(sp)

# proj4string() on nyc_tracts and neighborhoods
proj4string(nyc_tracts)
proj4string(neighborhoods)

# coordinates() on nyc_tracts and neighborhoods
head(coordinates(nyc_tracts))
head(coordinates(neighborhoods))

# plot() neighborhoods and nyc_tracts
plot(neighborhoods)
plot(nyc_tracts, add = TRUE, col = "red")

library(sp)
library(raster)

# Use spTransform on neighborhoods: neighborhoods
neighborhoods <- spTransform(neighborhoods,   
                             proj4string(nyc_tracts))

# head() on coordinates() of neighborhoods
head(coordinates(neighborhoods))

# Plot neighborhoods, nyc_tracts and water
plot(neighborhoods)
plot(nyc_tracts, add = TRUE, col = "red")
plot(water, add = TRUE, col = "blue")

library(sp)
library(tmap)

# Merge nyc_tracts and nyc_income: nyc_tracts_merge
nyc_tracts_merge <- merge(nyc_tracts, nyc_income, by.x = "TRACTCE",
                          by.y = "tract")

# Call summary() on nyc_tracts_merge
summary(nyc_tracts_merge)

# Choropleth with col mapped to estimate
tm_shape(nyc_tracts_merge) +
  tm_fill(col = "estimate")

library(tmap)

# Find unique() nyc_tracts_merge$COUNTYFP
unique(nyc_tracts_merge$COUNTYFP)

# Add logical expression to pull out New York County
manhat_hoods <- neighborhoods[neighborhoods$CountyFIPS == "061", ]

tm_shape(nyc_tracts_merge) +
  tm_fill(col = "estimate") +
  tm_shape(water) +
  tm_fill(col = "grey90") +
  # Edit to use manhat_hoods instead
  tm_shape(manhat_hoods) +
  tm_borders() +
  # Add a tm_text() layer
  tm_text(text = "NTAName")

library(tmap)

# gsub() to replace " " with "\n"
manhat_hoods$name <- gsub(" ", "\n", manhat_hoods$NTAName)

# gsub() to replace "-" with "/\n"
manhat_hoods$name <- gsub("-",  "/\n", manhat_hoods$name)

# Edit to map text to name, set size to 0.5
tm_shape(nyc_tracts_merge) +
  tm_fill(col = "estimate") +
  tm_shape(water) +
  tm_fill(col = "grey90") +
  tm_shape(manhat_hoods) +
  tm_borders() +
  tm_text(text = "name", size = 0.5)

library(tmap)

tm_shape(nyc_tracts_merge) +
  # Add title and change palette
  tm_fill(col = "estimate", 
          title = "Median Income",
          palette = "Greens") +
  # Add tm_borders()
  tm_borders(col = "grey60", lwd = 0.5) +
  tm_shape(water) +
  tm_fill(col = "grey90") +
  tm_shape(manhat_hoods) +
  # Change col and lwd of neighborhood boundaries
  tm_borders(col = "grey40", lwd = 2) +
  tm_text(text = "name", size = 0.5) +
  # Add tm_credits()
  tm_credits("Source: ACS 2014 5-year Estimates, \n accessed via acs package", 
             position = c("right", "bottom"))

# Save map as "nyc_income_map.png"
save_tmap(filename = "nyc_income_map.png", width = 4, height = 7)