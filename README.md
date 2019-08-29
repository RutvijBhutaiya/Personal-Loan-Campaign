[In Progress..]

## Personal Loan Campaign Study

<p align="center"><img width=70% src=https://user-images.githubusercontent.com/44467789/62994503-e2637580-be79-11e9-92b3-451551935ade.jpg> 

<br>

<br>

## How To Use The Project 

<details>

<summary><b>Expand For Steps</b></summary>

<br>

__Step 1:__ [Install R Studio](https://www.rstudio.com/products/rstudio/download/#download)

__Step 2:__ Download DataSet - Great Lakes - BACP Project... [ADD LINK FOR DATA REPO- GIT]

__Step 3:__ Do the Explorarery Data Analyaia (EDA) on the Dataset... [Clone/Download][ADD LINK FOR DATA REPO- GIT]

__Step 4:__ 


</details>

<br>

### Table of Content

- [Objective](#objective)
- [Project Approach](#project-approach)
- [Setting up R Studio and Data Variables](#setting-up-r-studio-and-data-variables)
- [Descriptive Statistics and Data Preparation](#Descriptive-Statistics-and-Data-Preparation)
- [CART Machine Learning Technique](#CART-Machine-Learning-Technique)
- [Random Forest Machine Learning Technique](#Random-Forest-Machine-Learning-Technique)
- [Neural Networks Machine Learning Technique](#Neural-Networks-Machine-Learning-Technique)
- [Conclusion](#Conclusion)

<br>

### Objective

Apply supervised machine learning techniques on MyBank personal loan campaign data set. And develop machine learning algorithm models to predict the potential list of bank customers who requires Personal Loan.

<br>

### Project Approach 

- Data cleaning
- Data Normalization
- Split MyBank data set into 70:30 for development (70%) and testing (30%).
- Apply CART technique on development data set.
- Check performance measurement of CART and Apply model on unseen testing data set.
- Apply Random Forest technique on development data set.
- Check performance measurement of Random Forest and Apply model on unseen testing data set.
- Apply Neural Network technique on development data set.
- Check performance measurement of Neural Network and Apply model on unseen testing data set.
- Compare all three techniques results and make conclusion.

<br>

### Setting Up R Studio and Data Variables

Setting up R studio working directory -> Set Working Directory
```
## Set Working Directory

> setwd("C:/Users/server/Desktop/Machine R")
 
## Load MyBank Personal Moan Campaign Data set 

> loan = read.csv('loan.csv')
 
> View(loan)
> attach(loan)

	## Dimensions of data set 
> 
> dim(loan)
[1] 20000    40
```
As we see there are 20000 observations and 40 variables, including independent variable TARGET.

```
## Check Missing Values in Data Set ##
> colSums(is.na(loan))
                 CUST_ID                   TARGET 
                       0                        0 
                     AGE                   GENDER 
                       0                        0 
                 BALANCE               OCCUPATION 
                       0                        0 
                 AGE_BKT                      SCR 
                       0                        0 
          HOLDING_PERIOD                 ACC_TYPE 
                       0                        0 
             ACC_OP_DATE      LEN_OF_RLTN_IN_MNTH 
                       0                        0 
         NO_OF_L_CR_TXNS          NO_OF_L_DR_TXNS 
                       0                        0 
        TOT_NO_OF_L_TXNS NO_OF_BR_CSH_WDL_DR_TXNS 
                       0                        0 
       NO_OF_ATM_DR_TXNS        NO_OF_NET_DR_TXNS 
                       0                        0 
       NO_OF_MOB_DR_TXNS        NO_OF_CHQ_DR_TXNS 
                       0                        0 
              FLG_HAS_CC               AMT_ATM_DR 
                       0                        0 
       AMT_BR_CSH_WDL_DR               AMT_CHQ_DR 
                       0                        0 
              AMT_NET_DR               AMT_MOB_DR 
                       0                        0 
                AMT_L_DR         FLG_HAS_ANY_CHGS 
                       0                        0 
 AMT_OTH_BK_ATM_USG_CHGS     AMT_MIN_BAL_NMC_CHGS 
                       0                        0 
   NO_OF_IW_CHQ_BNC_TXNS    NO_OF_OW_CHQ_BNC_TXNS 
                       0                        0 
     AVG_AMT_PER_ATM_TXN  AVG_AMT_PER_CSH_WDL_TXN 
                       0                        0 
     AVG_AMT_PER_CHQ_TXN      AVG_AMT_PER_NET_TXN 
                       0                        0 
     AVG_AMT_PER_MOB_TXN          FLG_HAS_NOMINEE 
                       0                        0 
        FLG_HAS_OLD_LOAN                   random 
                       0                        0 
```

Data represents no missing values. Not having missing values in original data set actually improves model quality. 
	 ## Structure of Data set 
```
> str(loan)

'data.frame':	20000 obs. of  40 variables:
 $ CUST_ID                 : Factor w/ 20000 levels "C1","C10","C100",..: 17699 16532 11027 17984 2363 11747 18115 15556 15216 12494 ...
 $ TARGET                  : int  0 0 0 0 0 0 0 0 0 0 ...
 $ AGE                     : int  27 47 40 53 36 42 30 53 42 30 ...
 $ GENDER                  : Factor w/ 3 levels "F","M","O": 2 2 2 2 2 1 2 1 1 2 ...
 $ BALANCE                 : num  3384 287489 18217 71720 1671623 ...
 $ OCCUPATION              : Factor w/ 4 levels "PROF","SAL","SELF-EMP",..: 3 2 3 2 1 1 1 2 3 1 ...
 $ AGE_BKT                 : Factor w/ 7 levels "<25",">50","26-30",..: 3 7 5 2 5 6 3 2 6 3 ...
 $ SCR                     : int  776 324 603 196 167 493 479 562 105 170 ...
 $ HOLDING_PERIOD          : int  30 28 2 13 24 26 14 25 15 13 ...
 $ ACC_TYPE                : Factor w/ 2 levels "CA","SA": 2 2 2 1 2 2 2 1 2 2 ...
 $ ACC_OP_DATE             : Factor w/ 4869 levels "01-01-00","01-01-01",..: 3270 1806 3575 993 2861 862 4533 3160 257 334 ...
 $ LEN_OF_RLTN_IN_MNTH     : int  146 104 61 107 185 192 177 99 88 111 ...
 $ NO_OF_L_CR_TXNS         : int  7 8 10 36 20 5 6 14 18 14 ...
 $ NO_OF_L_DR_TXNS         : int  3 2 5 14 1 2 6 3 14 8 ...
 $ TOT_NO_OF_L_TXNS        : int  10 10 15 50 21 7 12 17 32 22 ...
 $ NO_OF_BR_CSH_WDL_DR_TXNS: int  0 0 1 4 1 1 0 3 6 3 ...
 $ NO_OF_ATM_DR_TXNS       : int  1 1 1 2 0 1 1 0 2 1 ...
 $ NO_OF_NET_DR_TXNS       : int  2 1 1 3 0 0 1 0 4 0 ...
 $ NO_OF_MOB_DR_TXNS       : int  0 0 0 1 0 0 0 0 1 0 ...
 $ NO_OF_CHQ_DR_TXNS       : int  0 0 2 4 0 0 4 0 1 4 ...
 $ FLG_HAS_CC              : int  0 0 0 0 0 1 0 0 1 0 ...
 $ AMT_ATM_DR              : int  13100 6600 11200 26100 0 18500 6200 0 35400 18000 ...
 $ AMT_BR_CSH_WDL_DR       : int  0 0 561120 673590 808480 379310 0 945160 198430 869880 ...
 $ AMT_CHQ_DR              : int  0 0 49320 60780 0 0 10580 0 51490 32610 ...
 $ AMT_NET_DR              : num  973557 799813 997570 741506 0 ...
 $ AMT_MOB_DR              : int  0 0 0 71388 0 0 0 0 170332 0 ...
 $ AMT_L_DR                : num  986657 806413 1619210 1573364 808480 ...
 $ FLG_HAS_ANY_CHGS        : int  0 1 1 0 0 0 1 0 0 0 ...
 $ AMT_OTH_BK_ATM_USG_CHGS : int  0 0 0 0 0 0 0 0 0 0 ...
 $ AMT_MIN_BAL_NMC_CHGS    : int  0 0 0 0 0 0 0 0 0 0 ...
 $ NO_OF_IW_CHQ_BNC_TXNS   : int  0 0 0 0 0 0 0 0 0 0 ...
 $ NO_OF_OW_CHQ_BNC_TXNS   : int  0 0 1 0 0 0 0 0 0 0 ...
 $ AVG_AMT_PER_ATM_TXN     : num  13100 6600 11200 13050 0 ...
 $ AVG_AMT_PER_CSH_WDL_TXN : num  0 0 561120 168398 808480 ...
 $ AVG_AMT_PER_CHQ_TXN     : num  0 0 24660 15195 0 ...
 $ AVG_AMT_PER_NET_TXN     : num  486779 799813 997570 247169 0 ...
 $ AVG_AMT_PER_MOB_TXN     : num  0 0 0 71388 0 ...
 $ FLG_HAS_NOMINEE         : int  1 1 1 1 1 1 0 1 1 0 ...
 $ FLG_HAS_OLD_LOAN        : int  1 0 1 0 0 1 1 1 1 0 ...
 $ random                  : num  1.14e-05 1.11e-04 1.20e-04 1.37e-04 1.74e-04 ...

```

In the present data set most of the variables are integer. However, TARGET variable which is independent, represents 0-No and 1-Yes. Yes represents customers have responded positively towards personal loan campaign, and are highly potential customers to apply for personal loan. 
We also observed from the structure of the data represented that, variables FLG_HAS_CC, FLG_HAS_ANY_CHGS, FLG_HAS_NOMINEE and FLG_HAS_OLD_LOAN are factors (either YES or NO). Accordingly, we transferred these variables into factor.
```
#### Convert into Factor class ## 

> loan$FLG_HAS_CC = as.factor(loan$FLG_HAS_CC)

> loan$FLG_HAS_NOMINEE = as.factor(loan$FLG_HAS_NOMINEE)

> loan$FLG_HAS_OLD_LOAN = as.factor(loan$FLG_HAS_OLD_LOAN)

> loan$FLG_HAS_ANY_CHGS = as.factor(loan$FLG_HAS_ANY_CHGS)

```
Before moving forward we’ll take a look on summary. 


Now, before moving forward we are analyzing TARGET variable. 
```
 ## Analyzing TARGER: Independent variable 
> 
> summary(TARGET)

   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 0.0000  0.0000  0.0000  0.1256  0.0000  1.0000 

Out of 20000 observations, YES (Responder class) 2512 and NO (Non-Responder class) is 17488. 
 ## Percentage % Allocation of Responder [1] and Non-Responder [0]
> 
> as.matrix((prop.table(table(TARGET)))*100)

   [,1]
0 87.44
1 12.56
```

<p align="center"><img width=68% src=https://user-images.githubusercontent.com/44467789/63209047-a50d1b00-c0f9-11e9-9ea5-9f31e59606b6.png>
  
<br>

Based on variables summary table most we recommend removing, 
•	CUST_ID, 
•	TOT_NO_OF_L_TXNS [as reflection of NO_OF_L_CR_TXNS and NO_OF_L_DR_TXNS], 
•	AMT_L_DR [as reflection of AMT_CHQ_DR, AMT_NET_DR and AMT_MOB_DR],
```
 ## MyBank Personal Loan campaign Data set for Descriptive Statistics
> 
> loan = loan[, -c(1,15,27)]
```

<br>

### Descriptive Statistics and Data Preparation 

Under descriptive statistics we’ll start with Histogram and try to find out whether the variable is normal, right skewed or left skewed. 
```
R Studio codes for Histogram are attached in annexure A. 
	> library(ggplot2)
```

<p align="center"><img width=70% src=https://user-images.githubusercontent.com/44467789/63209117-8bb89e80-c0fa-11e9-949c-d6f32018edd1.png>
		       
<br>

<p align="center"><img width=70% src=https://user-images.githubusercontent.com/44467789/63209127-9f640500-c0fa-11e9-8240-8d254134e292.png>
		       
<br>

<p align="center"><img width=70% src=https://user-images.githubusercontent.com/44467789/63209135-bc003d00-c0fa-11e9-8826-abba2975fe16.png>

<br>

<p align="center"><img width=70% src=https://user-images.githubusercontent.com/44467789/63209140-cd494980-c0fa-11e9-9be8-ac7ba8862ab2.png
		       
<br>

<p align="center"><img width=70% src=https://user-images.githubusercontent.com/44467789/63209147-dfc38300-c0fa-11e9-8a11-1efc695cd2fd.png>

<br>

Now, as presented in Variables Summary Table we have also checked whether the variable has any significant impact on TARGET variable or not. However, we found that AGE, ACC_OP_DATE, FLG_HAS_NOMINEE, FLG_HAS_OLD_LOAN and random variables do not significantly represent TARGET variable. Hence, we remove the variables from the data set.  

```
## Remove Variables which are NOT Significant to TARGER Variable
> 
> loan = loan [, -c(2,10,35,36,37)]
> 
> dim(loan)

[1] 20000    32
```
Here, we have also removed ACC_OP_DATE, which is reflection of LEN_OF_RLTN_IN_MNTH. 

Now, as we see in Variables Summary Table, we applied BoxCox.Lambda test to normalize the skewed variables. 
```
## Normalize Variable based on skewness
> 
> library(moments)
> library(forecast)
```

In the BoxCox.Lambda test we analyzed that few variables required re-test for normalization. 

<br>

<p align="center"><img width=73% src=https://user-images.githubusercontent.com/44467789/63209166-2dd88680-c0fb-11e9-92fb-161b9b83584b.png>
	
After cleaning and normalizing original data set. New file has been saved as mydata.csv.
```
## Save file as mydata.csv for CART, Random Forest and Neural Networks ML Modeling.
> 
> setwd("C:/Users/server/Desktop/Machine R")

> write.csv(loan, 'mydata.csv')
```

Hence, based on new file mydata.csv we’ll build CART, Random Forest and Neural Networks techniques to build models to predict the response rate of potential bank customers who requires personal loan.

<br>

### CART Machine Learning Technique

To create CART model on mybank personal loan campaign data set, we are using mydata.csv file. 
In mydata.csv data set, first we’ll convert FLG_HAS_CC and FLG_HAS_ANY_CHGS to factor from integer structure. 

[R Project Link](https://github.com/RutvijBhutaiya/Personal-Loan-Campaign/blob/master/CART%20Technique.R)
```
## Convert into Factor class ##

mydata$TARGET = as.factor(mydata$TARGET)
mydata$FLG_HAS_CC = as.factor(mydata$FLG_HAS_CC)
mydata$FLG_HAS_ANY_CHGS = as.factor(mydata$FLG_HAS_ANY_CHGS)

> class(FLG_HAS_CC)
[1] "factor"

> class(FLG_HAS_ANY_CHGS)
[1] "factor"
```
Now, to create development (training) and testing data set we have split mydaya.csv data file. Where mydata.d represents development dataset with 70% and mydata.t represents testing dataset with 30%. Here both the datasets contains random observations from original dataset, mydata.csv. 

Where, mydata.d represents 14054 observation for development purpose and mydata.t represents 5946 observation for testing dataset. 
Where, 33rd variable is random variable which we created for split. However, random variable does not have any significant impact on model. 

#### Build CART Model 

CART represents Classification and Regression Tree model, and for this model we are using R studio inbuilt library called ‘rpart’.  
Before we begin, we have set control parameters for rpart() function.  

```
## Set Control Parameters 

r.ctrl = rpart.control(minsplit = 100, minbucket = 10, cp = 0, xval = 10)

## Build Classification Tree usinf rpart function

mydata.tree = rpart(formula = TARGET ~ ., data = mydata.d, method = "class", control = r.ctrl)
mydata.tree

fancyRpartPlot(mydata.tree)

```

Parameters from rpart.control() function playa important role in tuning the CART model. 

Higher the minsplit and minbucket would not allow tree to grow fullest. However, very low minbucket does not mean higher accuracy, because very low minbucket, for e.g. minbucket = 2 means we are taking only two observations and prediction the TARGET variable. Hence, accuracy would be higher but only two observations are not sufficient to predict whether customer would respond or not respond. 
Here, in rpart.control() function we are taking minbucket at 15, and minsplit at 80.  

Mydata.tree would not be visible tree to analyze, so we have pruned the tree based on CP parameter.

Now, based on CP table we’ll decide the CP value to prune the tree.
As CP table represents, 13th node represents minimum classification error (xerror) which is 0.96567. Hence, we suggest taking CP value as 0.0028 for pruning the CART tree. 

Pruned classification tree represents splits at each node based on GINI. 
As we can see in the Pruned Classification Tree, at parent node, NO_OF_L_TRXNS <5.5 represents the highest GINI gain and hence rpart() chooses particular variable. 
Also, at NO_OF_L_TRXNS <5.5 node class (0) is dominated with 87% and class (1) responded class is at 13%.

Now, based on mydata.tree.prun, we have predicted the class and probabilities of the class, here class represents 0 and 1, where 0 means Non-Responder and 1 mean Responder. 

```
## For Prediction class do Scoring 

mydata.d$predict.class <- predict(mydata.tree.prun, mydata.d, type = "class")

mydata.d$predict.score <- predict(mydata.tree.prun, mydata.d, type = "prob")
```
Based on the predict() function mydata.tree.prun model be able to show TARGET variable class(0) and class(1, here as table presents predicted class is 0 with 90% probability and at the same observation class(1) with 10% probability. 

Now, to check the CART model performance, first, we are measuring Rank Order method, where we check KS parameter and second we are using confusion matrix. 
To create ran order we have created deciles, and rank order table. 

<p align="center"><img width=83% src=https://user-images.githubusercontent.com/44467789/63266974-b9dedf80-c2ae-11e9-9bfb-4dedfd04e3f0.png>

Rank ordering technique plays significant role to check the performance of mydata.tree.prun model.
In rank ordering table, first we creates deciles, ranging between 1 to 10. Here, cnt_resp and cnt_non_resp represents responded and non-responded customers in particular deciles. In the table variables’ are starting with ‘cum’ means cumulative response for particular deciles. 

In the table, KS is only 0.19 which means model is slightly under fitted. However, cumulative response is 57% for first two deciles. 
Second method we have used to check the performance of the model is confusion matrix. 

In confusion matrix out of 14054 observations, False Positive (Type 1) and False Negative (Type 2) error are 1547 and 95 respectively, with 11.6 % classification error. 

```
## Confusion Martix Error Calculation

with(mydata.d, table(TARGET, predict.class))

dim(mydata.d)

Error = (1633+1577)/14011
Error
# [1] 0.1168

```
Now, have applied CART model to unseen data to mydaya.t data set to check how model performs on the unseen data set. 

<p align="center"><img width=47% src=https://user-images.githubusercontent.com/44467789/63267587-08d94480-c2b0-11e9-924c-1606d990227a.png>
	
To Overcome the under fitness issues of CART model we’ll perform Random Forest technique and check the model fitness.

<br>

### Random Forest Machine Learning Technique

To create CART model on mybank personal loan campaign data set, we are using mydata.csv file. 

Now, to create development (training) and testing data set we have split mydaya.csv data file. Where mydata.d represents development dataset with 70% and mydata.t represents testing dataset with 30%. Here both the datasets contains random observations from original dataset, mydata.csv. 

#### Build Random Forest Model

Random Forest technique is based on ‘Ensemble technique’, where you create multiple trees like forest and the prediction is based on Mode of classification tree, and voting principle will select the class based on Mode. 

Where in CART model we have seen over fitting, RF overcomes overfitting challenge due to n number of trees, where in CART there was only 1 classification tree. 

Random forest model user inbuilt library called randomForest in R studio. 
Parameters in randomforest() function are ntree and ntry; where ntree represents number of classification tree, in RN we are taking 501 such classification trees and based on each 501 trees class, RF prediction would be done based on Mode of each classification tree.

In the function, mtry, represents number of variables to be takes based on boot strap aggregation. And for our study we choose mtry as 15. Mtry is also known as m, which is subset of M (total variables).   

Individual tree strength depends on mtry. Higher the mtry higher the individual tree strength and vice-versa. 

[R Project Link](https://github.com/RutvijBhutaiya/Personal-Loan-Campaign/blob/master/Random%20Forest%20Technique.R)
```
## Create Random Forest Model

library(randomForest)

set.seed(123)

mydata.rf <- randomForest(as.factor(TARGET) ~ ., data = mydata.d, 
                      ntree=101, mtry = 10, nodesize = 50,
                      importance=TRUE)
```
OOB (Out f Bag) error represents the number f tree. As we can see from the mydata.rf$err.rate around 20 classification trees are enough to build model. 

Hence, 20 trees - ‘ntree’ parameter in randomforest() function  would be sufficient
Based on the following Error plot, 

<p align="center"><img width=70% src= https://user-images.githubusercontent.com/44467789/63511575-2cde9500-c4ff-11e9-986c-63da96d7e0ad.png>
	
Based on 20 trees, we have tuned random forest model parameters as shown following, and run the randomforest() function. 
Hence, mtryStart is 15, and for safer side we took ntreeTry as 15, however, best ntreeTry is around 8. 

Here stepFActor we took as 1.2, means in each iteration model will multiply mtreeTry with stepFactor to calculate OOB. Now, when there is improvement of 0.0001 model will switch to higher (m), again OOB be calculated and repeats till significant improvement. 
```
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
```

Error rate is improved slightly 12.29% and class.error for 1 has gone down from 0.989 to 0.976, hence model is improved and fit for 20 trees. 

Now, based on mydata.tree.prun, we have predicted the class and probabilities of the class, here class represents 0 and 1, where 0 means Non-Responder and 1 mean Responder.

Now, to check the Random Forest model performance, first, we are measuring Rank Order method, where we check KS parameter and second we are using confusion matrix. 
To create ran order we have created deciles, and rank order table. 

Based on rank order table in first two deciles response class covers around 70% with 0.52 KS, which is best fit to train dataset.
However, our aim is not to make model best fit to development dataset, but to testing dataset.

Second method we have used to check the performance of the model is confusion matrix. 
Classification error is 0.122, and hence on model accuracy is 87.8%, which we suggest should be more than 90%. 

As we can see from the comparison table that, performance % difference between training and resting is 15%. 

<p align="center"><img width=48% src=https://user-images.githubusercontent.com/44467789/63511852-ed647880-c4ff-11e9-84ba-1fd33e8ee1dc.png>
	
<br>

<br>
	
### Neural Network Machine Learning Technique

To create Random Forest model on mybank personal loan campaign data set, we are using mydata.csv file. 

Neural Network can’t perform on categorical variables. So, we are converting categorical variables to numerical variables. 

Hence, GENDER, OCCUPATION, AGE_BKT, ACC_TYPE, FLG_HAS_CC, FLG_HAS_ANY_CHGS categorical variable would be translated into Dummy variables. 

```
## Convert Categorical variables to Dummy variables

G.matrix <- model.matrix(~ GENDER - 1, data = mydata)
mydata <- data.frame(mydata, G.matrix)
```

Now, to create development (training) and testing data set we have split mydaya.csv data file. Where mydata.d represents development dataset with 70% and mydata.t represents testing dataset with 30%. Here both the datasets contains random observations from original dataset, mydata.csv.

#### Build Neural Network Model 

Artificial Neural Network (ANN) is inspired by brain, biological neural network. For ANN we uses inbuilt library from R Studio, called ‘neuralnet’. 

ANN is sensitive to weighted in variables, and to overcome overfittness in ANN model have scaled categorical variables, GENDER, OCCUPATION, AGE_BKT, ACC_TYPE, FLG_HAS_CC, FLG_HAS_ANY_CHGS. 

Here, we are temporary removing TARGET variable. 

```
## For Scaling We are creating new variable scale.temp [where we remove TARGER Variable] & Categorical variables]

scale.temp = mydata.d[, -c(1,2,4,5,8,17,23)]

View(scale.temp)

mydata.d.scale = scale(scale.temp)
View(mydata.d.scale)

dim(mydata.d.scale)
# [1] 14004    45

mydata.d.scaled = cbind(mydata.d[1], mydata.d.scale)
attach(mydata.d.scaled)
```


After scaling the dataset, we are using neuralnet() function  to build ANN, where we have chosen 5 neurons (hidden layers) to perform the task.

To build ANN model on personal loan campaign dataset, we have used Sum of Squared as ‘sse’ type for cost function, with threshold reach till 0.1. Means, model will perform iteration based on sum of squared cost function till error falls below 0.1. In the model, Linear.output is FALSE, means by default Sigmoid activation is applied in the [ANN model](https://github.com/RutvijBhutaiya/Personal-Loan-Campaign/blob/master/Neural%20Net%20Technique.R)

```
## PLot Neural Network

plot(mydata.nn)
```

As we can analyze the ANN plot there are 5 neuron, 46 input biases, and one output bias TARGET. From the plot, synaptic weights are not clearly visible, but for BALANCE we can see synaptic weight is -3.1447. 
Similarly, blue points with values are transmitting variables values from one neuron to other neuron e.g. 8.6699 and -0.29541


<p align="center"><img width=70% src=https://user-images.githubusercontent.com/44467789/63648670-bb962080-c750-11e9-8f91-d51e406f853b.png>
	
Now, based on the mydata.nn model we will perform performance measurements. 
Now, after building model we’ll check % distribution of probabilities across range from 0 to 100 using quantile () function. 
As we see, at each percentile, probability keeps changing and hence model is able to separate class (0) as non- responder and class (1) as responder.  

```
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

```
Also, we have performed, confusion matrix and Rank ordering based on deciles. 
Confusion matrix gives the classification error at 11.23%, less error gives higher accuracy model. 

Rank order is considered one of the best matrix when it comes about model performance measurement.  Base of deciles, we can see the top two deciles covert more than 55% response with 0.45 KS value. Best range for KS factor is 0.45 to 0.55; however our KS value is close to the range. 

[Link R Code](https://github.com/RutvijBhutaiya/Personal-Loan-Campaign/blob/master/Neural%20Net%20Technique.R)

Now, based on mydata.nn model we will check the model fitness on testing dataset. If model performs correct on testing dataset we can consider model is fit and can be used for prediction of class. 

In beginning with test dataset we need to do scaling for mydata.t dataset.  

```
# For TESTING DATA SET

## For TESTING DATA mydata.t Scaling We are creating new variable scale.temp1 [where we remove TARGER Variable] & Categorical variables]

scale.temp1 = mydata.t[, -c(1,2,4,5,8,17,23)]
```

Based on mydata.nn ANN model, we used compute() function to predict class(0) and class(1) on testing dataset. Because predict() function is not suitable for NN models. 

As we see the comparison table % difference between training and testing date set is more than 10%, hence ANN model is not fit for unseen data. 

<p align="center"><img width=42% src=https://user-images.githubusercontent.com/44467789/63648751-d321d900-c751-11e9-8e3d-bbe5620339dc.png>

Before final conclusion we have compared three techniques and results base on personal loan campaign dataset. 

### Machine Learnign Models Comparison

Note: Due to randomness in selection of development dataset mydata.d and testing dataset mydata.t, numbers of observations are different in all the three techniques. Hence we prefer not to use ensemble method to find best fit. But, we used scaling based on three criteria.
Model comparison based in three criteria, 1) Stability, 2) Training dataset performance and 3) Testing dataset performance. 

Stability is the most important criteria for model prediction and stability weightage is 50% in comparison table. After that model can give smooth performance of training dataset but priority is to work and give results on unseen dataset, testing dataset. So, we give 30% weightage to testing dataset performance and rest 20% to training dataset performance. 

Stability means % difference in training (development) and testing model results. Higher the differences lower the stability and vice-versa. 

<p align="center"><img width=45% src=https://user-images.githubusercontent.com/44467789/63648798-69ee9580-c752-11e9-8437-30882a2ec943.png>
	
As we see in the comparison table, Random Forest is winner. However, supervised learning technique depends on model to model. For personal loan dataset we saw that Random Forest technique is best fit to do prediction for responded and non-responded class customers. 

<br>

### Conclusion

Base on the supervised machine learning techniques – CART, Random Forest, and Neural Networks, we can conclude that out of three machine learning techniques, Random Forest is best fit for personal loan campaign dataset.

Random Forest predicted responder and non-responded class customers with around 88% accuracy. Based on stability, random forest falls behind CART model technique. Since, overall scoring indicated Random Forest is best fit for the dataset.

Hence, we recommend Mybank to perform Random Forest model on customer dataset to identify potential buyers of personal loan.

This data analysis model would help bank for better engagement with existing customers and would be able forecast loan revenue based on the same. This data analysis model will also help individual bank branch and sales man to target right customer for personal loan in future.

<br>

### Acknowledge

Great Lakes Institute - BACP Project 
