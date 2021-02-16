p=0.6
count=0
for _ in 1:100000
    balance=10
    for days in 1:20
        if rand()<p
            balance+=1
        else
            balance-=1
        end
        if balance==0
            global count+=1
            break
        end
    end

end
count/=100000
print(count)

