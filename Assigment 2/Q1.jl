
#Using VScode
#import libraries
using DataFrames
using Random
#Create the empty Dataframe
df1=DataFrame("Religion" => String[], "<10K\$" => Int[],"\$10-20K"=>Int[],"\$20-30K"=>Int[],"\$30-40K"=>Int[],"\$40-50K"=>Int[],"\$50-75K"=>Int[])
#names of religions
a=["Agnostic","Atheist","Buddhist","Catholic","Dont know/Refused","Evangelist","Hindu","Historically Black","Jehovah","Jewish"]
#Insert the data with a random value of income frequency 
for i in 1:length(a)
	push!(df1,(a[i],rand(1:500),rand(1:500),rand(1:500),rand(1:500),rand(1:500),rand(1:500)))
end
#display the untidy data 	
println("Untidy data")
show(df1)
#Stack the columns and sort 
df1Stacked=sort(stack(df1,2:7))
#rename the column names 
rename!(df1Stacked,:variable => :income,:value => :freq )
#display the tidy data
println("\n Tidy data")
show(df1Stacked)