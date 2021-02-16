p=0.3
count=0
for _ in 1:100000
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
count/=100000
println(count)
using Distributions
b=Binomial(20, 0.3)
println(pdf(b,2))
a=cdf(b,9)
println(1-a)

