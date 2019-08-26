setwd("D:/limworkspace/R_Data_Analysis/ML-lecture/02. 데이터 세트 분할하기")

# 데이터 세트 분할하기


# 1. 데이터가 무작위로 섞여있는 경우

iris_train <- iris[0:105,]
iris_test <- iris[106:150,]

# iris 데이터와 같이 데이터가 정렬되어 있는 경우 
# 학습용 데이터와 평가용 데이터가 일관되지 못하고 편중되게 된다.
# 따라서 아래와 같이 무작위 샘플 추출을 통해 데이터를 분할하게 된다.

# 2. 랜덤샘플링 

idx <- sample(1:nrow(iris), size=nrow(iris)*0.7, replace=F)

