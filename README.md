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

<p align="center"><img width=68% src=https://user-images.githubusercontent.com/44467789/63209117-8bb89e80-c0fa-11e9-949c-d6f32018edd1.png>
		       
<br>

<p align="center"><img width=68% src=https://user-images.githubusercontent.com/44467789/63209127-9f640500-c0fa-11e9-8240-8d254134e292.png>
		       
<br>

<p align="center"><img width=68% src=https://user-images.githubusercontent.com/44467789/63209135-bc003d00-c0fa-11e9-8826-abba2975fe16.png>

<br>

<p align="center"><img width=68% src=https://user-images.githubusercontent.com/44467789/63209140-cd494980-c0fa-11e9-9be8-ac7ba8862ab2.png
		       
<br>

<p align="center"><img width=68% src=https://user-images.githubusercontent.com/44467789/63209147-dfc38300-c0fa-11e9-8a11-1efc695cd2fd.png>

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

<p align="center"><img width=68% src=https://user-images.githubusercontent.com/44467789/63209166-2dd88680-c0fb-11e9-92fb-161b9b83584b.png>
	
After cleaning and normalizing original data set. New file has been saved as mydata.csv.
```
## Save file as mydata.csv for CART, Random Forest and Neural Networks ML Modeling.
> 
> setwd("C:/Users/server/Desktop/Machine R")

> write.csv(loan, 'mydata.csv')
```

Hence, based on new file mydata.csv we’ll build CART, Random Forest and Neural Networks techniques to build models to predict the response rate of potential bank customers who requires personal loan.

<br>

### CART  Machine Learning Technique

<br>

### Acknowledge

Great Lakes Institute - BACP Project 
