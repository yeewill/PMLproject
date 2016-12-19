## this file will create a predicitionTree
model.tree<-rpart(classe~., data=training)
fancyRpartPlot(model.tree)
predict.tree<-predict(model.tree,testing,type="class")
cm.tree<-confusionMatrix(predict.tree, testing$classe)
cm.tree

model.tree2<-train(classe~., data=training, method="rpart")
predict.tree2<-predict(model.tree2,testing)
cm.tree2<-confusionMatrix(predict.tree2,testing$classe)
cm.tree2