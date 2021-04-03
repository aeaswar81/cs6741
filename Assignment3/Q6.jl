#Using VSCode
#importing libraries 
using HTTP
using DataFrames
using Dates
using Plots
using CSV
using StatsPlots
default(size =(5000, 5000))
#using pyplot as backend
#pyplot()
#import the data and do preprocessing
#make a HTTP request 
#r = HTTP.request("GET", "https://api.covid19india.org/csv/latest/states.csv")
r=HTTP.get("https://api.covid19india.org/csv/latest/states.csv")
a=DataFrame(CSV.File(r.body))
select!(a,[:Date,:State,:Confirmed])
b=unstack(a,:Date,:State,:Confirmed)
select!(b,Not(:India))
select!(b,Not(:"State Unassigned"))
b=coalesce.(b, 0)
c=DataFrame()
push!(c,b[1,:])
let 
    cur_date=b[1,1]
    cur_date=cur_date+Dates.Day(7)
    i=1
#temp=deepcopy(b[1,:])
#temp[1]=cur_date
#temp
#b[1,:]
#push!(c,(cur_date,b[1,2:end]))
#print(first(b,10))
    while(i<nrow(b))
        i+=1
        #print(i)
        if cur_date == b[i,1]
            push!(c,b[i,:])
            cur_date=cur_date+Dates.Day(7)
        elseif cur_date > b[i,1]
            continue
        else 
            temp=deepcopy(b[i-1,:])
            temp[1]=cur_date
            push!(c,temp)
            cur_date=cur_date+Dates.Day(7)
            i=i-1
            #print(i)
        end
    end
end
insertcols!(c, 1, :week => 1:size(c)[1])
select!(c,Not(:Date))
d=DataFrame()
push!(d,c[1,:])
for i in 2:nrow(c)
    let 
        temp=deepcopy(c[i,:])
        for j in 2:37
            temp[j]=temp[j]-c[i-1,j]
        end
        push!(d,temp)
    end
end
d
function cormat(df)
    nc = ncol(df)
    t = zeros(nc, nc)
    for (i, c1) in enumerate(eachcol(df))
        for (j, c2) in enumerate(eachcol(df))
            sx, sy = skipmissings(c1, c2)
            t[i,j] = cor(collect(sx), collect(sy))
        end
    end
    return t
end
function covmat(df)
    nc = ncol(df)
    t = zeros(nc, nc)
    for (i, c1) in enumerate(eachcol(df))
        for (j, c2) in enumerate(eachcol(df))
            sx, sy = skipmissings(c1, c2)
            t[i, j] = cov(collect(sx), collect(sy))
        end
    end
    return t
end
findpos(arr) = [indexin(arr[i], sort(arr))[1] for i in 1:length(arr)]
cor_s(x, y) = cor(findpos(x), findpos(y))
function scormat(df)
    nc = ncol(df)
    t = zeros(nc, nc)
    for (i, c1) in enumerate(eachcol(df))
        for (j, c2) in enumerate(eachcol(df))
            sx, sy = skipmissings(c1, c2)
            t[i, j] = cor_s(collect(sx), collect(sy))
        end
    end
    return t
end
covar=covmat(select(d,Not(:week)))
corr=cormat(select(d,Not(:week)))
scorr=scormat(select(d,Not(:week)))
heatmap(names(d)[2:end],names(d)[2:end],scorr)
