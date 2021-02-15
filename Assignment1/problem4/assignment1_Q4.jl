a=['A':'Z';'a':'z';'0':'9';'~';'!';'@';'#';'$';'%';'^';'&';'*';'(';')';'_';'+';'=';'-';'`']
password=randstring(a,8)
store_count=0
for _ in 1:10000
    hacker_gen=randstring(a,8)
    same_char=0
    for i in password
        for j in hacker_gen
            if(i==j)
                same_char+=1
            end
        end
    end
    if same_char >= 2
        global store_count+=1
    end

end
store_count/=10000
print(store_count)