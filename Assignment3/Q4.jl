#Using VSCode
using Distributions
using Plots
using Random
using StatsPlots
using StatsBase
Random.seed!(0)
#defind a function to find range 
range_(x) = maximum(x) - minimum(x)
#Calculate the range for 10000 samples 
a=[range_(rand(Uniform(0,1),30)) for i in 1:10000]
hgram=histogram(a,nbins=18)
dmode=mode(a)
dmean=mean(a)
dmedian=(median(a))
println("The mean is ",dmean)
println("The median is ",dmedian)
println("The mode is ",dmode)
plt1=plot(hgram,title="Histogram PLot",label="Range count",legend=:topleft)
plot!([dmean, dmean], [0, 1000], label="Mean", line=(3, :dash, :green))
plot!([dmedian, dmedian], [0, 1000], label="Median", line=(3, :dash, :black))
plot!([dmode, dmode], [0, 1000], label="Mode", line=(3, :dash, :red))
display(plt1)
savefig("range_hist.png")