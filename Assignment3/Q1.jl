#using VSCode 
using Distributions
using QuadGK
function KLDiv(distp,distq)
    #writing log (a/b) as log a - log p also using the logpdf function
    #returning only the value and not the error 
    #integrating from -10 to 10 since this covers most of the area 
    return quadgk(x -> pdf(distp,x)*(logpdf(distp,x)-logpdf(distq,x)),-10,10)[1]
end
let 
    Q=Normal(0,1)
    for i in 1:5
        P=TDist(i)
        println("The KL divergence with T Dist freedom ",i," : ",KLDiv(P,Q) )
    end 
end