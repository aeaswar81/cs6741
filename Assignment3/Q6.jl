#Using VSCode
#importing libraries 
using HTTP
using DataFrames
using Dates
using Plots
using CSV
using StatsPlots
using StatsBase
#get the covid data 
r=HTTP.get("https://api.covid19india.org/csv/latest/states.csv")
#read the csv file and covert to dataframe
a=DataFrame(CSV.File(r.body))
#select only the required columns 
select!(a,[:Date,:State,:Confirmed])
#unstack 
b=unstack(a,:Date,:State,:Confirmed)
#remove unnecessary columns 
select!(b,Not(:India))
select!(b,Not(:"State Unassigned"))
#replace missing with 0 
b=coalesce.(b, 0)
#create a new data frame 
c=DataFrame()
#store the first entry of b
push!(c,b[1,:])
let 
    #variable to keep track of date 
    cur_date=b[1,1]
    cur_date=cur_date+Dates.Day(7)
    #loop variable 
    i=1
    while(i<nrow(b))
        i+=1
        # if the date matches then push that entry
        if cur_date == b[i,1]
            push!(c,b[i,:])
            cur_date=cur_date+Dates.Day(7)
        # if date required is greater then check the Next
        # entry 
        elseif cur_date > b[i,1]
            continue
        #if date is lesser than the current row 
        # that means the date is not present 
        # take the values from the previous entry 
        else 
            temp=deepcopy(b[i-1,:])
            temp[1]=cur_date
            push!(c,temp)
            cur_date=cur_date+Dates.Day(7)
            i=i-1
        end
    end
end
#insert the week column 
insertcols!(c, 1, :week => 1:size(c)[1])
#remove the date column 
select!(c,Not(:Date))
# create a new data frame to find the difference 
# between each entries since the values are 
# cumulative, we need weekly addition 
d=DataFrame()
# push the first entry 
push!(d,c[1,:])
for i in 2:nrow(c)
    let 
        temp=deepcopy(c[i,:])
        #for all the states
        for j in 2:37
            temp[j]=temp[j]-c[i-1,j]
        end
        push!(d,temp)
    end
end
#last(d,10 )
# function to find the correlation matrix 
function cormat(df)
    nc = ncol(df)
    t = zeros(nc, nc)
    for (i, c1) in enumerate(eachcol(df))
        for (j, c2) in enumerate(eachcol(df))
            sx, sy = skipmissings(c1, c2)
            t[i,j] = StatsBase.cor(collect(sx), collect(sy))
        end
    end
    return t
end
#function to find the covariance matrix 
function covmat(df)
    nc = ncol(df)
    t = zeros(nc, nc)
    for (i, c1) in enumerate(eachcol(df))
        for (j, c2) in enumerate(eachcol(df))
            sx, sy = skipmissings(c1, c2)
            t[i, j] = StatsBase.cov(collect(sx), collect(sy))
        end
    end
    return t
end
findpos(arr) = [indexin(arr[i], sort(arr))[1] for i in 1:length(arr)]
cor_s(x, y) = StatsBase.cor(findpos(x), findpos(y))
# function to find the pearson coeeficient correlation 
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
#compute the matrices 
covar=covmat(select(d,Not(:week)))
corr=cormat(select(d,Not(:week)))
scorr=scormat(select(d,Not(:week)))
#Plotting 
plt1=heatmap(corr,xticks=(1:36,names(d)[2:end]),yticks=(1:36,names(d)[2:end]),xrotation=45,title="Correlation")
display(plt1)
savefig("corr.png")
plt2=heatmap(covar,xticks=(1:36,names(d)[2:end]),yticks=(1:36,names(d)[2:end]),xrotation=45,title="Covariance")
display(plt2)
savefig("cov.png")
plt3=heatmap(scorr,xticks=(1:36,names(d)[2:end]),yticks=(1:36,names(d)[2:end]),xrotation=45,title="Spearman correlation")
display(plt3)
savefig("scorr.png")