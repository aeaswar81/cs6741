using StatsBase
using Random
pyplot()
deck=collect(1:1:52)
jack=[1,2,3,4]   #say the cards numbered 1,2,3,4 are jacks
Random.seed!(1)
#array to store the frequency of occurence of n from 0 to 5
count=[0,0,0,0,0,0]
#With Replacement 
for _ in 1:1000000 #conduct the experiment 1 lakh times
    shuffle!(deck) #shuffle the deck 
    local five_cards=sample(deck,5,replace=true) #randomly pick 5 cards with replacement
    jack_count=0  #to keep track of number of jacks
    for i in five_cards
        if i in jack  #if the any among the 5 is a jack increase the count
            jack_count+=1
        end
    end
    if jack_count==0  #keep a count for n=0 jacks
        count[6]+=1 
    else                # if there is a jack 
        count[jack_count]+=1
    end
end
count=count/1000000
println("With replacement")
println("n=",0," Probability=",count[6])
for i in 1:length(count)-1
    println("n=",i," Probability=",count[i])
end

#Without replacement 
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
        print(five_cards)
    end
end
count=count/1000000
println("Without replacement")
println("n=",0," Probability=",count[6])
for i in 1:length(count)-1
    println("n=",i," Probability=",count[i])
end
    
