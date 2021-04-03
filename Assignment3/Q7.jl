using Distributions
using Plots
using StatsPlots
function oneSidedTailNormal(x)
    #inverse cdf 
    x/=100
    return cquantile(Normal(0,1),x)
end
function oneSidedTailTDist(x)
    #inverse cdf 
    x/=100
    return quantile(TDist(10),1-x)
end
println(oneSidedTailNormal(95))
println(oneSidedTailTDist(95))
#=
function oneSidedTailTDistc(x)
    #inverse cdf 
    x/=100
    return cquantile(TDist(10),x)
end
=#
plot(x->x, x->pdf(Normal(0, 1), x), -4, 4, label="")
plot!(x->x, x->pdf(Normal(0, 1), x), -4, oneSidedTailNormal(95), fill=(0, :orange), label="")
plot!(x->x, x->pdf(TDist(10), x), -4, 4, label="")
plot!(x->x, x->pdf(TDist(10), x), -4, oneSidedTailTDist(95), fill=(0, :blue), label="")
