
lg=function(mu, n, ybar)
{
  mu2=mu^2
  n*(ybar*mu-mu2/2)-log(1+mu2)
}


mu_now=10
cand_sd=5

mh<-function(mu_now,type_MH,cand_sd)
{
m=1000

y=c(1.2,1.4,???0.5,0.3,0.9,2.3,1.0,0.1,1.3,1.9)
n=length(y)
ybar=mean(y)
mu_storage<-c()
mu_storage<-c(mu_storage,mu_now)
acceptance_count=0

for (i in 1:m)
{
  if (type_MH=='randomwalk')
  {
  mu_cand = rnorm(n=1, mean=mu_now, sd=cand_sd)
  }
  else
  {
    if(type_MH=='independent')
    {mu_cand = rnorm(n=1, mean=3, sd=cand_sd)}
    else
    {print("woring type of MH")
      break}
      
  }
  
  lg_alpha=lg(mu_cand,n=n,ybar = ybar)-lg(mu_now,n=n,ybar=ybar)
  alpha=exp(lg_alpha)
  if(alpha>1)
    {mu_now=mu_cand
    mu_storage<-c(mu_storage,mu_cand)
    acceptance_count=acceptance_count+1}
  else
    {random_p=runif(1)
    if(alpha>random_p)
      {mu_now=mu_cand
      acceptance_count=acceptance_count+1}
    else
      {mu_now=mu_now}
    }
  
}

list(mu=mu_storage,accpt=acceptance_count/m)

#mu_storage_keep<-mu_storage[-c(1:10)]
#hist(mu_storage_keep,freq = FALSE,breaks=100)
}


tt_0<-mh(mu_now=5,type_MH='randomwalk',cand_sd=10)
plot.ts(tt_0$mu)
tt_0$accpt

tt_1<-mh(mu_now=5,type_MH='randomwalk',cand_sd=0.005)
plot.ts(tt_1$mu)
tt_1$accpt

tt_2<-mh(mu_now=5,type_MH='randomwalk',cand_sd=0.5)
plot.ts(tt_2$mu)
tt_2$accpt


mu_keep<-tt_2$mu[-c(1:2)]
plot(density(mu_keep),xlim=c(-3,6))
curve(dt(x,df=1),lty=2,add = TRUE,col="red")
legend("topright",legend=c("Prior t-distribution pdf", "Posterior pdf"), col=c("red","black"), lty=1, bty="n")
points(ybar,0,pch=20)
legend(1,1, legend="The black dot is the mean of y",bty="n")


tt_3<-mh(mu_now=5,type_MH='independent',cand_sd=0.5)
plot.ts(tt_3$mu)
tt_3$accpt

tt_4<-mh(mu_now=5,type_MH='hello',cand_sd=0.5)
tt_4