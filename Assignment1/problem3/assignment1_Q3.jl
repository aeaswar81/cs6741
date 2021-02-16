using StatsBase
deck=collect(1:1:52)
jack=[1,2,3,4]
#Random.seed!(1)
count=[0,0,0,0,0,0]
for _ in 1:1000000
    shuffle!(deck)
    local five_cards=sample(deck,5,replace=true)
    jack_count=0
    for i in five_cards
        if i in jack
            jack_count+=1
        end
    end
    if jack_count==0
        count[6]+=1
    else
        count[jack_count]+=1
    end
    if jack_count==5
        #print(five_cards)
    end
end
#print(count)
count=count/1000000
println(count)
#with replacement binomial distribution 
#without replacement hypergeometric distribution
count=[0,0,0,0,0,0]
for _ in 1:1000000
    shuffle!(deck)
    local five_cards=sample(deck,5,replace=false)
    jack_count=0
    for i in five_cards
        if i in jack
            jack_count+=1
        end
    end
    if jack_count==0
        count[6]+=1
    else
        count[jack_count]+=1
    end
    if jack_count==5
        #print(five_cards)
    end
end
#print(count)
count=count/1000000
println(count)
using Distributions
p=4/52 
b=Binomial(5, p)
c=Hypergeometric(4,48,5)
println(pdf(b,1))
println(pdf(c,1))