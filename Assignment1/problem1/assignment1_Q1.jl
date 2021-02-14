using Plots
pyplot()
#Fix a range of values for N
N=collect(10:10:10000)
#Empty array to store the averages  
avg_list=[]
Random.seed!(1)
for i in N
    total_sum=0
    for _ in 1:i
        total_sum=total_sum+rand(Int)
    end
    push!(avg_list,total_sum/i)
end
print(avg_list)
plot(N,avg_list)
