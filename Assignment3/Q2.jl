#Using VSCode
using Distributions 
using Plots
using StatsBase
pyplot()
default(size =(500, 500))
#to store the kl values 
kl=[]
function convol(n)
    #set the points on the axis 
    a=collect(0:0.01:10)
    #list onto which convolved values are stored
    c=[]
    #store the first uniform distribution 
    for i in a
        push!(c,pdf(Uniform(0,1),i))
    end
    #define the convolution function 
    #first function is uniform ,second is the resulting function 
    function conv(x)
    sum(pdf(Uniform(0,1),x-a[k])*c[k] for k in 1:length(a))
    end
    #convolve n-1 times 
    for i in 1:n-1
        c=conv.(a)
        #normalize
        c=c./101
    end
    #c holds the resulting distribution of convolutions
    #Next find the weighted mean and deviation
    #this is to find the normal which will fit this
    m=StatsBase.mean(a,weights(c))
    st=StatsBase.std(a,weights(c))
    #perform KL divergence of the normal and result
    let 
        #initializing sum to 0 
        sum=0
        norm=Normal(m,st)
        for i in 1:length(a)
            if c[i]!=0
                sum+= (c[i]*log(c[i]/pdf(norm,a[i])))
            end
       

        end
        #return the KL divergence
        return sum 
        
    end
    
    #to see the plot of Normal and result, the below 
    #code can be uncommented 
    #plt1=plot(a,c,label="convolved")
    #plot!(a,pdf(Normal(m,st),a),label="normal")
    #display(plt1)
end
#do the covolution for 2 to 10 
for i in 2:10
    #store the value in the kl list 
    push!(kl,convol(i))
end
for i in 2:10
    println("The KL divergence for n ",i," is ",kl[i-1])
end
#plot the KL divergence against n 
plt2=scatter(2:10,kl,title="KL Divergence vs n",label=false,xlabel="n",ylabel="KL divergence")
plot!(2:10,kl,label=false)
display(plt2)
savefig("KLplot.png")

