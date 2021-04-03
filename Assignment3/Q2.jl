using Distributions 
using Plots
using StatsBase
function convol(n)
    a=collect(0:0.01:8)
    print(length(a))
    c=[]
    for i in a
        push!(c,pdf(Uniform(0,1),i))
    end
    function conv(x)
    sum(pdf(Uniform(0,1),x-a[k])*c[k] for k in 1:length(a))
    end
    for i in 1:n-1
        c=conv.(a)
        #normalize
        c=c./101
    end
    print(c)
    m=StatsBase.mean(a,weights(c))
    st=StatsBase.std(a,weights(c))
    print("st we",st)
    plt1=plot(a,c)
    plot!(a,pdf(Normal(m,st),a))
    display(plt1)
end
convol(8)


