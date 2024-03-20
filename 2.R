#給定常數r(預設為1)，產生符合目標分配的直方圖，並畫出目標分配，確認是否合理
generationR = function(r = 1){

#先把目標分配定義出來
  f = function(x){
    if((x>=-1*r)&&(x<=r)){
      (2*sqrt(r^2-x^2))/(pi*r^2)
    }else{
      0
    }
  }

#選擇canditate分配  
  g = function(x){
    dnorm(x)
  }

#找出拒絕上限 M    
  M = max(sapply(seq(0, r, by = 0.001), function(x) f(x) / g(x)))
 
#Acceptance-Rejection Method
  rejectionK = function(f,M){
    while(TRUE){
      x = rnorm(1)
      y = runif(1)
      if(y<f(x)/(M*g(x))){
        return(x)
      }
    }
  }
  
#找出服從目標分配的隨機變數  
  set.seed(21)
  n = 1000000
  Observations = rep(0,n)
  for(i in 1:n){
    Observations[i]=rejectionK(f,M)
  }

#畫圖確認  
  hist(Observations,breaks = seq(-1*r,r,by=0.01),freq = FALSE,ylim = c(0,M),main = "")
  y = seq(-1*r,r,0.01)
  fy =  (2*sqrt(r^2-y^2))/(pi*r^2)
  lines(y,fy)
}

#執行函數
generationR()
