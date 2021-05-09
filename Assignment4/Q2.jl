#Using VSCode 
using Random
using Distributions
using QuadGK
using StatsBase
Random.seed!(1)
let 
    #range of values to check
    p=[0.58,0.59,0.60,0.61]
    for i in p
    mu=50*i
    stddev=sqrt(50*i*(1-i))
    dist=Normal(mu,stddev)
    prob=quadgk(x->pdf(dist,x),(29.5,Inf)...)[1]
    println("CLT output ",prob)
    end
end
#choosing 0.59 since this value gave the value closest to 0.5
#Monte carlo
let 
    trials=100000
    positive=0
    for i in 1:trials
            #choose heads with a probability of 0.59 an tails 0.41
            if(sum(sample([1,0],Weights([0.59,0.41]),50))>=30)
               positive+=1
           end
        
    end

    println("Monte Carlo output ",positive/trials)

end
#Binomial 
let
    dist=Binomial(50,0.59)
    println("Binomial output ",1-cdf(dist,29))
end
