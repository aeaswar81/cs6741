

using DataFrames
using Random
df1=DataFrame("Religion" => String[], "<10K\$" => Int[],"\$10-20K"=>Int[],"\$20-30K"=>Int[],"\$30-40K"=>Int[],"\$40-50K"=>Int[],"\$50-75K"=>Int[])

print(df1)
a=["Agnostic","Atheist","Buddhist","Catholic","Dont know/Refused","Evangelist","Hindu","Historically Black","Jehovah","Jewish"]
print(a)
#print(rand(1:500))
for i in 1:length(a)
	push!(df1,(a[i],rand(1:500),rand(1:500),rand(1:500),rand(1:500),rand(1:500),rand(1:500)))
end	
print(df1)
df1Stacked=sort(stack(df1,2:7))
print(df1Stacked)