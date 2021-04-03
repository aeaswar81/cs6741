using Distributions
using QuadGK
function KLDiv(distp,distq)
    #return quadgk(x -> pdf(distp,x)*log(pdf(distp,x)/pdf(distq,x)),(-10,10)...)
   
    return quadgk(x -> pdf(distp,x)*(logpdf(distp,x)-logpdf(distq,x)),-10,10)
end

Q=Normal(0,1)

P=TDist(1)
#log(0)
print("gi")
print(KLDiv(P,Q))
