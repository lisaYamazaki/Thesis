##Split data
n <- nrow(dt_all) # Calculate the total number of elements in your data
trainnrow <- floor(n * 0.8)
MMM_train <- slice(dt_all,1:trainnrow)

valrow <- floor(n* 0.1)
MMM_val <- slice(dt_all, (nrow(MMM_train) + 1):(nrow(MMM_train) + valrow))

testrow <- floor(n* 0.1)
MMM_test <- slice(dt_all, (nrow(MMM_train) + nrow(MMM_val) + 1):(nrow(MMM_train) + nrow(MMM_val) + testrow))

#use lm() function to specify the model 
MMMmodel <- lm(Sales~TrdA+TrdB+DgtA+DgtB+DgtD+DgtD+PDgtA+PDgtB+TDP+Price+lockdown+Events, data=dt_all)

#Check for multicollinearity using VIFs
library(mctest)
imcdiag(MMMmodel, method = "VIF")
#heteroskedacity
par(mfrow=c(2,2)) # put all 4 charts into 1 page
plot(MMMmodel)

library(lmtest)
lmtest::bptest(MMMmodel)
library(car)
car::ncvTest(MMMmodel)

summary(MMMmodel)

#predict model
MMM_p <- predict(MMMmodel, newdata = MMM_train)

#MAPE
library(MLmetrics)
Mape <-MAPE(MMM_p, MMM_test$Sales)

#Adj.R-square
L_true <- MMM_test$Sales


get_rsq <- function(L_true, MMM_p, p = NULL, df.int = NULL, n_train = NULL) {
  lsse <- sum((MMM_p - L_true)^2)
  lsst <- sum((L_true - mean(L_true))^2)
  lssr <- sum((MMM_p - mean(L_true))^2)
  lrsq <- 1 - lsse / (lsse+lssr) # rsq interpreted as variance explained
  lrsq_out <- lrsq
  if (!is.null(p) && !is.null(df.int)) {
    if (!is.null(n_train)) {
      n <- n_train # for oos dataset, use n from train set for adj. rsq
    } else {
      n <- length(L_true)
    }
    lrdf <- n - p - 1
    lrsq_adj <- 1 - (1 - lrsq) * ((n - df.int) / lrdf)
    lrsq_out <- lrsq_adj
  }
  return(lrsq_out)
}


