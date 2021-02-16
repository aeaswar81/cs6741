a=['A':'Z';'a':'z';'0':'9';'~';'!';'@';'#';'$';'%';'^';'&';'*';'(';')';'_';'+';'=';'-';'`']
using Random
password=rand(a,8)
store_count=0
for _ in 1:1000000
    hacker_gen=rand(a,8)
    if sum(password.==hacker_gen)>=3 #change the matching characters and see the passwords stored
        global store_count+=1
    end
end
print(store_count)