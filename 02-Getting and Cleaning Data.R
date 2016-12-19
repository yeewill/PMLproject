##In this file we will download the csv files, read them, and clean them
##Written by William Yee on 12/18/2016

training.url<- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
testing.url<- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"

download.file(url = training.url, destfile = "pml-training.csv")
download.file(url = testing.url, destfile = "pml-testing.csv")

##let's not confuse the standard verbiage, the testing set provided by coursera
##is the quiz answers 
##the training set is the raw data that i will break into testing and training sets therefore
## it will be called all.data

all.data<-read_csv(file = "pml-training.csv")
quiz<-read_csv(file = "pml-testing.csv")

## look at how many Na's in the testing and training set remove 75% na
per.na<- vector(mode="numeric", length= ncol(all.data))
keep.me<- vector(mode="numeric", length= 0)
count.na<- vector(mode="numeric", length= ncol(all.data))
for(i in seq_along(all.data)){
        per.na[i]<-mean(is.na(all.data[,i]))
        count.na[i]<-sum(is.na(all.data[,i]))
        if(per.na[i]<=.60){keep.me<-c(keep.me, i)}

}

table(per.na)

## do the same for the quiz set
qper.na<- vector(mode="numeric", length= ncol(quiz))
qkeep.me<- vector(mode="numeric", length= 0)
qcount.na<- vector(mode="numeric", length= ncol(quiz))
for(i in seq_along(quiz)){
        qper.na[i]<-mean(is.na(quiz[,i]))
        qcount.na[i]<-sum(is.na(quiz[,i]))
        if(qper.na[i]<=.60){qkeep.me<-c(qkeep.me, i)}
        
}
table(qper.na)

## let's compare the keep me sets
## easiest test are they identical? if not well need test if each is in the other

table(keep.me %in% qkeep.me)

##looks like they are equal



all.data<-select(all.data,c(keep.me))
all.data<-select(all.data, -1)
quiz<-select(quiz,c(keep.me))
quiz<-select(quiz, -1)

##looks like 3 observations have NA values in them, 
##this will keep the model from working 
##let's remove them
sum(is.na(all.data))
##3
all.data<-filter(all.data,complete.cases(all.data))

set.seed(1652)
inTrain<- createDataPartition(y=all.data$classe, p =0.75, list= F)
training<- all.data[inTrain,]
testing<- all.data[-inTrain,]


