#Using VSCode
using Random
using Distributions
using QuadGK
Random.seed!(1)
#Monte carlo
let 
    trials=100000
    positive=0
    for i in 1:trials
        #if 30 or more heads then increase the count 
        if(sum(rand(0:1,50))>=30)
            positive+=1
        end
    end

    println("Monte Carlo output ",positive/trials)

end
#binomial 
let
    dist=Binomial(50,0.5)
    println("Binomial output ",1-cdf(dist,29))
end
#CLT 
let 
    #mean=np
    mu=50*0.5
    #stdev=sqrt(npq)
    stddev=(50*0.5*0.5)^0.5
    dist=Normal(mu,stddev)
    prob=quadgk(x->pdf(dist,x),(29.5,Inf)...)[1]
    println("CLT output ",prob)
end