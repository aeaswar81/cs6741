#Using VSCode
using Distributions 
using Plots
using StatsBase
using Random
using StatsPlots
Random.seed!(1)
pyplot()
#Dist=Uniform(0,1)
#uncomment these to check
#Dist=Binomial(60,0.01)
#Dist=Binomial(60,0.5)
Dist=Chisq(3)
mu=mean(Dist)
stdclt=std(Dist)
# for different sample sizes, run a loop
for j in 2:500
let
s=[]
#repeat it many times 
for i in 1:10000
    #take j samples 
    a=rand(Dist,j)
    a=a.-mu  #subtract mean 
    a=a./stdclt # divide by std deviation
    push!(s,sum(a))
end
s=s./sqrt(j) #divide by sqrt (n)
# check within limits
#kurtosis of standard normal dist is 3
if(abs(moment(s,1))<0.05 && abs(moment(s,2)-1)<0.05 && abs(moment(s,3))<0.05 && abs(moment(s,4)-3)<0.05)  
    println("The minimum sample size is ",j)
    plt=density(s,label="approximation")
    plot!(plt,Normal(0,1),label="standard Normal")
    display(plt)
    savefig("4d.png")
    break
end

end
end