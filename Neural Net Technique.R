


## %% Neural Network MODEL %% ## 

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

## Convert Categorical variables to Dummy variables

G.matrix <- model.matrix(~ GENDER - 1, data = mydata)
mydata <- data.frame(mydata, G.matrix)

OC.matrix <- model.matrix(~ OCCUPATION - 1, data = mydata)
mydata <- data.frame(mydata, OC.matrix)

AGE.matrix <- model.matrix(~ AGE_BKT - 1, data = mydata)
mydata <- data.frame(mydata, AGE.matrix)

ACC.matrix <- model.matrix(~ ACC_TYPE - 1, data = mydata)
mydata <- data.frame(mydata, ACC.matrix)

CC.matrix <- model.matrix(~ FLG_HAS_CC - 1, data = mydata)
mydata <- data.frame(mydata, CC.matrix)

CHG.matrix <- model.matrix(~ FLG_HAS_ANY_CHGS - 1, data = mydata)
mydata <- data.frame(mydata, CHG.matrix)


class(mydata.d$ACC_TYPECA)
# [1] "numeric"

class(mydata.d$ACC_TYPESA)
# [1] "numeric"


## Create Random variable with random numberw between 0 and 1

mydata$random <- runif(nrow(mydata),0,1)

## Add new coloum for these new randam data

mydata <- mydata[order(mydata$random),]

#Splitting the data into Development (70%) and Testing (30%) sample

mydata.d <- mydata[which(mydata$random <= 0.7),]
mydata.t <- mydata[which(mydata$random > 0.7),]

c(nrow(mydata.d),nrow(mydata.t))
# [1] 14004  5996

dim(mydata.d)
# [1] 14004    53

View(mydata.d)

## Remove Random variable 

mydata.d = mydata.d[, -53]
mydata.t = mydata.t[, -53]


## Create Neural Network Model

library(neuralnet)

## For Scaling We are creating new variable scale.temp [where we remove TARGER Variable] & Categorical variables]

scale.temp = mydata.d[, -c(1,2,4,5,8,17,23)]

View(scale.temp)

mydata.d.scale = scale(scale.temp)
View(mydata.d.scale)

dim(mydata.d.scale)
# [1] 14004    45

mydata.d.scaled = cbind(mydata.d[1], mydata.d.scale)
attach(mydata.d.scaled)

## Apply NeuralNer function to scaled data set

mydata.nn <- neuralnet(formula = TARGET ~
                       BALANCE
                       + SCR
                       + HOLDING_PERIOD
                       + LEN_OF_RLTN_IN_MNTH
                       + NO_OF_L_CR_TXNS
                       + NO_OF_L_DR_TXNS
                       + NO_OF_BR_CSH_WDL_DR_TXNS
                       + NO_OF_ATM_DR_TXNS 
                       + NO_OF_NET_DR_TXNS
                       + NO_OF_MOB_DR_TXNS 
                       + NO_OF_CHQ_DR_TXNS
                       + AMT_ATM_DR
                       + AMT_BR_CSH_WDL_DR
                       + AMT_CHQ_DR
                       + AMT_MOB_DR 
                       + AMT_NET_DR
                       + AMT_OTH_BK_ATM_USG_CHGS
                       + AMT_MIN_BAL_NMC_CHGS
                       + NO_OF_IW_CHQ_BNC_TXNS
                       + NO_OF_OW_CHQ_BNC_TXNS
                       + AVG_AMT_PER_ATM_TXN
                       + AVG_AMT_PER_CHQ_TXN
                       + AVG_AMT_PER_CSH_WDL_TXN 
                       + AVG_AMT_PER_MOB_TXN 
                       + AVG_AMT_PER_NET_TXN 
                       + GENDERF + GENDERM + GENDERO
                       + OCCUPATIONPROF + OCCUPATIONSAL + OCCUPATIONSELF.EMP + OCCUPATIONSENP  
                       + AGE_BKT.25 + AGE_BKT.50 + AGE_BKT26.30 + AGE_BKT31.35 
                       + AGE_BKT36.40 + AGE_BKT41.45 + AGE_BKT46.50
                       + ACC_TYPECA + ACC_TYPESA
                       + FLG_HAS_CC0 + FLG_HAS_CC1
                       + FLG_HAS_ANY_CHGS0 + FLG_HAS_ANY_CHGS1
                       ,
                data = mydata.d.scaled,
                hidden = c(7),
                err.fct = "sse",
                linear.output = FALSE,
                lifesign = "full",
                lifesign.step = 100,
                threshold = 0.1,
                stepmax = 3000
)


## PLot Neural Network

plot(mydata.nn)

## Check the % distribution of probability by using Quantile function

quantile(mydata.nn$net.result[[1]], c(0,1,5,10,25,50,75,90,95,99,100)/100)

# 0%              1%              5% 
# 0.0006426217346 0.0006532012302 0.0036834693699 
# 10%             25%             50% 
# 0.0036943131520 0.0176061117260 0.0298850307133 
# 75%             90%             95% 
# 0.1285330465953 0.3615562025308 0.4266808152114 
# 99%            100% 
# 0.7949657404865 0.8106565866976 

## Create Table for Scoring

nn.table = data.frame(TARGET=mydata.d.scaled$TARGET, Predict.score=mydata.nn$net.result[[1]])

nn.table$Predict.class = ifelse(nn.table$Predict.score>0.5,1,0)

with(nn.table, table(TARGET, Predict.class))

# Predict.class
# TARGET     0     1
# 0 12096   113
# 1  1461   334

Error = (1461+113)/14004
Error
# [1] 0.1123964582

## Check Neural Network Model performance using Rank Ordering and Deciling 

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

nn.table$deciles <- decile(nn.table$Predict.score)

## Create Rank Table based on Deciles

library(data.table)

tmp_DT = data.table(nn.table)

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

## For TESTING DATA SET

## For TESTING DATA mydata.t Scaling We are creating new variable scale.temp1 [where we remove TARGER Variable] & Categorical variables]

scale.temp1 = mydata.t[, -c(1,2,4,5,8,17,23)]

View(scale.temp1)

mydata.t.scale1 = scale(scale.temp1)
View(mydata.t.scale1)

dim(mydata.t.scale1)
# [1] 5996   45

mydata.t.scaled1 = cbind(mydata.t[1], mydata.t.scale1)
attach(mydata.t.scaled1)


# Use compute () function to predict the TARGER variabled for Testing set

compute.output = compute(mydata.nn, mydata.t.scaled1[,-1])
compute.output
mydata.t$Predict.score = compute.output$net.result
View(mydata.t)

## Check Unseen data Model performance using Rank Ordering and Deciling

mydata.t$deciles <- decile(mydata.t$Predict.score)

library(data.table)
tmp_DT = data.table(mydata.t)
rank2 <- tmp_DT[, list(
  cnt = length(TARGET), 
  cnt_resp = sum(TARGET), 
  cnt_non_resp = sum(TARGET == 0)) , 
  by=deciles][order(-deciles)]
rank2$rrate <- round (rank2$cnt_resp / rank2$cnt,2);
rank2$cum_resp <- cumsum(rank2$cnt_resp)
rank2$cum_non_resp <- cumsum(rank2$cnt_non_resp)
rank2$cum_rel_resp <- round(rank2$cum_resp / sum(rank2$cnt_resp),2);
rank2$cum_rel_non_resp <- round(rank2$cum_non_resp / sum(rank2$cnt_non_resp),2);
rank2$ks <- abs(rank2$cum_rel_resp - rank2$cum_rel_non_resp);

View(rank2)






