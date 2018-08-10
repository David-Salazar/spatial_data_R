library(sp)

# S4 Objects. Get elements with @
str(countries_sp, 2)

one <- countries_spdf@polygons[[169]]

# str() with max.level = 2, on the Polygons slot of one
str(one@Polygons, max.level = 2)

# str() with max.level = 2, on the 6th element of the one@Polygons
str(one@Polygons[[6]], max.level = 2)

# Call plot on the coords slot of 6th element of one@Polygons
plot(one@Polygons[[6]]@coords)

# Create logical vector: is_nz
is_nz <- countries_spdf$name == "New Zealand"

# Subset countries_spdf using is_nz: nz
nz <- countries_spdf[is_nz, ]


# Add style argument to the tm_fill() call
tm_shape(countries_spdf) +
  tm_fill(col = "population", style = "quantile") +
  # Add a tm_borders() layer 
  tm_borders(col = "burlywood4")

# New plot, with tm_bubbles() instead of tm_fill()

# Add style argument to the tm_fill() call
tm_shape(countries_spdf) +
  tm_bubbles(size = "population", style = "quantile") +
  # Add a tm_borders() layer 
  tm_borders(col = "burlywood4")



