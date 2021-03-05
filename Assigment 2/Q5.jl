using HTTP
using JSON
using DataFrames
using Dates
using Plots
pyplot()
r = HTTP.request("GET", "https://api.covid19india.org/data.json")
a=(String(r.body))
b=JSON.parse(a)
print(keys(b))
df1=reduce(vcat, DataFrame.(b["cases_time_series"]))
select!(df1,:dateymd => ByRow(x -> Dates.monthname(Date(x))*" "*string(Dates.year(Date(x)))) => :calendar_month,:dailyconfirmed,:dailydeceased,:dailyrecovered)
df1[!,:dailyconfirmed] = [parse(Int,x) for x in df1[:,:dailyconfirmed]] 
df1[!,:dailydeceased] = [parse(Int,x) for x in df1[:,:dailydeceased]] 
df1[!,:dailyrecovered] = [parse(Int,x) for x in df1[:,:dailyrecovered]] 
sum1=0
original_dailyconfirmed=df1[:,:dailyconfirmed]
original_dailydeceased=df1[:,:dailydeceased]
original_dailyrecovered=df1[:,:dailyrecovered]
moving_dailyconfirmed=Float64[]
moving_dailydeceased=Float64[]
moving_dailyrecovered=Float64[]

for i in 7:length(original_dailyconfirmed)
    append!(moving_dailyconfirmed,sum(original_dailyconfirmed[i-6:i])/7)
    append!(moving_dailydeceased,sum(original_dailydeceased[i-6:i])/7)
    append!(moving_dailyrecovered,sum(original_dailyrecovered[i-6:i])/7)
end
plt=plot(7:length(original_dailyrecovered),moving_dailyrecovered,title="Recovered vs Days",xlabel="Days",ylabel="Recovered",label=["moving" "normal"],lw=1,reuse=false)
plot!(7:length(original_dailyrecovered),original_dailyrecovered[7:end])
display(plt1)
savefig("Recovered.png")
plt2=plot(7:length(original_dailyconfirmed),moving_dailyconfirmed,title="Confirmed vs Days",xlabel="Days",ylabel="Confirmed",label=["moving" "normal"],lw=1,reuse=false)
plot!(7:length(original_dailyconfirmed),original_dailyconfirmed[7:end])
display(plt2)
savefig("Confirmed.png")
plt3=plot(7:length(original_dailydeceased),moving_dailydeceased,title="Deceased vs Days",xlabel="Days",ylabel="Deceased",label=["moving" "normal"],lw=1,reuse=false)
plot!(7:length(original_dailydeceased),original_dailydeceased[7:end])
display(plt3)
savefig("Deceased.png")
