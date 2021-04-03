using Distributions
using Plots
using Random
range_(x) = maximum(x) - minimum(x)
a=[range_(rand(Uniform(0,1),30)) for i in 1:1000]
hgram=histogram(a,nbins=24)
dmode=mode(a)
dmean=mean(a)
dmedian=(median(a))
plot(hgram)
plot!([dmean, dmean], [0, 150], label="Mean", line=(4, :dash, :green))
plot!([dmedian, dmedian], [0, 150], label="Median", line=(4, :dash, :black))
plot!([dmode, dmode], [0, 150], label="Mode", line=(4, :dash, :red))