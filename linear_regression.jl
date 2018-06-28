using(DataFrames)
# Pkg.add("Gadfly")
using(Gadfly)
# Pkg.add("LinearLeastSquares")
using(LinearLeastSquares)

# getting csv data
data = readtable("/Users/lucasflores/data.csv", eltypes=[Int64, Float64])

println("\n\n\n\n\n\n\n\n")

println("##### CSV DATA #####")
println(data)

x_data = data[1] # steps (X)
y_data = data[2] # times (Y)


# Generate data

p = plot(x=x_data, y=y_data, Geom.point, Guide.xlabel("Steps"), Guide.ylabel("Time"), Guide.title("Initial data"))

img = SVG("/Users/lucasflores/Desktop/times.svg", 5inch, 5inch)
draw(img, p)

# linear regression
 
slope = Variable()
offset = Variable()
line = offset + x_data * slope
residuals = line - y_data
fit_error = sum_squares(residuals)
optval = minimize!(fit_error)


# plot the data and the line
t = [0; 10^14; 0.01]
p = plot(
  layer(x=x_data, y=y_data, Geom.point),
  layer(x=t, y=evaluate(slope) * t + evaluate(offset), Geom.line),
  Guide.xlabel("Steps"), Guide.ylabel("Time"), Guide.title("Linear regression")
)

img = SVG("/Users/lucasflores/Desktop/regression.svg", 5inch, 5inch)
draw(img, p)





