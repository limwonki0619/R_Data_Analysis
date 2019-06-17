setwd("D:/limworkspace/R_Data_Analysis/Part2/Stage6_RealAnalysis/Ex04_Welfare")
getwd()

# Stage6 - 1 실전 데이터 분석 프로젝트 

## 한국인의 삶을 파악하라

install.packages("foreign")
library(foreign) # SPSS 파일 로드
library(dplyr)   # 전처리
library(ggplot2) # 시각화
library(readxl)  # 엑셀파일 불러오기

### 1. 데이터 준비하기 -----------------------------------------------------------------------------------
raw_welfare <- read.spss(file="data/Koweps_hpc10_2015_beta1.sav", to.data.frame = T)

# 복사본 만들기
welfare <- raw_welfare

head(welfare)
tail(welfare)
View(welfare) # SPSS 파일의 경우 레이블 설명까지 가져옴
dim(welfare)  # row, col
str(welfare)
summary(welfare)

# *** 변수명 바꾸기 dplyr::rename(dataset, new_colname, old_colname) -------------------------------------

welfare <- rename(welfare,                 # dplyr::rename(dataset, new_colname, old_colname)
                  sex = h10_g3,            # 성별 
                  birth = h10_g4,          # 태어난 연도
                  marriage = h10_g10,      # 혼인상태
                  religion = h10_g11,      # 종교
                  income = p1002_8aq1,     # 월급
                  code_job = h10_eco9,     # 직종코드
                  code_region = h10_reg7)  # 지역코드

welfare <- select(welfare, sex, birth, marriage, religion, income, code_job, code_region)



# 1. 성별에 따른 월급차이가 있을까? ----------------------------------------------------------------------

# 1.1 성별 변수 검토 및 전처리
class(welfare$sex); table(welfare$sex)                        # 변수 및 이상치 확인 
welfare$sex <- ifelse(welfare$sex == 9, NA, welfare$sex)      # 이상치 처리
table(is.na(welfare$sex))                                     # NA 개수 파악 TRUE = 이상치 
welfare$sex <- ifelse(welfare$sex == 1, "male","female")      # 성별 항목에 이름 부여 
qplot(welfare$sex)                                            # 그래프로 확인



# 1.2 월급 변수 검토 및 전처리 
class(welfare$income); summary(welfare$income)                              # 변수 및 이상치 확인
qplot(welfare$income) + xlim(0,1000)                                        # 그래프로 확인 
welfare$income <- ifelse(welfare$income %in% c(0,9999), NA, welfare$income) # 결측치 처리
table(is.na(welfare$income))                                                # 결측치 확인


# 1.3. 성별에 따른 월급 평균표 만들기 및 그래프 그리기 
sex_income <- welfare %>% 
  filter(!is.na(income)) %>%       # NA가 아닌것만 가져오기
  group_by(sex) %>%                # 성별로 그룹화
  summarise(mean_income = mean(income)); sex_income

ggplot(sex_income,aes(x=reorder(sex, -mean_income), y=mean_income, fill=sex)) + # reorder 함수로 순서 조정 
  geom_col()





# 2. 나이에 따른 평균월급 분석 - 몇 살때 월급을 가장 많이 받을까? -----------------------------------------
class(welfare$birth); summary(welfare$birth)                      # 2.1 나이변수 검토 및 확인
qplot(welfare$birth)                                              # 그래프 그려보기

summary(welfare$birth)                                            # 이상치 확인
table(is.na(welfare$birth))                                       # 결측치 사전 확인

welfare$birth <- ifelse(welfare$birth == 9999, NA, welfare$birth) # 이상치 처리
table(is.na(welfare$birth))                                       # 결측치 확인


welfare$age <- 2015 - welfare$birth + 1                           # 파생변수 age 만들기
summary(welfare$age)
qplot(welfare$age)                                                # age 변수 분포 확인
table(welfare$age)                                                # age 변수 테이블 확인

# 나이대별 평균 월급표 만들기 및 그래프 그리기 
age_income <- welfare %>%
  filter(!is.na(income)) %>%            # 소득이 없거나 결측치인 데이터 필터링 -> 20세 미만이 사라짐 
  group_by(age) %>%                     # age 변수로 그룹화
  summarise(mean_income = mean(income))

summary(age_income)
ggplot(age_income, aes(x = age, y=mean_income)) + geom_area()     # 나이에따른 평균월급 그래프 




# 3. 연령대에 따른 평균월급 분석 --------------------------------------------------------------------------

# 3.1 파생변수 연령대 만들기 
# 3 groups (young, middle, old)
welfare <- welfare %>%                                       # age group 1 생성 
  mutate(ageg = ifelse(age < 40, "young", 
         ifelse(age <= 59, "middle", "old")))

# 6 groups(10대 ~ 60대 이상)
welfare <- welfare %>%                                       # age group 2 생성 
  mutate(ageg2 = ifelse(age < 20, "10대", 
                 ifelse(age < 30, "20대",
                 ifelse(age < 40, "30대", 
                 ifelse(age < 50, "40대",
                 ifelse(age < 60, "50대", "60대 이상")))))
         )


# 3.2 연령대별 평균 월급표 만들기 
# 3 groups
ageg_income <- welfare %>%
  filter(!is.na(welfare$income)) %>%
  group_by(ageg) %>%
  summarise(mean_income = mean(income))

# *** X축 순서 지정 후 그래프 그리기 ----------------------------------------------------------------------

# ggplot2 그래프의 X축 순서 지정 방법 1
ageg_income$ageg
ageg_income$ageg <- factor(ageg_income$ageg, levels=c("young","middle","old")) # factor를 통한 순서 설정 
levels(ageg_income$ageg)

ggplot(ageg_income, aes(x=ageg, y=mean_income, fill=ageg)) + 
  geom_col()

# ggplot2 그래프의 X축 순서 지정 방법 2
ggplot(ageg_income, aes(x=ageg, y=mean_income, fill=ageg)) + 
  geom_col() +
  scale_x_discrete(limits = c("young", "middle", "old"))


# 6 groups
welfare %>%
  filter(!is.na(welfare$income)) %>%
  group_by(ageg2) %>%
  summarise(mean_income = mean(income)) %>% 
    ggplot(aes(x=ageg2, y=mean_income, fill=ageg2)) + 
      geom_col()




# 4. 연령대별 성별에 따른 평균 월급차이 분석 -------------------------------------------------------------

# 4.1 연령대 및 성별 평균 월급표 만들기 및 그래프 그리기 
# 3 groups
sex_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(ageg, sex) %>%   # 그룹화할 변수가 2개 (ageg, sex)
  summarise(mean_income = mean(income))
sex_income

# Graph
ggplot(sex_income, aes(x=ageg, y= mean_income, fill=sex)) +
  geom_col(position = "dodge") +
  scale_x_discrete(limits = c("young","middle","old")) # X축 순서 설정 

# 6 groups
sex_income2 <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(ageg2, sex) %>%  # 그룹화할 변수가 2개 (ageg2, sex)
  summarise(mean_income = mean(income))
sex_income2

# Graph
ggplot(sex_income2, aes(x=ageg2, y= mean_income, fill=sex)) +
  geom_col(position = "dodge")



# 5. 성별 나이대별 평균 월급 line 그래프  
sex_age <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age,sex) %>%  # 그룹화할 변수가 2개 (sex, age)
  summarise(mean_income = mean(income))

ggplot(sex_age, aes(x=age, y=mean_income, color=sex)) +
  geom_line()




# 6. 직업별 월급 차이 - (left_join, excel 불러오기) ------------------------------------------------------
# 어떤 직업이 월급을 가장 많이 받을까 

# 6.1 변수 검토 
class(welfare$code_job)
table(welfare$code_job)

# 6.2 직업분류코드 사전작업 및 확인 
list_job <- read_excel("data/Koweps_Codebook.xlsx", col_names = T, sheet = 2) # 엑셀가져오기(readxl 패키지)
head(list(list_job))
dim(list_job)  # 작업분류코드 확인하기 

# 6.3 직업분류코드 Merge
welfare <-left_join(welfare, list_job, id="code_job") # welfare에 list_job을 code_job변수를 기준으로 합침 


# 6.4 직업별 평균월급표 만들기 
job_income <- welfare %>%
  filter(!is.na(job) & !is.na(income)) %>%
  group_by(job) %>%
  summarise(mean_income = mean(income))
job_income

# 평균월급 상위 10개 직업 추출 
top10 <- welfare %>%
  filter(!is.na(job) & !is.na(income)) %>%
  group_by(job) %>%
  summarise(mean_income = mean(income)) %>%
  arrange(desc(mean_income)) %>% 
  head(10)
top10

# 평균월급 하위 10개 직업 추출 
bot10 <- welfare %>%
  filter(!is.na(job) & !is.na(income)) %>%
  group_by(job) %>%
  summarise(mean_income = mean(income)) %>%
  arrange(desc(mean_income)) %>% 
  tail(10)
bot10

# 6.5 직업별 평균월급 그래프 그리기 
# 상위 10개 직업
ggplot(top10, aes(x=reorder(job, -mean_income), 
                  y=mean_income, fill=job)) +  
  geom_col() +
  coord_flip()

# *** 막대차트 x축 설정 - reorder -----------------------------------------------------------------------
reorder(top10$job, top10$mean_income)  # 오름차순 정렬
reorder(top10$job, -top10$mean_income) # 내림차순 정렬 

# 하위 10개 직업 
ggplot(bot10, aes(x=reorder(job, -mean_income), y=mean_income, fill=job)) +
  geom_col() +
  coord_flip()




# 7. 성별 직업 빈도 분석하기 ----------------------------------------------------------------------------
# 성별로 어떤 직업이 가장 많을까?
# 성별 직업 빈도표 만들기

# 7.1 남성 직업 빈도 상위 10개 추출 
job_male <- welfare %>%
  filter(!is.na(job) & sex =="male") %>%
  group_by(job) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  head(10)

# 7.2 여성 직업 빈도 상위 10개 추출 
job_female <- welfare %>%
  filter(!is.na(job) & sex =="female") %>%
  group_by(job) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  head(10)

# 남성 직업 순위 그리기
ggplot(job_male, aes(x=reorder(job, n), y=n, fill=job)) +
  geom_col() +
  coord_flip()

# 여성 직업 순위 그리기
ggplot(job_female, aes(x=reorder(job, n), y=n, fill=job)) +
  geom_col() +
  coord_flip()



# 8. 종교 유무에 따른 이혼율 분석하기  -------------------------------------------------------------------
# 종교가 있는 사람들이 이혼을 덜 할까?

# 8.1 종교 유무 변수 검토 및 전처리 하기
class(welfare$religion); table(welfare$religion)                    # 변수 확인 
welfare$religion <- ifelse(welfare$religion == 1, "yes", "no")      # 종교 유무 이름 부여

table(welfare$religion)
qplot(welfare$religion)

# 8.2 혼인 상태 변수 검토 및 전처리 하기
class(welfare$marriage); table(class(welfare$marriage))             # 변수 확인
welfare$group_marriage <- ifelse(welfare$marriage == 1, "marriage", # 이혼(divorce) 여부 변수 만들기
                                        ifelse(welfare$marriage == 3, "divorce", NA))

table(welfare$group_marriage)                                       # 이혼 및 결혼 여부 확인 
table(is.na(welfare$group_marriage))                                # 결측치 확인
qplot(welfare$group_marriage)                                       # 혼인 상태 빈도 그래프 확인

religion_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>% 
  group_by(religion, group_marriage) %>%                            # 종교유무별, 혼인상태별 그룹화
  summarise(n = n()) %>%                                            # 빈도 확인 
  mutate(tot_group = sum(n)) %>%                                    # 종교유무별, 혼인상태별 전체 개수
  mutate(pct = round(n/tot_group*100,1))                            # 각 변수에 대한 비율 
religion_marriage 

# 8.3 종교유무멸 이혼율 표 만들기
divorce <- religion_marriage %>%
  filter(group_marriage == "divorce") %>%
  select(religion, pct)
divorce

# 종교유무별 이혼율 그래프 그리기 
ggplot(divorce, aes(x=religion, y= pct, fill=religion)) +
  geom_col() # 통계적 확인이 필요



# 8.4 연령대별 이혼유무 표 만들기
ageg_marriage <- welfare %>% 
  filter(!is.na(group_marriage)) %>% 
  group_by(ageg, group_marriage) %>% 
  summarise(n = n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100, 1))
ageg_marriage


# 8.4.1 초년 제외, 연령대별 이혼율만 추출 
ageg_divorce <- ageg_marriage %>% 
  filter(ageg != "young" & group_marriage == "divorce") %>% 
  select(ageg, pct)
ageg_divorce

# 8.4.2 초년 제외, 연령대별 이혼율만 추출한 그래프 그리기
ggplot(ageg_divorce, aes(x= ageg, y= pct, fill=ageg)) +
  geom_col()


# 8.5 연령대 및 종교유무에 따른 이혼율 표 만들기
ageg_religion_marriage <- welfare %>%
  filter(!is.na(group_marriage) & ageg != "young") %>%  # 결혼유무 결측치와 연령대 중 young를 제외한 데이터만 추출 
  group_by(ageg, religion, group_marriage) %>%          # 그룹변수 3개(ageg, religion, group_marriage)
  summarise(n = n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group*100,1))
ageg_religion_marriage

# 8.5.1 연령대, 종교유무별 이혼율만 추출 
df_divorce <- ageg_religion_marriage %>%
  filter(group_marriage == "divorce") %>%
  select(ageg, religion, pct)

# 8.5.2 연령대 및 종교유무에 따른 이혼율 그래프 그리기
ggplot(df_divorce, aes(x=ageg, y=pct, fill=religion)) +
  geom_col(position = "dodge")




# 9. 지역별 연령대 비율 분석하기 ----------------------------------------------------------------------------

# 9.1 지역코드 목록 만들기
list_region <- data.frame(code_region = c(1:7),
                          region = c("서울",
                                     "수도권(인천/경기",
                                     "부산/경남/울산",
                                     "대구/경북",
                                     "대전/충남",
                                     "강원/충북",
                                     "광주/전남/전북/제주"))

list_region

# 9.2 welfare에 지역명 변수 합치기 (Left_join)
welfare <- left_join(welfare, list_region, id="code=region")
welfare %>% 
  select(code_region, region) %>% 
  head 

# 9.3 지역별 연령대 비율 표 만들기
region_ageg <- welfare %>% 
  group_by(region, ageg) %>%
  summarise(n = n()) %>% 
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100,2))

# 9.3.1 지역별 연령대 비율 그래프 그리기 
ggplot(region_ageg, aes(x=region, y=pct, fill=ageg)) +
  geom_col()  
#  scale_x_discrete(limits=c("young","middle","old"))

# 9.4 노년층 비율 내림차순 정렬

# 9.4.1 노년층 그룹만 추출 후 내림차순 정렬하기
list_order_old <- region_ageg %>% 
  filter(ageg == "old") %>% 
  arrange(pct)

# 9.5 지역명 순서 변수 만들기
order <- list_order_old$region
order

# 9.6 지역별 연령대 비율 (노년층 내림차순 정렬) 그래프 그리기 
ggplot(region_ageg, aes(region, y=pct, fill=ageg)) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limits=order)



# 9.7 연령대 순으로 막대 순서 정하기 
class(region_ageg$ageg) # char은 사전 정렬이 되어 있음(가나다.. abc.. 123 순)
region_ageg$ageg <- factor(region_ageg$ageg, levels = c("old","middle","young")) # factor형으로 levels에 따라 순서 정렬 
levels(region_ageg$ageg)

# 9.7.1 연령대 순으로 정렬된 그래프 그리기 
ggplot(region_ageg, aes(region, y=pct, fill=ageg)) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limits=order)

