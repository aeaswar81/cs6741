#Using VSCode
#import the libraries 
using HTTP
using JSON
using DataFrames
using Dates
#make a HTTP request 
r = HTTP.request("GET", "https://api.covid19india.org/data.json")
#Convert the body of the message to string
a=(String(r.body))
#Parse the message using JSON 
b=JSON.parse(a)
# Convert the cases time series table into dataframe 
df1=reduce(vcat, DataFrame.(b["cases_time_series"]))
println("Original Table ")
show(df1)
#take the dateymd and for each row convert it into date format 
#extract the month and year from it and concatenate 
#rename it to calendar_month 
select!(df1,:dateymd => ByRow(x -> Dates.monthname(Date(x))*" "*string(Dates.year(Date(x)))) => :calendar_month,:dailyconfirmed,:dailydeceased,:dailyrecovered)
#convery the confirmed,deceased,recovered columns into Integer 
df1[!,:dailyconfirmed] = [parse(Int,x) for x in df1[:,:dailyconfirmed]] 
df1[!,:dailydeceased] = [parse(Int,x) for x in df1[:,:dailydeceased]] 
df1[!,:dailyrecovered] = [parse(Int,x) for x in df1[:,:dailyrecovered]] 
#group by the calendar_month 
gdf=groupby(df1,:calendar_month)
println("\nGrouped table ")
show(gdf)
#perform the sum of each of the groups 
final=combine(gdf, :dailyrecovered => sum, :dailyconfirmed=> sum ,:dailydeceased => sum)
println("\nAfter performing sum")
show(final)
