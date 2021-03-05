#Using VSCode 
using DataFrames
using Random
df1=DataFrame("ID" => String[], "year" => Int[],"month"=>Int[],"element" => String[])

for i in 1:30
    local a="d"*string(i)
    df1[:, a] = []
end

print(names(df1))
n=4
q=missing
print(rand(1))
print(rand(20:.1:30))
for i in 1:n
    local id=randstring(['A':'Z'; '0':'9'], 6)
    local year=rand(2000:2020) 
    local month=rand(1:12)
    local b=Any[]
    local c=Any[]
    push!(b,id)
    push!(c,id)
    push!(b,year)
    push!(c,year)
    push!(b,month)
    push!(c,month)
    push!(b,"tmax")
    push!(c,"tmin")
    for j in 1:30
        if rand() > 0.5
            push!(b,missing)
            push!(c,missing)
        else
            push!(b,rand(24:.1:40))
            push!(c,rand(10:.1:24))
        end
    end
    push!(df1,b)
    push!(df1,c)
end
#print(df1)
stackeddf1=(stack(df1,5:34))
dropmissing!(stackeddf1)
#print(stackeddf1)
select!(stackeddf1,:,[:year,:month,:variable]=> ByRow((x,y,z) -> string(x)*"-"*string(y)*"-"*z[2:end]) =>:Date)
print(stackeddf1)
select!(stackeddf1,Not([:year,:month,:variable]))
print(stackeddf1)
print(sort(unstack(stackeddf1,[:ID,:Date],:element,:value)))