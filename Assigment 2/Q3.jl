#Using VScode
#import the libraries 
using DataFrames
using Random
using Dates
#Create an empty dataframe
df1=DataFrame("year" => Int[], "artist" => String[],"time" => String[],"track"=>String[],"Date"=> Date[],"week" => Int[],"rank"=>Int[])
#values of track artist and time stored in an array
track=["Baby Don't Cry","The Hardest Part of","Kryptonite"]
artist=["2 Pac","2Ge+her","3 Doors Down"]
time=["4:22","3:15","3:53"]
#inserting the values
for i in 1:length(track) #3 tracks 
    year=rand(2000:2020) #a random year 
    local date=Date(year,rand(1:12),rand(1:28)) #random date on which it was released
    for j in 0:rand(1:10)  # number of weeks for the given track choose randomly 
        #add 7 days to the date to get the next week date, also generate rank randomly
        push!(df1,[year,artist[i],time[i],track[i],date+Dates.Day(j*7),j+1,rand(1:100)])
    end
end
println("Untidy Data")
show(df1)
#select the unique tracks , this forms the table 1
df2=unique(df1[:,[:year,:artist,:track,:time]])
#give an index for this table 
insertcols!(df2, 1, :id => 1:size(df2)[1])
#inner join this table with the older table with track as key,this gives the second table
join_table=innerjoin(df2[:,[:id,:track]],df1[:,[:track,:Date,:rank]],on=:track)
# drop the track column since it is not required 
df3=select(join_table,Not(:track))
println("\n Tidy data")
show(df2)
show(df3)
