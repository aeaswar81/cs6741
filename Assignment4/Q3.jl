#Using VSCode
using Random
using Distributions
using QuadGK
using StatsBase
for n in 10:40
dist=Normal(n*100,sqrt(n)*30)
#integrate
prob=quadgk(x->pdf(dist,x),(2999.5,Inf)...)[1]
#if greater than 95 percentage 
if(prob*100>=95)
println("Minimum number of suits  ",n," with a probability ",prob)
break
end
end