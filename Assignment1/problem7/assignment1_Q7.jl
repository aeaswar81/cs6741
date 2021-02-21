using Random
Random.seed!(1)
#list of probabilities to check from 0 to 1 with a step of 0.1
pList=collect(Float64 ,0:0.1:1)  
for p in pList
    #to keep the count of simulations where balance becomes zero
    local count=0 
    for _ in 1:1000000 #For each p 10^6 simulations
        balance=10    #initial balance 10
        for days in 1:20   #20 days 
            if rand()<p     # randomly generated number less than p then gain
                balance+=1
            else            # if greater then loss
                balance-=1
            end
            #if he becomes bankrupt then increase count and break to check for next simulation
            if balance==0    
                count+=1
                break
            end
        end

    end
count/=1000000
println("The probability for p = ",p," is ",count)
end

