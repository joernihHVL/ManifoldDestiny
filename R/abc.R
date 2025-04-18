##########################################################################################################
#' @export comdat
comdat <- function(dr=goext,plr=1,zv=c('NULL','NULL'),xv=c('NULL','NULL'),yv=c('NULL','NULL')){
  P <- dr['P']
  le <- dim(P)[1]
  dr <- dplyr::arrange(dr,P)
  ### Data
  #if (is.null(zv[1]) {zv[[1]]<- rep(0,le)}
  #if (is.null(zv[2]) {zv[[2]]<- rep(0,le)}
  #if (is.null(xv[2]) {xv[[1]]<- rep(0,le)}
  #if (is.null(xv[2]) {xv[[2]]<- rep(0,le)}
  #if (is.null(yv[2]) {yv[[1]]<- rep(0,le)}
  #if (is.null(yv[2]) {yv[[2]]<- rep(0,le)}
  z0 <- complex(real=rep(1,le),imaginary=rep(0,le))
  x0 <- complex(real=rep(1,le),imaginary=rep(0,le))
  y0 <- complex(real=rep(1,le),imaginary=rep(0,le))
  zi <- complex(real=dr[[zv[1]]],imaginary=dr[[zv[2]]])
  xi <- complex(real=dr[[xv[1]]],imaginary=dr[[xv[2]]])
  yi <- complex(real=dr[[yv[1]]],imaginary=dr[[yv[2]]])
  vin <- data.frame(zi,x0,y0,xi,yi)
  pls <- list(c('x0y0','x0y1','x1y0'),c('x0y0','x0y1','x1y0','x0y2','x1y1','x2y0'),c('x0y0','x0y1','x1y0','x0y2','x1y1','x2y0','x0y3','x1y2','x2y1','x3y0'))[[plr]]
  oc <- sapply(pls,function(cn){
  	rp <- as.numeric(substr(cn,2,2))
  	cp <- as.numeric(substr(cn,4,4))
  	xn <- xi^rp
  	yn <- yi^cp
  	fp <- Re(xn)*Re(yn)-Im(xn)*Im(yn)
  	sp <- Re(xn)*Im(yn)+Im(xn)*Re(yn)
  	complex(real=fp,imaginary=sp)
  })
  dfxz <- dplyr::bind_cols(as.data.frame(zi),as.data.frame(oc))
}
#' @export olsce
olsce <- function(dr=goext){
  Y <- as.matrix(dplyr::select(dr,names(dr)[1]))
  X <- as.matrix(dplyr::select(dr,names(dr)[-1]))
  ### Estimated coefficients
  slv <- solve(Conj(t(X)) %*% X, Conj(t(X)) %*% Y)
  beta_cr <- complex(real=Re(slv),imaginary=Im(slv))
  ex_o <- X %*% as.vector(beta_cr)
  ##
  res <- complex(real=Re(ex_o)-Re(Y),imaginary=0)
  tss <- complex(real=Re(Y)-Re(mean(ex_o)),imaginary=0)
  RSS <- complex(real=Re(res)^2-Im(res)^2, imaginary=2*Re(res)*Im(res))
  TSS <- complex(real=Re(tss)^2-Im(tss)^2, imaginary=2*Re(tss)*Im(tss))
  vecsq <- c(sum(Re(RSS)),sum(Im(RSS)),sum(Re(TSS)),sum(Im(TSS)))
  rc <-sqrt(vecsq[1]^2+vecsq[2]^2)
  tc <-sqrt(vecsq[3]^2+vecsq[4]^2)
  r2I <- 1-rc/tc
  list(beta=beta_cr,r2=r2I)
}
##########################################################################################################
#' @export abc
abc <- function(){
	2+2
}


