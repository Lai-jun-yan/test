#先定義Beta distribution的pdf
f = function(x){
  if((0<x) && (x<1)){
    ((x^2)*(1-x))/beta(3,2)
  }else{
    return(0)
  }
}

#定義g(x) 選擇Uniform distribution
g <- function(x) {
  dunif(x)
}


#計算M,max(f(t)/g(t)),for all t
M = max(sapply(seq(0, 1, by = 0.001), function(x) f(x) / g(x)))

#Acceptance-Rejection Method
rejectionBeta = function(f,M){
  while(TRUE){
    x = runif(1) #從g分布中找x,且f(x)/g(x) <= M
    y = runif(1) #用Uniform distribution找機率
    if(y<f(x)/M*g(x)){
      return(x)
    } 
  }
}

#找出服從Beta distribution的隨機變數
set.seed(21)
nrep = 1000000 #大樣本更為符合想要找到的Distribution
Observations = rep(0,nrep)
for (i in 1:nrep) {
  Observations[i] = rejectionBeta(f,M)   
}

#畫圖確認
hist(Observations,breaks = seq(0,1,by=0.01),freq = FALSE,ylim = c(0,2),main = "")
y = seq(0,1,0.01)
fy = ((y^2)*(1-y))/beta(3,2) #Beta distribution(3,2)的pdf
lines(y,fy)










