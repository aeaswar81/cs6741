#Using VSCode
using Plots
using Random
using FreqTables
using StatsPlots
Random.seed!(1)
c=Int[]
#Generate 500 points before and on the median 2 
c=vcat(c,rand([1,2],500))
#Generate 450 points at median 2
c=vcat(c,rand([2],450))
#Generate 51 points from 3,4,5
c=vcat(c,rand([3,4,5],51))
#Sort the points 
c=sort!(c)
#Create a freq table to plot 
a=freqtable(c)
d_mean=mean(c)
d_median=median(c)
d_mode=mode(c)
println("The mean is ",d_mean)
println("The median is ",d_median)
println("The mode is ",d_mode)
plt1=scatter(a,label=false,xlabel="x",ylabel="Frequency",title="Generated distribution")
plot!(a,label=false)
plot!([d_mean, d_mean], [0, 100], label="Mean", line=(3, :dash, :green))
plot!([d_mode, d_mode], [0, 50], label="Mode", line=(1, :red))
plot!([d_median, d_median], [0, 200], label="Median", line=(3, :dot, :orange))
display(plt1)
savefig("GenerateDist.png")