model.rf<-train(classe~., data= training, method="rf")
predict.rf<-predict(model.rf,testing)
cm.rf<-confusionMatrix(predict.rf,testing$classe)
