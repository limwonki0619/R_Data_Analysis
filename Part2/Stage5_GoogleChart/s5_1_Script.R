# 다양한 구글챠트 활용하기
install.packages('ggmap')

setwd('D:/Workspace/R_Data_Analysis/Part2/Stage5_GoogleChart')
# 예제 5-1. WorldBank 자료로 움직이는 버블챠트 생성하기
library(googleVis)
demo(WorldBank)       # 에러 발생

# 예제 5-2. 그래프가 살아있다 2 - 실습으로 확인하기
Fruits
Fruits1<- gvisMotionChart(Fruits, idvar="Fruit", timevar="Year")
plot(Fruits1)       # Google API Key 필요

# 예제 5-3 . 서울 지하철 1,2,3,4 호선 이용승객현황 출력하기
line <- read.csv("1-4호선승하차승객수.csv",header=T,sep=",")
line
t1 <- gvisMotionChart(line, idvar="노선번호", timevar="시간",
                      options=list(width=1000,height=500))
plot(t1)

# 예제 5-4. 서울 지하철 2호선 강남역 시간대별 이용 현황 수 표현하기
line_2 <- read.csv("2호선_강남역_시간대별_승하차현황_세로.csv",header=T,sep=",")
t1 <- gvisMotionChart(line_2, idvar="line_no", timevar="time",
                      options=list(width=1000,height=500))
plot(t1)

# 예제 5-5. 서울 지하철 5-8호선 이용승객 현황 표시하기
sub58 <- read.csv("서울지하철_5-8호선_이용현황_시간대별.csv",header=T)
sub58
sub58_2 <- gvisMotionChart(sub58,idvar="호선명",timevar="시간")
plot(sub58_2)

# 예제 5-6. Googlemap 좋아요
data(Andrew)
Andrew
storm1 <- gvisMap(Andrew, "LatLong" , "Tip",
                  options=list(showTip=TRUE, showLine=TRUE, enableScrollWheel=TRUE,
                               mapType='hybrid', useMapTypeControl=TRUE,
                               width=800,height=400))
plot(storm1)

# 예제 5-7 . Googlemap~서울시 구청 위치를 표시해 줘~
loc <- read.csv("서울시구청위치정보_new.csv",header=T)
loc
hoffice <- gvisMap(loc, "LATLON" , "name",
                   options=list(showTip=TRUE, showLine=TRUE, 
                                enableScrollWheel=TRUE,
                                mapType='normal', 
                                useMapTypeControl=TRUE,
                                width=1000,height=400))
plot(hoffice)

# 예제 5-8. Googlemap으로 제주도 여행지 위치 색다르게 보기
library(ggmap)        # Google API Key 필요
ft_placelst <- function(place) {
  temp <- geocode(place) # 이부분이 핵심!! 위도 경도를 임시변수에 담습니다
  place <- gsub("제주 ","",place)
  df_lst <- cbind(place,temp) # 여행지이름 위도 경도'로 이루어진 데이터프레임
  return(df_lst)
}

df_placelst <- ft_placelst(readLines("제주여행코스.txt"))
latlon <- paste(df_placelst$lat,":",df_placelst$lon)
latlon <- gsub(" ","",latlong)
latlon <- paste(df_placelst$lat,":",df_placelst$lon)
latlon <- gsub(" ","",latlong) 
df_placelst <- cbind(df_placelst, latlon)
df_placelst
placePath <- gvisMap(df_placelst, "latlong" ,"place" , 
                     options=list(showTip=TRUE, showLine=TRUE, 
                                  enableScrollWheel=TRUE, 
                                  mapType='hybrid', 
                                  useMapTypeControl=TRUE, 
                                  width=800,height=1000))
plot(placePath)

# 예제 5-9.  Google Gauge Chart 로 실적을 표시하기
CityPopularity
ex1 <-gvisGauge(CityPopularity, 
                options=list(min=0, max=800, 
                             greenFrom=500, greenTo=800, 
                             yellowFrom=300, yellowTo=500,
                             redFrom=0, redTo=300, width=400, height=300))
plot(ex1)

# 예제 5-10 . Google Line Chart 사용하기
fruits=data.frame(month=c("JAN","FEB","MAR"),
                  apple=c(30,10,20),
                  orange=c(20,40,30))
line <- gvisLineChart(fruits)
plot(line)

line2 <- gvisLineChart(fruits,"month",c("apple","orange"),
                       option=list(series="[{targetAxisIndex:0},{targetAxisIndex:1}]",
                                   vAxes="[{title:'apple'},{title:'orange'}]" ))
plot(line2)

line3 <- gvisLineChart(fruits,xvar="month",yvar=c("apple","orange"),
                       options=list(series="[{color:'blue',targetAxisIndex:0,linewidth:1,lineDashStyle:[1,10,1,10,1,10]},{color:'red',targetAxisIndex:1,linewidth:2,lineDashStyle:[4,1]}]",
                                    vAxes="[{title:'apple'},{title:'orange'}]" ))
plot(line3)

# 예제 5-11. Google Bar Chart 사용하기
gbar <- gvisBarChart(fruits)
plot(gbar)

# 예제 5-12. Google Pie Chart 사용하기
CityPopularity
pie1 <- gvisPieChart(CityPopularity,options=list(width=400, height=300)) 
plot(pie1)

# 도넛 차트 만들기
pie2 <- gvisPieChart(CityPopularity, options=list(
  slices="{4: {offset: '0.2'}, 0: {offset: '0.3'}}",
  title="City popularity",
  legend="none",
  pieSliceText="label",
  pieHole="0.5",width=600))
plot(pie2)

# 예제 5-13. Google Candle Stick Chart 사용하기
OpenClose
candle <- gvisCandlestickChart(OpenClose, 
                               options=list(legend='none',height=400,width=500))
plot(candle)

# 예제 5-14. Google Bubble Chart 사용하기
Fruits
a <- gvisBubbleChart(Fruits, idvar="Fruit", xvar="Sales", yvar="Expenses", 
                     colorvar="Year", sizevar="Profit", 
                     options=list(height=500,weight=800,
                                  hAxis='{minValue:75, maxValue:125}'))
plot(a)

# 예제 5-15. Google Column Chart
korean <- read.csv("학생별회차별성적__국어_new.csv", header=T)
korean
kor <- gvisColumnChart(korean,options=list(title="학생별 성적비교",
                                           height=400,weight=500))
header <- kor$html$header
header <- gsub("charset=utf-8", "charset=euc-kr", header)
kor$html$header <- header
plot(kor)

# 예제 5-16. Google Area Chart 사용하기
korean <- read.csv("학생별회차별성적__국어_new.csv", header=T)
area <- gvisAreaChart(korean,options=list(height=400, weight=500))
header <- area$html$header
header <- gsub("charset=utf-8", "charset=euc-kr", header)
area$html$header <- header
plot(area)

# 예제 5-17. Google Combo Chart 사용하기
korean <- read.csv("학생별회차별성적__국어_new.csv", header=T)
combo <- gvisComboChart(korean,options=list(seriesType="bars", 
                                            height=400,weight=500,
                                            series='{3: {type:"line"}}'))
header <- combo$html$header
header <- gsub("charset=utf-8", "charset=euc-kr", header)
combo$html$header <- header
plot(combo)

# 예제 5-18. 계층도 그리기 - gvisOrgChart 사용하기
name <- c('Angela Bassett','Jessica Lange','Winona Ryder','Michelle Pfeiffer',
          'Whoopi Goldberg','Emma Thompson','Julia Roberts','Sharon Stone','Meryl Streep',
          'Susan Sarandon','Nicole Kidman')

pemp <- c(NA,'Angela Bassett','Jessica Lange','Winona Ryder','Winona Ryder',
          'Angela Bassett','Emma Thompson', 'Julia Roberts','Angela Bassett',
          'Meryl Streep','Susan Sarandon')

pay <- c(100,200,300,400,500,600,700,800,900,1000,1100)

emp <- data.frame(NAME=name,PNAME=pemp, PAY=pay)

Org <- gvisOrgChart(emp,idvar="NAME",parentvar="PNAME",
                    options=list(width=600, height=250,size='middle', allowCollapse=TRUE))
plot(Org)

# 예제 5-19. 챠트에 주석 넣기- gvisAnnotationChart 사용
Stock
achart <- gvisAnnotationChart(Stock,datevar="Date",numvar="Value",idvar="Device",
                              titlevar="Title",annotationvar="Annotation",
                              options=list(width=1000,height=500,fill=10, displayExactValues=TRUE,
                                           colors="['red','blue']"))
plot(achart)

# 예제 5-20. 웹에서 다운로드 받은 자료를 그래프로 출력하기
install.packages("httr")
install.packages("XML")
library(XML)
library(googleVis)
library(httr)
cafile <- system.file("CurlSSL", "cacert.pem", package = "RCurl")
page <- GET(
  "https://en.wikipedia.org/", 
  path="wiki/World_population", 
  config(cainfo = cafile))
x <- content(page, as ='text')
str(x)
tab <- sub('.*(<table class="grid".*?>.*</table>).*', '\\1', x)
pop_table <- readHTMLTable(tab)
str(pop_table); length(pop_table)
pop_table
pop_table <- readHTMLTable(tab,which=1)  # 1번째 테이블입니다.
#==============================================================
str(pop_table[c(1:28),])
pop_table[c(1:28),]
pop2 <- pop_table[c(1:11),c(2:5)]
pop2
write.csv(pop2,'pop.csv')

pop3 <- read.csv('pop.csv', header=T)
pop3
pop4 <- gvisColumnChart(pop3,xvar="Countries",
                        options=list(title="국가별 인구수 (단위:백만명)",
                                     height=400,weight=600))
plot(pop4)