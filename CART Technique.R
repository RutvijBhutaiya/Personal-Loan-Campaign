

## %% CART MODEL %% ##

## PART 1 : Split Data into Development sample (70%) and Hold-out sample(30%)

setwd("C:/Users/server/Desktop/Machine R")
mydata = read.csv('mydata.csv')

View(mydata)

dim(mydata)

mydata = mydata[, -1]     ## Remove X count variable

str(mydata)

attach(mydata)

## Convert into Factor class ##

mydata$TARGET = as.factor(mydata$TARGET)
mydata$FLG_HAS_CC = as.factor(mydata$FLG_HAS_CC)
mydata$FLG_HAS_ANY_CHGS = as.factor(mydata$FLG_HAS_ANY_CHGS)

table(TARGET)

## BALANCE DATA

#library(ROSE)

#mydata = ROSE(TARGET~., data = mydata, seed = 1)$data
#table(mydata$TARGET)

## Create Random variable with random numberw between 0 and 1

mydata$random <- runif(nrow(mydata),0,1)

## Add new coloum for these new randam data

mydata <- mydata[order(mydata$random),]

#Splitting the data into Development (70%) and Testing (30%) sample

mydata.d <- mydata[which(mydata$random <= 0.7),]
mydata.t <- mydata[which(mydata$random > 0.7),]

c(nrow(mydata.d),nrow(mydata.t))

dim(mydata.d)
table(mydata.d$TARGET)

## Remove Random variable 

mydata.d = mydata.d[, -33]
mydata.t = mydata.t[, -33]

## Boruta function applied for All variables significant impact on TARGET variable

install.packages("Boruta")
library(Boruta)

set.seed(1234)

boruta.train <- Boruta(TARGET~., data=mydata.d, doTrace = 2)

## PART : 2 : Built CART Model 

library(rpart)
library(rpart.plot)
library(rattle)
library(RColorBrewer)

## Set Control Parameters 

r.ctrl = rpart.control(minsplit = 100, minbucket = 10, cp = 0, xval = 10)

## Build Classification Tree usinf rpart function

mydata.tree = rpart(formula = TARGET ~ ., data = mydata.d, method = "class", control = r.ctrl)
mydata.tree

fancyRpartPlot(mydata.tree)

## Check the CP parameter for Tree performance. 

printcp(mydata.tree)

plotcp(mydata.tree)


## Pruning the tree at CP = 0.00150086

mydata.tree.prun = prune(mydata.tree, cp= 0.0012  ,"CP")

printcp(mydata.tree.prun)

fancyRpartPlot(mydata.tree.prun, uniform=TRUE,  main="Pruned Classification Tree")

## For Prediction class do Scoring 

mydata.d$predict.class <- predict(mydata.tree.prun, mydata.d, type = "class")

mydata.d$predict.score <- predict(mydata.tree.prun, mydata.d, type = "prob")

View(mydata.d)

## Check CART Model performance using Rank Ordering and Deciling 

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

dim(mydata.d)

Error = (1633+1577)/14011
Error


## Apply Built model to Testing sample data set - mydata.t

## Scoring Testing sample set mydata.t

mydata.t$predict.class <- predict(mydata.tree.prun, mydata.t, type = "class")
mydata.t$predict.score <- predict(mydata.tree.prun, mydata.t, type = "prob")

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
Error2 = (831+851)/5989
Error2

dim(mydata.t)



















