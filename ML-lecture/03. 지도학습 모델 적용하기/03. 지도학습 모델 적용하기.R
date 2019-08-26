setwd("D:/limworkspace/R_Data_Analysis/ML-lecture/03. 지도학습 모델 적용하기")

# 3. 지도학습 모델 적용하기

# 3.1 분류 목적의 머신러닝 기법 적용 

# (1) K-Nearest Neighbor(KNN) 분석 ------------------------------------------------------------------------

like <- read.csv('data/like.csv', stringsAsFactors = F, header = T) # 데이터 로드, 문자형을 factor로 받지 않음
str(like)

colnames(like) <- c('talk', 'book', 'travel', 'school', 'tall', 'skin','muscle', 'label') # 데이 컬럼명 변경 


test <- data.frame(talk = 70, book = 50, travel = 30, school=70, 
                   tall = 70, skin = 40, muscle = 50) # 테스트 데이터 

library(class)

train <- like[, -8] # 종속변수를 뺀 데이터셋
group <- like[, 8]

knn(train, test, group, k=3, prob=T) # k : 주변 데이터를 몇개를 보고 판단할 건가 
knn(train, test, group, k=4, prob=T)

# (2) 나이브 베이즈(Naive Bayes) 분석 ------------------------------------------------------------------------

# 데이터셋 설정 

library(caret)
idx <- createDataPartition(iris$Species, p=0.7, list=F) # Y의 속성비율을 같게하는 랜덤 샘플링 방법 

iris_train <- iris[idx,]  # 학습용 데이터 
iris_test <- iris[-idx,]  # 검증용 데이터 

table(iris_train$Species) # 데이터 확인 
table(iris_test$Species)


install.packages('e1071') # 나이브 베이즈 패키지 
library(e1071) 

# 나이브 베이즈 모델 적용 

train_rt <- naiveBayes(iris_train, iris_train$Species, laplace = 1) # naiveBayes(X, Y, laplace=1 [스무스한 형태로 나타냄])
naive_pdt <- predict(train_rt, iris_test, type = 'class')  # 학습 결과를 출력, type='class' 범주형 데이터 

table(naive_pdt, iris_test$Species) # 학습결과 테이블 
confusionMatrix(naive_pdt, iris_test$Species)


# (3) 로지스틱 회귀분석 ------------------------------------------------------------------------

install.packages('nnet') # 로지스틱 회귀분석 패키지 
library(nnet)

# 다중 로지스틱 회귀분석 

mult_rt <- multinom(Species~., iris_train) # 종속변수가 3가지 이상일 때 다중로지스틱 회귀분석 적용 
multi_pdt <- predict(mult_rt, iris_test)   

table(iris_test$Species, multi_pdt)
confusionMatrix(multi_pdt, iris_test$Species)


# (4) 의사결정나무 분석 ------------------------------------------------------------------------

install.packages('rpart') # 의사결정나무 패키지
library(rpart)

# 의사결정나무 학습 
rpart_rt <- rpart(Species~., iris_train) # 종속변수 ~ 모든 독립변수, 학습데이터 
rpart_rt

rpart_pdt <- predict(rpart_rt, iris_test, type='class')
rpart_pdt

table(iris_test$Species, rpart_pdt)
confusionMatrix(iris_test$Species, rpart_pdt)


# (5) 인공신경망 분석 ------------------------------------------------------------------------

install.packages('nnet') # 인공신경망 패키지 
library(nnet)

# 입력변수 표준화 및 구성하기 

iris_train_scale <- as.data.frame(sapply(iris_train[,-5], scale)) # 데이터 스케일링 (표준화), 종속변수 제거
iris_test_scale <- as.data.frame(sapply(iris_test[,-5], scale))   # 데이터 스케일링 (표준화), 종속변수 제거 
head(iris_train_scale)
head(iris_test_scale)

iris_train_scale$Species <- iris_train$Species # 다시 종속변수 포함 
iris_test_scale$Species  <-  iris_test$Species # 다시 종속변수 포함 

# 데이터 학습 

nnet_rlt <- nnet(Species~., iris_train_scale, size=3) # size : 은닉층의 노드수를 결정하는 인자 
nnet_pdt <- predict(nnet_rlt, iris_test_scale, type='class') # type는 종속변수의 타입 

table(nnet_pdt, iris_test$Species) # 결과 확인 테이블 
confusionMatrix(as.factor(nnet_pdt), iris_test$Species)  


# (6) 서포트 벡터 머신 분석 ------------------------------------------------------------------------

install.packages('kernlab')
library(kernlab)

# 모델 설정 
svm_rlt <- ksvm(Species~., data=iris_train, kernel='rbfdot') # 훈련 데이터를 통한 모형 적합, 커널 : 가우시안 RBF 커널 

# 결과 예측 
svm_pdt <- predict(model, iris_test, type='response') # 테스트 데이터 평가, type : 예측된 범주 분류 값 

table(svm_pdt, iris_test$Species)
confusionMatrix(svm_pdt, iris_test$Species) # 분류 결과 


# (7) 랜덤 포레스트 분석 ------------------------------------------------------------------------

install.packages('randomForest')
library(randomForest)

rf_rlt <- randomForest(Species~., iris_train, ntree=500, importance=TRUE)  # ntree : 사용할 의사결정트리의 개수, 디폴트가 500
rf_pdt <- predict(rf_rlt, iris_test, type='response')

table(rf_pdt, iris_test$Species)
confusionMatrix(rf_pdt, iris_test$Species)

# (7-1) 랜덤포레스트 모델을 이용한 보스턴 집값 예측하기 -----------------------------------------

library(MASS)
head(Boston)

# 데이터 분할 

idx <- sample(1:nrow(Boston), size=nrow(Boston)*0.7, replace = F)
Boston_train <- Boston[idx, ]
Boston_test <- Boston[-idx, ]

str(Boston_train); str(Boston_test)

# 랜덤 포레스트 모델 적용 

library(randomForest)
set.seed(1) # 랜덤 시드값 설정 

rf_fit <- randomForest(medv~., data=Boston_train, mtry=6, importance=T) # mtry : 사용할 설명변수의 개수 (수치예측의 경우 일반적으로 P/3을 사용)
plot(rf_fit) # 트리개수 변화에 따른 error 감소 추이 

importance(rf_fit) # 각 변수의 중요도를 확인 
varImpPlot(rf_fit) # 변수 중요도를 시각적으로 확인 

# 확인 결과 주택가격에 영향을 미치는 설명변수로서 m(주택당 평균 방의 개수)와, lstat(사회경제적 지위)의 2개 변수가
# 다른 설명변수들에 비하여 압도적으로 높은 중요도 측도를 보인다. 

rf_yhat <- predict(rf_fit, newdata=Boston_test) # 평가 데이터 이용, 예측 결과 생성
MSE <- mean((rf_yhat - Boston_test$medv)^2)     # 평균제곱오차 = (예측값 - 실제값)^2의 평균 = MSE 
RMSE <- sqrt(MSE)                               # 평균제곱근오차 = sqrt(MSE) = RMSE

# 분석결과 랜덤 포레스트 모델의 예측값은 실제 주택 가격 값의 약 $2.800 이내에 있다는 것을 의미한다. 