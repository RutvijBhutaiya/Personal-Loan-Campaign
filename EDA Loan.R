
## MyBank Personal Loan Campaign ##

## PART 1 : Ckecking Data Variables ##

## Set Working Directory

setwd("C:/Users/server/Desktop/Machine R")

## Load MyBank Personal Moan Campaign Data set 

loan = read.csv('loan.csv')

View(loan)
attach(loan)

## Dimentions of data set ##

dim(loan)


## Check Missing Values in Data Set ##

colSums(is.na(loan))

## Structure of Data set ##

str(loan)



loan$TARGET = as.factor(loan$TARGET)

## Convert into Factor class ## 

loan$FLG_HAS_CC = as.factor(loan$FLG_HAS_CC)
loan$FLG_HAS_NOMINEE = as.factor(loan$FLG_HAS_NOMINEE)
loan$FLG_HAS_OLD_LOAN = as.factor(loan$FLG_HAS_OLD_LOAN)
loan$FLG_HAS_ANY_CHGS = as.factor(loan$FLG_HAS_ANY_CHGS) 
 
## Summary of Data set

summary(loan)


## PART 2 : Descriptive Statistics ##

## Analyzing TARGER : Independent variable 

summary(TARGET)

## Pie Chart

pie(table(TARGET), labels = c('Non-responder', 'Responder'), 
    col = c('firebrick2', 'cornflowerblue'), main = 'Pie Chart : Responder and Non Responder')

## Percentage % Allocation of Responder [1] and Non-Responder [0]

as.matrix((prop.table(table(TARGET)))*100)

## Before Descriptive Statistics Recommender Change in Data Set variales

## After Analyzing dependent variables  [## %% EXPLAIN %% ## EACH POINT]
      ## 1. We recommend to remove CUST_ID
      ## 2. We recommend to remove TOT_NO_OF_L_TXNS [Total No. of Transaction] : As it is reflection of ____                                        
      ## 3. We recommend to remove AMT_L_DR [Total Amount Debited] as reflection of ______
      

## MyBank Personal Loan campaign Data set for Descriptive Statistics

loan = loan[, -c(1,15,27)]

library(ggplot2)


## Histogram 

par(mfrow = c(2,3))

hist(AGE, main = 'Age', col = 'darkseagreen')
hist(BALANCE, main = 'Balance', col = 'darkseagreen')
hist(SCR, main = 'Generic Marketing Score', col = 'darkseagreen')
hist(HOLDING_PERIOD,  main = 'Ability to hold money in the account', col = 'darkseagreen')
hist(LEN_OF_RLTN_IN_MNTH,  main = 'Length of Relationship in Months', col = 'darkseagreen')
hist(NO_OF_L_CR_TXNS, main = 'No. of Credit Transactions', col = 'darkseagreen')

hist(NO_OF_L_DR_TXNS, main = 'No. of Debit Transactions', col = 'darkseagreen')
hist(NO_OF_BR_CSH_WDL_DR_TXNS,  main = 'No. of Branch Cash Withdrawal Transactions' , col = 'darkseagreen')
hist(NO_OF_ATM_DR_TXNS, main = 'No. of ATM Debit Transactions', col = 'darkseagreen')
hist(NO_OF_NET_DR_TXNS, main = 'No. of Net Debit Transactions', col = 'darkseagreen' )
hist(NO_OF_MOB_DR_TXNS, main = 'No. of Mobile Banking Debit Transactions', col = 'darkseagreen' )
hist(NO_OF_CHQ_DR_TXNS, main = 'No. of Cheque Debit Transactions', col = 'darkseagreen')

hist(AMT_ATM_DR, main = 'Amount Withdrawn from ATM', col = 'darkseagreen' )
hist(AMT_BR_CSH_WDL_DR, main = 'Amount cash withdrawn from Branch ', col = 'darkseagreen' )
hist(AMT_CHQ_DR, main = 'Amount debited by Cheque Transactions', col = 'darkseagreen' )
hist(AMT_NET_DR, main = 'Amount debited by Net Transactions', col = 'darkseagreen' )
hist(AMT_MOB_DR, main = 'Amount debited by Mobile Banking Transactions', col = 'darkseagreen' )
hist(AMT_OTH_BK_ATM_USG_CHGS, main = 'Amount charged by way of the Other Bank ATM usage', col = 'darkseagreen')

hist(AMT_MIN_BAL_NMC_CHGS, main = 'Amount charged by way Minimum Balance not maintained', col = 'darkseagreen' )
hist(NO_OF_IW_CHQ_BNC_TXNS, main = 'NO. OF TRANX charged by way Inward Cheque Bounce', col = 'darkseagreen')
hist(NO_OF_OW_CHQ_BNC_TXNS, main = 'NO. OF TRANX charged by way Outward Cheque Bounce', col = 'darkseagreen' )
hist(AVG_AMT_PER_ATM_TXN, main = 'Avg. Amt withdrawn per ATM Transaction', col = 'darkseagreen')
hist(AVG_AMT_PER_CSH_WDL_TXN, main = 'Avg. Amt withdrawn per Cash Withdrawal Transaction', col = 'darkseagreen' )
hist(AVG_AMT_PER_CHQ_TXN, main = 'Avg. Amt debited per Cheque Transaction', col = 'darkseagreen' )

hist(AVG_AMT_PER_NET_TXN, main = 'Avg. Amt debited per Net Transaction',  col = 'darkseagreen')
hist(AVG_AMT_PER_MOB_TXN,  main = 'Avg. Amt debited per Mobile Banking Transaction', col = 'darkseagreen')
hist(random, main = 'Random Number', col = 'darkseagreen')


## Check variables' Significant Impact on Independent Variable

## Age Summary [NOT Significant]

ggplot(data=loan, mapping=aes(x="", y=AGE)) + geom_boxplot(aes(color=TARGET))

## Gender Summary [Significant]

chisq.test(TARGET, GENDER)
as.matrix((prop.table(table(GENDER)))*100)

## Average Monthly Balance Summary [Significant]

ggplot(data=loan, mapping=aes(x="", y=BALANCE)) + geom_boxplot(aes(color=TARGET))

## Occupation Summary [Significant]

chisq.test(TARGET, OCCUPATION)
as.matrix((prop.table(table(OCCUPATION)))*100)

## Age Bucket Summary [Significant]

chisq.test(TARGET, AGE_BKT)
as.matrix((prop.table(table(AGE_BKT)))*100)

## Generic Marketing Score Summary [Significant]

ggplot(data=loan, mapping=aes(x="", y=SCR)) + geom_boxplot(aes(color=TARGET))

## Ability to hold money in the account Summary [Significant]

ggplot(data=loan, mapping=aes(x="", y=HOLDING_PERIOD)) + geom_boxplot(aes(color=TARGET))

## Account Type - Saving / Current Summary [Significant]

chisq.test(TARGET, ACC_TYPE)
as.matrix((prop.table(table(ACC_TYPE)))*100)

## Length of Relationship in Months Summary [Significant]

ggplot(data=loan, mapping=aes(x="", y=LEN_OF_RLTN_IN_MNTH)) + geom_boxplot(aes(color=TARGET))

## No. of Credit Transactions Summary [Significant]

ggplot(data=loan, mapping=aes(x="", y=NO_OF_L_CR_TXNS)) + geom_boxplot(aes(color=TARGET))

## No. of Debit Transactions Summary [Significant]

ggplot(data=loan, mapping=aes(x="", y=NO_OF_L_DR_TXNS)) + geom_boxplot(aes(color=TARGET))

## No. of Branch Cash Withdrawal Transactions Summary [Significant]

chisq.test(TARGET, NO_OF_BR_CSH_WDL_DR_TXNS)
as.matrix((prop.table(table(NO_OF_BR_CSH_WDL_DR_TXNS)))*100)

## No. of ATM Debit Transactions Summary [Significant]

chisq.test(TARGET, NO_OF_ATM_DR_TXNS)
as.matrix((prop.table(table(NO_OF_ATM_DR_TXNS)))*100)

## No. of Net Debit Transactions Summary [Significant]

chisq.test(TARGET, NO_OF_NET_DR_TXNS)
as.matrix((prop.table(table(NO_OF_NET_DR_TXNS)))*100)

## No. of Mobile Banking Debit Transactions Summary [Significant]

chisq.test(TARGET, NO_OF_MOB_DR_TXNS)
as.matrix((prop.table(table(NO_OF_MOB_DR_TXNS)))*100)

## No. of Cheque Debit Transactions Summary [Significant]

chisq.test(TARGET, NO_OF_CHQ_DR_TXNS)
as.matrix((prop.table(table(NO_OF_CHQ_DR_TXNS)))*100)

## Has Credit Card - 1: Yes, 0: No Summary [Significant]

chisq.test(TARGET, FLG_HAS_CC)
as.matrix((prop.table(table(FLG_HAS_CC)))*100)

## Amount Withdrawn from ATM Summary [Significant]

ggplot(data=loan, mapping=aes(x="", y=AMT_ATM_DR)) + geom_boxplot(aes(color=TARGET))

## Amount cash withdrawn from Branch Summary [Significant]

ggplot(data=loan, mapping=aes(x="", y=AMT_BR_CSH_WDL_DR)) + geom_boxplot(aes(color=TARGET))

## Amount debited by Cheque Transactions Summary [Significant]

ggplot(data=loan, mapping=aes(x="", y=AMT_CHQ_DR)) + geom_boxplot(aes(color=TARGET))

## Amount debited by Net Transactions Summary [Significant]

ggplot(data=loan, mapping=aes(x="", y=AMT_NET_DR)) + geom_boxplot(aes(color=TARGET))
 
## Amount debited by Mobile Banking Transactions Summary [Significant]

ggplot(data=loan, mapping=aes(x="", y=AMT_MOB_DR)) + geom_boxplot(aes(color=TARGET))

## Has any banking charges - 1: Yes, 0: No Summary [Significant]

chisq.test(TARGET, FLG_HAS_ANY_CHGS)
as.matrix((prop.table(table(FLG_HAS_ANY_CHGS)))*100)

## Amount charged by way of the Other Bank ATM usage Summary [Significant]

ggplot(data=loan, mapping=aes(x="", y=AMT_OTH_BK_ATM_USG_CHGS)) + geom_boxplot(aes(color=TARGET))

## Amount charged by way Minimum Balance not maintained Summary [Significant]

ggplot(data=loan, mapping=aes(x="", y=AMT_MIN_BAL_NMC_CHGS)) + geom_boxplot(aes(color=TARGET))

## NO. OF TRANX Amount charged by way Inward Cheque Bounce Summary [Significant]

chisq.test(TARGET, NO_OF_IW_CHQ_BNC_TXNS)
as.matrix((prop.table(table(NO_OF_IW_CHQ_BNC_TXNS)))*100)

## NO. OF TRANX Amount charged by way Outward Cheque Bounce Summary [Significant]

chisq.test(TARGET, NO_OF_OW_CHQ_BNC_TXNS)
as.matrix((prop.table(table(NO_OF_OW_CHQ_BNC_TXNS)))*100)

## Avg. Amt withdrawn per ATM Transaction Summary [Significant]

ggplot(data=loan, mapping=aes(x="", y=AVG_AMT_PER_ATM_TXN)) + geom_boxplot(aes(color=TARGET))

## Avg. Amt withdrawn per Cash Withdrawal Transaction Summary [Significant]

ggplot(data=loan, mapping=aes(x="", y=AVG_AMT_PER_CSH_WDL_TXN)) + geom_boxplot(aes(color=TARGET))

## Avg. Amt debited per Cheque Transaction Summary [Significant]

ggplot(data=loan, mapping=aes(x="", y=AVG_AMT_PER_CHQ_TXN)) + geom_boxplot(aes(color=TARGET))

## Avg. Amt debited per Net Transaction Summary [Significant]

ggplot(data=loan, mapping=aes(x="", y=AVG_AMT_PER_NET_TXN)) + geom_boxplot(aes(color=TARGET))

## Avg. Amt debited per Mobile Banking Transaction Summary [Significant]

ggplot(data=loan, mapping=aes(x="", y=AVG_AMT_PER_MOB_TXN)) + geom_boxplot(aes(color=TARGET))

## Has Nominee - 1: Yes, 0: No Summary [NOT Significant]

chisq.test(TARGET, FLG_HAS_NOMINEE)
as.matrix((prop.table(table(FLG_HAS_NOMINEE)))*100)

## Has any earlier loan - 1: Yes, 0: No Summary [NOT Significant]

chisq.test(TARGET, FLG_HAS_OLD_LOAN)
as.matrix((prop.table(table(FLG_HAS_OLD_LOAN)))*100)

## Random Number Summary [NOT Significant]

ggplot(data=loan, mapping=aes(x="", y=random)) + geom_boxplot(aes(color=TARGET))


## Remove Variables which are NOT Significant to TARGER Variable

## NOTE : Here we also drop Account Open Date : ACC_OP_DATE variable : As it's reflection of _______ 

loan = loan [, -c(2,10,35,36,37)]

dim(loan)

View(loan)


## Normalize Variable based on skewness

library(moments)
library(forecast)

## Apply Boxcox.lambda () test to check normalization technique

BoxCox.lambda(BALANCE)                          ## Apply Log & Squar
BoxCox.lambda(SCR)                              ## Apply Inverse Squar root & Reciprocal
BoxCox.lambda(NO_OF_L_CR_TXNS)                  ## Apply Log
BoxCox.lambda(NO_OF_L_DR_TXNS)                  ## Apply Log


BoxCox.lambda(NO_OF_BR_CSH_WDL_DR_TXNS)         ## Apply Log & Sqr root
BoxCox.lambda(NO_OF_ATM_DR_TXNS)                ## Apply Log 
BoxCox.lambda(NO_OF_NET_DR_TXNS)                ## Apply Log $ Srq root
BoxCox.lambda(NO_OF_MOB_DR_TXNS)                ## Apply Log $ Srq root
BoxCox.lambda(NO_OF_CHQ_DR_TXNS)                ## Apply Log


BoxCox.lambda(AMT_ATM_DR)                       ## Apply Log & Squar
BoxCox.lambda(AMT_BR_CSH_WDL_DR)                ## Apply Log & Squar
BoxCox.lambda(AMT_CHQ_DR)                       ## Apply Log
BoxCox.lambda(AMT_NET_DR)                       ## Apply Log & Squar
BoxCox.lambda(AMT_MOB_DR)                       ## Apply Log
BoxCox.lambda(AMT_OTH_BK_ATM_USG_CHGS)          ## Apply Log
BoxCox.lambda(AMT_MIN_BAL_NMC_CHGS)             ## Apply Sqrt  
BoxCox.lambda(AVG_AMT_PER_ATM_TXN)              ## Apply Log & Squar
BoxCox.lambda(AVG_AMT_PER_CSH_WDL_TXN)          ## Apply Log & Squar
BoxCox.lambda(AVG_AMT_PER_CHQ_TXN)              ## Apply Log
BoxCox.lambda(AVG_AMT_PER_NET_TXN)              ## Apply Log & Squar
BoxCox.lambda(AVG_AMT_PER_MOB_TXN)              ## Apply Log & Squar

## Apply Normalization Technique

hist(AMT_NET_DR)

BALANCE = log(BALANCE)
BALANCE = (BALANCE^2)
  
SCR = 1/(sqrt(SCR))
SCR = 1/SCR

NO_OF_L_CR_TXNS = log(NO_OF_L_CR_TXNS)

NO_OF_L_DR_TXNS = log(NO_OF_L_DR_TXNS)

NO_OF_BR_CSH_WDL_DR_TXNS = log(NO_OF_BR_CSH_WDL_DR_TXNS)
NO_OF_BR_CSH_WDL_DR_TXNS = sqrt(NO_OF_BR_CSH_WDL_DR_TXNS)

NO_OF_ATM_DR_TXNS = log(NO_OF_ATM_DR_TXNS)
NO_OF_ATM_DR_TXNS = log(NO_OF_ATM_DR_TXNS)

NO_OF_NET_DR_TXNS = log(NO_OF_NET_DR_TXNS)
NO_OF_NET_DR_TXNS = sqrt(NO_OF_NET_DR_TXNS)

NO_OF_MOB_DR_TXNS = log(NO_OF_MOB_DR_TXNS)
NO_OF_MOB_DR_TXNS = log(NO_OF_MOB_DR_TXNS)

NO_OF_CHQ_DR_TXNS = log(NO_OF_CHQ_DR_TXNS)

AMT_ATM_DR = log(AMT_ATM_DR)
AMT_ATM_DR = (AMT_ATM_DR^2)

AMT_BR_CSH_WDL_DR = log(AMT_BR_CSH_WDL_DR)
AMT_BR_CSH_WDL_DR = (AMT_BR_CSH_WDL_DR^2)
AMT_BR_CSH_WDL_DR = (AMT_BR_CSH_WDL_DR^2)
AMT_BR_CSH_WDL_DR = (AMT_BR_CSH_WDL_DR^2)
AMT_BR_CSH_WDL_DR = (AMT_BR_CSH_WDL_DR^2)


AMT_CHQ_DR = log(AMT_CHQ_DR)

AMT_NET_DR = log(AMT_NET_DR)
AMT_NET_DR = (AMT_NET_DR^2)
AMT_NET_DR = (AMT_NET_DR^2)
AMT_NET_DR = (AMT_NET_DR^2)
AMT_NET_DR = (AMT_NET_DR^2)

AMT_MOB_DR = log(AMT_MOB_DR)
AMT_MOB_DR = (AMT_MOB_DR^2)
AMT_MOB_DR = (AMT_MOB_DR^2)
AMT_MOB_DR = (AMT_MOB_DR^2)

AMT_OTH_BK_ATM_USG_CHGS = log(AMT_OTH_BK_ATM_USG_CHGS)

AMT_MIN_BAL_NMC_CHGS = sqrt(AMT_MIN_BAL_NMC_CHGS)
AMT_MIN_BAL_NMC_CHGS = sqrt(AMT_MIN_BAL_NMC_CHGS)
AMT_MIN_BAL_NMC_CHGS = sqrt(AMT_MIN_BAL_NMC_CHGS)

AVG_AMT_PER_ATM_TXN = log(AVG_AMT_PER_ATM_TXN)
AVG_AMT_PER_ATM_TXN = (AVG_AMT_PER_ATM_TXN^2)
AVG_AMT_PER_ATM_TXN = (AVG_AMT_PER_ATM_TXN^2)
AVG_AMT_PER_ATM_TXN = (AVG_AMT_PER_ATM_TXN^2)

AVG_AMT_PER_CSH_WDL_TXN = log(AVG_AMT_PER_CSH_WDL_TXN)
AVG_AMT_PER_CSH_WDL_TXN = (AVG_AMT_PER_CSH_WDL_TXN^2)
AVG_AMT_PER_CSH_WDL_TXN = (AVG_AMT_PER_CSH_WDL_TXN^2)
AVG_AMT_PER_CSH_WDL_TXN = (AVG_AMT_PER_CSH_WDL_TXN^2)

AVG_AMT_PER_CHQ_TXN = log(AVG_AMT_PER_CHQ_TXN)

AVG_AMT_PER_NET_TXN = log(AVG_AMT_PER_NET_TXN)
AVG_AMT_PER_NET_TXN = (AVG_AMT_PER_NET_TXN^2)
AVG_AMT_PER_NET_TXN = (AVG_AMT_PER_NET_TXN^2)
AVG_AMT_PER_NET_TXN = (AVG_AMT_PER_NET_TXN^2)

AVG_AMT_PER_MOB_TXN = log(AVG_AMT_PER_MOB_TXN)
AVG_AMT_PER_MOB_TXN = (AVG_AMT_PER_MOB_TXN^2)
AVG_AMT_PER_MOB_TXN = (AVG_AMT_PER_MOB_TXN^2)
AVG_AMT_PER_MOB_TXN = (AVG_AMT_PER_MOB_TXN^2)


## Save file as mydata.csv for CART, Random Forest and Neural Networks ML Modeling.

setwd("C:/Users/server/Desktop/Machine R")
write.csv(loan, 'mydata.csv')








































