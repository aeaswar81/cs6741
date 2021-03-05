using DataFrames
using Random
using Dates
df1=DataFrame("year" => Int[], "artist" => String[],"time" => String[],"track"=>String[],"Date"=> Date[],"week" => Int[],"rank"=>Int[])
track=["Baby Don't Cry","The Hardest Part of","Kryptonite"]
artist=["2 Pac","2Ge+her","3 Doors Down"]
time=["4:22","3:15","3:53"]
#push!(df1,[2012,"dsf","232","asfas",Date(2012,2,25),23])
#y=Dates.Date(2012,2,29) + Dates.Day(2)
#print(y)
#z=Dates.day(y)
print(z)
#unix2datetime(rand(datetime2unix(dt1) : datetime2unix(dt2)))
#print(y+z)
#print(df1)
#print(rand(2:3))
for i in 1:length(track)
    year=rand(2000:2020)
    local date=Date(year,rand(1:12),rand(1:28))
    for j in 0:rand(1:10)
        push!(df1,[year,artist[i],time[i],track[i],date+Dates.Day(j*7),j+1,rand(1:100)])
    end
end

#df2=DataFrame("id" =>Int[],"artist" => String[],"track" => String[],"time" => String[])
#df3=DataFrame("id" =>Int[],"date" => String[],"rank" => Int[])
#insertcols!(df1, 1, :id => 1:size(df1)[1])

#print(size(df1)[1])
df2=unique(df1[:,[:year,:artist,:track,:time]])
insertcols!(df2, 1, :id => 1:size(df2)[1])
#unique(select(df1,:year,:artist,:track,:time))

#print(df2)
join_table=innerjoin(df2[:,[:id,:track]],df1[:,[:track,:Date,:rank]],on=:track)
df3=select(join_table,Not(:track))
print(df1)
print(df2)
print(df3)
#select([df1,df2])
