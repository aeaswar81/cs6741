using Random
Random.seed!(1)
#list of probabilities to check from 0 to 1 with a step of 0.1
pList=collect(Float64 ,0:0.1:1)  
for p in pList
    #to keep the count of simulations where balance becomes zero
    local count=0 
    for _ in 1:1000000
        balance=10
        for days in 1:20
            if rand()<p    #gain 
                balance+=1
            else    
                if balance-1 ==0 #if he goes bankrupt which shouldnt happen
                    balance+=1
                else            #loss
                    balance-=1
                end
            end
        end 
        #check if the final balance greater than or equal to 10
        if balance>=10
            count+=1
        end

    end
    count/=1000000
    println("The probability for p = ",p," is ",count)
end

