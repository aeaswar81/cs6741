#list of characters from which the password can be generated 
a=['A':'Z';'a':'z';'0':'9';'~';'!';'@';'#';'$';'%';'^';'&';'*';'(';')';'_';'+';'=';'-';'`']
using Random
Random.seed!(1)
#generate an actual password
password=rand(a,8)
#to count the number of matched passwords 
store_count=0
for _ in 1:1000000 #1 million attempts
    hacker_gen=rand(a,8)
    #if the characters that match is 3 or greater 
    if sum(password.==hacker_gen)>=3
        global store_count+=1
    end
end
println("The number of passwords stored in a million attempts when 3 or more characters match is ", store_count)