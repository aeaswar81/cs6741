using Plots 
using Random
pyplot()
#Empty array to store the Mean
mean_list=[]
#setting the seed 
Random.seed!(1)
#initialize the sum to zero
total_sum=0
for i in 1:1000000 #1000 random integers
    global total_sum=total_sum+rand(Int16) #add Integers randomly 
    #storing the mean
    push!(mean_list,total_sum/i)
end
#plot and save the figure
plot(1:1000000,mean_list,title="Mean vs N",xlabel="N",ylabel="Mean")
savefig("Q1.png")