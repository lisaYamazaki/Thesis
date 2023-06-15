##Split data
selected_comparison<-dt_all[18:184, ]

n <- nrow(selected_comparison) # Calculate the total number of elements in your data
trainnrow <- floor(n * 0.8)
MMM_train <- slice(selected_comparison,1:trainnrow)

valrow <- floor(n* 0.1)
MMM_val <- slice(selected_comparison, (nrow(MMM_train) + 1):(nrow(MMM_train) + valrow))

testrow <- floor(n* 0.1)
MMM_test <- slice(selected_comparison, (nrow(MMM_train) + nrow(MMM_val) + 1):(nrow(MMM_train) + nrow(MMM_val) + testrow))

#use lm() function to specify the model 
MMMmodel <- lm(Sales~TrdA+TrdB+DgtA+DgtB+DgtD+DgtD+PDgtA+PDgtB+TDP+Price+lockdown+Events, data=dt_all)
summary(MMMmodel)

#predict model
MMM_p <- predict(MMMmodel, newdata = MMM_test)

#MAPE
library(MLmetrics)
L_true <- MMM_test$Sales
#mape
Mape <-MAPE(MMM_p, L_true)

#rsquare
L_ssr <- sum((MMM_p - mean(L_true))^2)
L_sst <- sum((L_true - mean(L_true))^2)
rsquared_linear <- 1 - (L_ssr/L_sst)
adjusted_linear <-1-(1-rsquared_linear)*((18-1)/(18-12-1))



######Uniform predictor
unifornpredictor<-mean(MMM_train$Sales)
mean(MMM_test$Sales)
MMM_u <- rep(unifornpredictor,16)
Mape_u <-MAPE(MMM_u, L_true)

U_ssr <- sum((MMM_u - mean(L_true))^2)
U_sst <- sum((L_true - mean(L_true))^2)
rsquared_u <- 1 - (U_ssr/U_sst)





