model.gbm<-train(classe~., data= training, method="gbm")
predict.gbm<-predict(model.gbm,testing)
cm.gbm<-confusionMatrix(predict.gbm,testing$classe)