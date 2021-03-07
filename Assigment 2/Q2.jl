#Using VSCode 
#import the libraries
using DataFrames
using Random
Random.seed!(1)
#create and empty dataframe
df1=DataFrame("ID" => String[], "year" => Int[],"month"=>Int[],"element" => String[])
#create the columns from 1 to 30 
for i in 1:30
    local a="d"*string(i)
    df1[:, a] = []
end

n=4  # number of months to be added, each month has 2 rows tmax and tmin   
#enter the data 
for i in 1:n
    local id=randstring(['A':'Z'; '0':'9'], 6) # Create a 6 length random string  for ID
    local year=rand(2000:2020)  # create year value
    local month=rand(1:12)     # month value 
    local b=Any[]        # a list to store the row entries 
    local c=Any[]      # b and c corresponds to the same month but b is for tmax and c tmin 
    push!(b,id)  # push the ids,year and month in both
    push!(c,id)
    push!(b,year)
    push!(c,year)
    push!(b,month)
    push!(c,month)
    push!(b,"tmax") #push the element values 
    push!(c,"tmin")
    for j in 1:30     # fill the 30 columns 
        if rand() > 0.5    # generate the values with a probability of 0.5 
            push!(b,missing) # if greater than 0.5 then both missing
            push!(c,missing)
        else
            push!(b,rand(24:.1:40)) # if lesser then generate a value for tmax 
            push!(c,rand(10:.1:24))  # tmax between 24-40 tmin between 10-24 
        end
    end
    push!(df1,b)  # push both the entries 
    push!(df1,c)
end
println("Untidy Data ")
show(df1)
stackeddf1=(stack(df1,5:34)) # stack the days colummns 
dropmissing!(stackeddf1)  # drop the missing rows 
# combine the year month and variable column and remove the 'd' in column names 
select!(stackeddf1,:,[:year,:month,:variable]=> ByRow((x,y,z) -> string(x)*"-"*string(y)*"-"*z[2:end]) =>:Date)
#drop the the columns which are only combined 
select!(stackeddf1,Not([:year,:month,:variable]))
#unstack the element column which has tmax tmin using id and Date column as key 
final=(sort(unstack(stackeddf1,[:ID,:Date],:element,:value)))
println("\n Tidy data ")
show(final)
