using HTTP
using JSON
using DataFrames
using Dates
r = HTTP.request("GET", "https://api.covid19india.org/data.json")
a=(String(r.body))
b=JSON.parse(a)
print(keys(b))
df1=reduce(vcat, DataFrame.(b["cases_time_series"]))
select!(df1,:dateymd => ByRow(x -> Dates.monthname(Date(x))*" "*string(Dates.year(Date(x)))) => :calendar_month,:dailyconfirmed,:dailydeceased,:dailyrecovered)
df1[!,:dailyconfirmed] = [parse(Int,x) for x in df1[:,:dailyconfirmed]] 
df1[!,:dailydeceased] = [parse(Int,x) for x in df1[:,:dailydeceased]] 
df1[!,:dailyrecovered] = [parse(Int,x) for x in df1[:,:dailyrecovered]] 
gdf=groupby(df1,:calendar_month)
print(gdf)
final=combine(gdf, :dailyrecovered => sum, :dailyconfirmed=> sum ,:dailydeceased => sum)
print(final)
#d=df1[1,:dateymd]
#e=Date(d)
#Dates.day(e)
#z=Dates.monthname(e)*" "*string(Dates.year(e))
#df2=reduce(vcat,DataFrame.(b["tested"]))
#df3=reduce(vcat,DataFrame.(b["cases_time_series"]))
#print(c)
#print(df3)
#describe(df1)
#a=HTTP.payload(r)
