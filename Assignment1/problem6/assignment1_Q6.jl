using Random
using Distributions
Random.seed!(1)
#list of probabilities to check from 0 to 1 with a step of 0.1
pList=collect(Float64 ,0:0.1:1)  
for p in pList
    #to keep the count of simulations where balance greater than or equal to 10
    local count=0 
    for _ in 1:1000000  #For each p 10^6 simulations
        balance=10  #initial balance 10
        for days in 1:20  #20 days 
            if rand()<p      # randomly generated number less than p then gain
                balance+=1
            else            # if greater then loss
                balance-=1
            end
        end
        if balance>=10        # increase the count if condition satisfied
            count+=1
        end 
    end
    count/=1000000
    println("The probability for p = ",p," is ")
    println("Experimental: ",count)
    println("Theoretical: ",1-cdf(Binomial(20,p),9))   
end




