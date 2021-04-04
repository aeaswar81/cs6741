#Using VSCode 
using Distributions
using Plots
using StatsPlots
using StatsBase
#funciton for Normal DIstribution 
function oneSidedTailNormal(x)
    #inverse cdf 
    #normalize 
    x/=100
    return quantile(Normal(0,1),1-x)
end
#function for TDistribution
function oneSidedTailTDist(x)
    #inverse cdf 
    #normalize
    x/=100
    return quantile(TDist(10),1-x)
end
println("One tail for normal ",oneSidedTailNormal(95))
println("One tail for TDist",oneSidedTailTDist(95))
#Plotting 
plt1=plot(x->x, x->pdf(Normal(0, 1), x), -4, 4, label="Normal")
plot!(x->x, x->pdf(Normal(0, 1), x), -4, oneSidedTailNormal(95), fill=(0, :orange,0.3),label=false)
display(plt1)
savefig("normal.png")
plt2=plot(x->x, x->pdf(TDist(10), x), -4, 4, label="TDist")
plot!(x->x, x->pdf(TDist(10), x), -4, oneSidedTailTDist(95), fill=(0, :blue,0.3), label=false)
display(plt2)
savefig("Tdist.png")
plt3=plot(x->x, x->pdf(Normal(0, 1), x), -4, 4, label="Normal")
plot!(x->x, x->pdf(Normal(0, 1), x), -4, oneSidedTailNormal(95), fill=(0, :orange,0.3), label="Normal Area")
plot!(x->x, x->pdf(TDist(10), x), -4, 4, label="TDist")
plot!(x->x, x->pdf(TDist(10), x), -4, oneSidedTailTDist(95), fill=(0, :blue,0.3), label="TDist Area")
display(plt3)
savefig("Combined.png")
