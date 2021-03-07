#Using VSCode
#importing libraries 
using HTTP
using JSON
using DataFrames
using Dates
using Plots
#using pyplot as backend
pyplot()
#import the data and do preprocessing
#make a HTTP request 
r = HTTP.request("GET", "https://api.covid19india.org/data.json")
#Convert the body of the message to string
a=(String(r.body))
#Parse the message using JSON 
b=JSON.parse(a)
# Convert the cases time series table into dataframe 
df1=reduce(vcat, DataFrame.(b["cases_time_series"]))
#convert the confirmed,deceased,recovered columns into Integer 
df1[!,:dailyconfirmed] = [parse(Int,x) for x in df1[:,:dailyconfirmed]] 
df1[!,:dailydeceased] = [parse(Int,x) for x in df1[:,:dailydeceased]] 
df1[!,:dailyrecovered] = [parse(Int,x) for x in df1[:,:dailyrecovered]] 
#original columns of confirmed,deceased and recoverd 
original_dailyconfirmed=df1[:,:dailyconfirmed]
original_dailydeceased=df1[:,:dailydeceased]
original_dailyrecovered=df1[:,:dailyrecovered]
#arrays to store the moving average of all the three columns
moving_dailyconfirmed=Float64[]
moving_dailydeceased=Float64[]
moving_dailyrecovered=Float64[]
# since its preceding 7, start doing the average from the 7th element of original column
for i in 7:length(original_dailyconfirmed)
    #average and append it to the moving average arrays 
    append!(moving_dailyconfirmed,sum(original_dailyconfirmed[i-6:i])/7)
    append!(moving_dailydeceased,sum(original_dailydeceased[i-6:i])/7)
    append!(moving_dailyrecovered,sum(original_dailyrecovered[i-6:i])/7)
end
# Plot the moving and normal plots for each of the data 
plt1=plot(7:length(original_dailyrecovered),moving_dailyrecovered,title="Recovered vs Days",xlabel="Days",ylabel="Recovered",label="moving",lw=1,reuse=false)
#overwrite on the same plot the normal values 
plot!(7:length(original_dailyrecovered),original_dailyrecovered[7:end],label="normal")
#display the plot 
display(plt1)
#save the plot to local folder
savefig("Recovered.png")
#do for the remaining two data
plt2=plot(7:length(original_dailyconfirmed),moving_dailyconfirmed,title="Confirmed vs Days",xlabel="Days",ylabel="Confirmed",label="moving" ,lw=1,reuse=false)
plot!(7:length(original_dailyconfirmed),original_dailyconfirmed[7:end],label="normal")
display(plt2)
savefig("Confirmed.png")
plt3=plot(7:length(original_dailydeceased),moving_dailydeceased,title="Deceased vs Days",xlabel="Days",ylabel="Deceased",label="moving",lw=1,reuse=false)
plot!(7:length(original_dailydeceased),original_dailydeceased[7:end],label="normal")
display(plt3)
savefig("Deceased.png")
