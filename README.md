# bpartysdazaa: Ice Cream Party and Weather Simulation Package

[**View the website here!**](https://ptds2024.github.io/bpartysdazaa/)

---

# **Overview**

The `bpartysdazaa` package provides tools for:
1. Planning ice cream parties by calculating the volume and surface area of ice cream cones.
2. Simulating variations in cone shapes and estimating resource needs based on weather conditions.
3. Enhancing weather-based simulations with a Shiny app to compare city weather data and forecast resource requirements.

This package was developed as part of a programming tools homework assignment to combine R programming, Shiny apps, and weather forecasting into a practical solution.

---

# **Key Features**

1. **Cone Calculations**:
   - Define the cone's radius based on height.
   - Calculate the volume and surface area of cones.
   - Simulate variations in cone shapes to account for realistic scenarios.

2. **Weather-Based Simulations**:
   - Retrieve 5-day weather forecasts for cities using the OpenWeatherMap API.
   - Use weather data (temperature, humidity, and pressure) to simulate guest behavior and estimate resource needs.

3. **Shiny App Integration**:
   - Visualize weather trends across multiple cities.
   - Simulate ice cream party needs (cone volume and surface area) for up to 3 cities.

---

# **Installation**

To install the `bpartysdazaa` package, first clone the repository to your local machine:

bash
git clone https://github.com/ptds2024/bpartysdazaa.git

Then install the package in R:

devtools::install_local("path/to/bpartysdazaa")

# **Usage**

1. Planning Ice Cream Desserts for a Birthday Party
The package provides functions to:

Calculate cone radius using different methods (e.g., for loops, sapply, Vectorize, etc.).
Determine cone volume and surface area using numerical integration.
Simulate 10,000 parties to estimate total resource needs based on weather variations.

2. Enhancing Weather Simulation with Shiny
The Shiny app included in the package allows for:
Comparing weather trends across three cities.
Simulating ice cream party needs for multiple locations.

Running the Shiny App:
library(bpartysdazaa)

# Launch the Shiny app
run_app()App 

Features:
Input up to 3 city names.
Select weather factors (temperature, humidity, pressure) for visualization.
Simulate resource needs for each city and view results as plots and summaries.

# **Functions**

calculate_volume():
Calculates the volume of an ice cream cone based on its radius and height.

calculate_surface_area():
Computes the surface area of an ice cream cone using numerical integration.

simulate_party_simple(num_simulations, combined_data):
Simulates ice cream needs for a specified number of parties.
Takes into account variations in cone shape and guest behavior.

lookup_weather_data(city):
Retrieves weather data for a specified city from the OpenWeatherMap API.

run_app():
Launches the Shiny app to visualize weather and simulate ice cream party needs.

# **Dependencies**

The package requires the following R packages:
httr
jsonlite
ggplot2
microbenchmark
shiny

Install them with:
install.packages(c("httr", "jsonlite", "ggplot2", "microbenchmark", "shiny"))
