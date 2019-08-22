
## %% RANDOm FOREST MODEL %% ## 

## PART 1 : Split Data into Development sample (70%) and Hold-out sample(30%)

setwd("C:/Users/server/Desktop/Machine R")
mydata = read.csv('mydata.csv')

View(mydata)

dim(mydata)

mydata = mydata[, -1]     ## Remove X count variable

str(mydata)

attach(mydata)

## Convert into Factor class ##

## mydata$TARGET = as.factor(mydata$TARGET)
mydata$FLG_HAS_CC = as.factor(mydata$FLG_HAS_CC)
mydata$FLG_HAS_ANY_CHGS = as.factor(mydata$FLG_HAS_ANY_CHGS)

## BALANCE DATA

library(ROSE)

mydata = ROSE(TARGET~., data = mydata, seed = 1)$data
table(mydata$TARGET)


mydata.d = mydata[1:16000, ]
mydata.t = mydata[16001:20000, ]

## Create Random variable with random numberw between 0 and 1

mydata$random <- runif(nrow(mydata),0,1)

## Add new coloum for these new randam data

mydata <- mydata[order(mydata$random),]

#Splitting the data into Development (70%) and Testing (30%) sample

mydata.d <- mydata[which(mydata$random <= 0.7),]
mydata.t <- mydata[which(mydata$random > 0.7),]

c(nrow(mydata.d),nrow(mydata.t))

dim(mydata.d)

## Remove Random variable 

mydata.d = mydata.d[, -33]
mydata.t = mydata.t[, -33]


## Create Random Forest Model

library(randomForest)

set.seed(123)

mydata.rf <- randomForest(as.factor(TARGET) ~ ., data = mydata.d, 
                      ntree=101, mtry = 10, nodesize = 50,
                      importance=TRUE)

print(mydata.rf)

## Choose optimal number of mtry based on Out of Bag Error (OOB)

plot(mydata.rf, main="Random Forest")

legend("topright", c("OOB", "0", "1"), text.col=1:6, lty=1:3, col=1:3)

title(main="Error Rates")

mydata.rf$err.rate

## Based on Error Rate choosing ntree = 15 and Tuning Random Forest Model

rf.tune <- tuneRF(x = mydata.d, 
              y=as.factor(mydata.d$TARGET),
              mtryStart = 8, 
              ntreeTry = 61, 
              stepFactor = 1.2, 
              improve = 0.0001, 
              trace=TRUE, 
              plot = TRUE,
              doBest = TRUE,
              nodesize = 200, 
              importance=TRUE
)

mydata.rf <- randomForest(as.factor(TARGET) ~ ., data = mydata.d, 
                          ntree=15, mtry = 15, nodesize = 200,
                          importance=TRUE)

print(mydata.rf)


## For Prediction class do Scoring 

mydata.d$predict.class <- predict(mydata.rf, mydata.d, type = "class")

mydata.d$predict.score <- predict(mydata.rf, mydata.d, type = "prob")

View(mydata.d)

## Check Random Forest Model performance using Rank Ordering and Deciling 

decile <- function(x){
  deciles <- vector(length=10)
  for (i in seq(0.1,1,.1)){
    deciles[i*10] <- quantile(x, i, na.rm=T)
  }
  return (
    ifelse(x<deciles[1], 1,
           ifelse(x<deciles[2], 2,
                  ifelse(x<deciles[3], 3,
                         ifelse(x<deciles[4], 4,
                                ifelse(x<deciles[5], 5,
                                       ifelse(x<deciles[6], 6,
                                              ifelse(x<deciles[7], 7,
                                                     ifelse(x<deciles[8], 8,
                                                            ifelse(x<deciles[9], 9, 10
                                                            ))))))))))
}

## Apply Deciles from 1 to 10 

mydata.d$deciles <- decile(mydata.d$predict.score[,2])

View(mydata.d)

## Create Rank Table based on Deciles

library(data.table)

tmp_DT = data.table(mydata.d)

rank <- tmp_DT[, list(
  cnt = length(TARGET), 
  cnt_resp = sum(TARGET), 
  cnt_non_resp = sum(TARGET == 0)) , 
  by=deciles][order(-deciles)]

rank$rrate <- round(rank$cnt_resp * 100 / rank$cnt,2);
rank$cum_resp <- cumsum(rank$cnt_resp)
rank$cum_non_resp <- cumsum(rank$cnt_non_resp)
rank$cum_rel_resp <- round(rank$cum_resp / sum(rank$cnt_resp),2);
rank$cum_rel_non_resp <- round(rank$cum_non_resp / sum(rank$cnt_non_resp),2);
rank$ks <- abs(rank$cum_rel_resp - rank$cum_rel_non_resp);

View(rank)

## Confusion Martix Error Calculation

with(mydata.d, table(TARGET, predict.class))

Error = 
Error

## Apply Built RM model to Testing sample data set - mydata.t

## Scoring Testing sample set mydata.t

mydata.t$predict.class <- predict(mydata.rf, mydata.t, type = "class")
mydata.t$predict.score <- predict(mydata.rf, mydata.t, type = "prob")

View(mydata.t)

## Check Unseen data Model performance using Rank Ordering and Deciling 

decile <- function(x){
  deciles <- vector(length=10)
  for (i in seq(0.1,1,.1)){
    deciles[i*10] <- quantile(x, i, na.rm=T)
  }
  return (
    ifelse(x<deciles[1], 1,
           ifelse(x<deciles[2], 2,
                  ifelse(x<deciles[3], 3,
                         ifelse(x<deciles[4], 4,
                                ifelse(x<deciles[5], 5,
                                       ifelse(x<deciles[6], 6,
                                              ifelse(x<deciles[7], 7,
                                                     ifelse(x<deciles[8], 8,
                                                            ifelse(x<deciles[9], 9, 10
                                                            ))))))))))
}

## Apply Deciles from 1 to 10 

mydata.t$deciles <- decile(mydata.t$predict.score[,2])

View(mydata.t)

## Create Rank Table based on Deciles

library(data.table)

tmp_DT = data.table(mydata.t)

rank2 <- tmp_DT[, list(
  cnt = length(TARGET), 
  cnt_resp = sum(TARGET), 
  cnt_non_resp = sum(TARGET == 0)) , 
  by=deciles][order(-deciles)]

rank2$rrate <- round(rank2$cnt_resp * 100 / rank2$cnt,2);
rank2$cum_resp <- cumsum(rank2$cnt_resp)
rank2$cum_non_resp <- cumsum(rank2$cnt_non_resp)
rank2$cum_rel_resp <- round(rank2$cum_resp / sum(rank2$cnt_resp),2);
rank2$cum_rel_non_resp <- round(rank2$cum_non_resp / sum(rank2$cnt_non_resp),2);
rank2$ks <- abs(rank2$cum_rel_resp - rank2$cum_rel_non_resp);

View(rank2)

## Confusion Martix Error Calculation

with(mydata.t, table(TARGET, predict.class))

Error2 = 
Error2 

dim(mydata.d)
dim(mydata.t)










