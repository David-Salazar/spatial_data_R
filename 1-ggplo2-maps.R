library(ggmap)
corvallis <- c(lon = -123.2620, lat = 44.5646)

# Get map at zoom level 5: map_5
map_5 <- get_map(corvallis, zoom = 5, scale = 1)

# Plot map at zoom level 5
ggmap(map_5)

# Get map at zoom level 13: corvallis_map
corvallis_map <- get_map(corvallis, zoom = 13, scale = 1)

# Plot map at zoom level 13
ggmap(corvallis_map)


corvallis <- c(lon = -123.2620, lat = 44.5646)

# Add a maptype argument to get a satellite map
corvallis_map_sat <- get_map(corvallis, zoom = 13, maptype = "satellite")

# Edit to display satellite map
ggmap(corvallis_map_sat) +
  geom_point(aes(lon, lat, color = year_built), data = sales)

# Add source and maptype to get toner map from Stamen Maps
corvallis_map_bw <- get_map(corvallis, zoom = 13, source = "stamen", maptype = "toner")

# Edit to display toner map
ggmap(corvallis_map_bw) +
  geom_point(aes(lon, lat, color = year_built), data = sales)

# Use base_layer argument to ggmap() to specify data and x, y mappings
# Enables facetting
ggmap(corvallis_map_bw,
      base_layer = ggplot(sales, aes(lon, lat))) +
  geom_point(aes(color = year_built))

# Fix the polygon cropping
ggmap(corvallis_map_bw,
      extent = "normal",
      maprange = FALSE, 
      base_layer = ggplot(ward_sales, aes(lon, lat))) +
  geom_polygon(aes(group = group, fill = ward))

# Repeat, but map fill to num_sales
# Fix the polygon cropping
ggmap(corvallis_map_bw,
      extent = "normal",
      maprange = FALSE, 
      base_layer = ggplot(ward_sales, aes(lon, lat))) +
  geom_polygon(aes(group = group, fill = num_sales))

# Repeat again, but map fill to avg_price
ggmap(corvallis_map_bw,
      extent = "normal",
      maprange = FALSE, 
      base_layer = ggplot(ward_sales, aes(lon, lat))) +
  geom_polygon(aes(group = group, fill = avg_price), alpha = 0.8)


