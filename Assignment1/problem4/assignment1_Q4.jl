a=['A':'Z';'a':'z';'0':'9';'~';'!';'@';'#';'$';'%';'^';'&';'*';'(';')';'_';'+';'=';'-';'`']
using Random
password=rand(a,8)
store_count=0
for _ in 1:1000000
    hacker_gen=rand(a,8)
    if sum(password.==hacker_gen)>=2
        global store_count+=1
    end
end
store_count/=1000000
print(store_count)