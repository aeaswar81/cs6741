p=0.6
count=0
for _ in 1:10000
    balance=10
    for days in 1:20
        if rand()<p
            balance+=1
        else
            balance-=1
        end
    end
    if balance>=10
        global count+=1
    end 
end
count/=10000
print(count)
using Distributions
b=Binomial(20, 0.6)
a=cdf(b,9)
print(1-a)

