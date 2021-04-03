using Plots
using Random
using FreqTables
using StatsPlots
Random.seed!(1)
c=Int[]
c=vcat(c,rand([1,2],500))
c=vcat(c,rand([2],450))
c=vcat(c,rand([3,4,5],51))
c=sort!(c)
a=freqtable(c)
print(a)
println(mean(c))
println(median(c))
scatter(a)
plot!(a)
#println(mean(c))
#println(median(c))
#histogram(c, bins=26)