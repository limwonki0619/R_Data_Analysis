# 예제 5-21. 타임라인 그래프 그리기
library(googleVis)
dat <- data.frame(Term=c("1","2","3"),
                  President=c("Whasington", "Adams", "Jefferson"),
                  start=as.Date(x=c("1789-03-29", "1797-02-03", "1801-02-03")),
                  end=as.Date(x=c("1797-02-03", "1801-02-03", "1809-02-03")))

tl <- gvisTimeline(data=dat[,-1], rowlabel="President",
                   start="start", end="end")
tl <- gvisTimeline(data=dat, barlabel="President",
                   start="start", end="end")
plot(tl)

dat <- data.frame(Room=c("Class 1","Class 2","Class 3"),
                  Language=c("English Team", "German Team", "French Team"),
                  start=as.POSIXct(c("2015-09-14 14:00", "2015-09-14 15:00",
                                     "2015-09-14 14:30")),
                  end=as.POSIXct(c("2015-09-14 15:00", "2015-09-14 16:00",
                                   "2015-09-14 15:30")))

tl <- gvisTimeline(data=dat, rowlabel="Rev_Team",
                   start="start", end="end")
plot(tl)

# 예제 5-22. gvisScatterChart 사용하기
txt1 <- gvisScatterChart(women)
plot(txt1)

# 여러 옵션들 사용하기
txt2 <- gvisScatterChart(women, options=list(legend="none",
                                             lineWidth="3", pointSize="3",
                                             title="Women", vAxis="{title:'weight (lbs)'}",
                                             crosshair="{ trigger: 'both' }",
                                             hAxis="{title:'height (in)'}", width=800, height=600))
plot(txt2)

# 포인터 모양 변경하기 
mtx <- matrix(nrow=6,ncol=6)
mtx[col(mtx)==row(mtx)] <- 1:6
dat <- data.frame(X=1:6, mtx)
SC <- gvisScatterChart(dat,
                       options=list(title="Customizing points",
                                    legend="right",
                                    pointSize=30,
                                    series="{
                                      0: { pointShape: 'circle' },
                                      1: { pointShape: 'triangle' },
                                      2: { pointShape: 'square' },
                                      3: { pointShape: 'diamond' },
                                      4: { pointShape: 'star' },
                                      5: { pointShape: 'polygon' }
                                      }",width=800, height=400))
plot(SC)

# 예제 5-23. Treemap 사용하기 – gvisTreemap( )
tm <- gvisTreeMap(Regions, idvar="Region", parentvar="Parent",
                  sizevar="Val", colorvar="Fac")
plot(tm)

# 색상을 다르게 설정하기 
tm2 <- gvisTreeMap(Regions, "Region", "Parent", "Val", "Fac",
                   options=list(width=600, height=500,
                                fontSize=13,
                                minColor='#EDF8FB',
                                midColor='#66C2A4',
                                maxColor='#006D2C',
                                headerHeight=20,
                                fontColor='black',
                                showScale=TRUE))
plot(tm2)

# 미국 전체 주를 Treemap 으로 표시하기 
require(datasets)
states <- data.frame(state.name, state.area)
total=data.frame(state.area=sum(states$state.area), state.name="USA")
my.states <- rbind(total, states)
my.states$parent="USA"
my.states$parent[my.states$state.name=="USA"] <- NA
my.states$state.area.log=log(my.states$state.area)

statesTree <- gvisTreeMap(my.states, "state.name", "parent",
                          "state.area", "state.area.log")
plot(statesTree)

# 예제 5-24. 여러 개의 Google Chart 합치기 – gvisMerge( ) 
Pie1 <- gvisPieChart(CityPopularity)
Pie2 <- gvisPieChart(CityPopularity, options=list(
  slices="{4: {offset: '0.2'}, 0: {offset: '0.3'}}",
  title="City popularity",
  legend="none",
  pieSliceText="label",
  pieHole="0.5",width=600))
plot(gvisMerge(Pie2, Pie1, tableOptions = "cellspacing=\"20\" bgcolor=\"#AABBCC\"",
               horizontal=TRUE))

Geo <- gvisGeoChart(Exports, "Country", "Profit",
                    options=list(width=250, height=100)) 
Tbl <- gvisTable(Exports,
                 options=list(width=250, height=300))
GT <- gvisMerge(Geo,Tbl, horizontal=FALSE)
plot(GT)

M <- gvisMotionChart(Fruits, "Fruit", "Year",
                     options=list(width=400, height=410))    # API Key 필요
GTM <- gvisMerge(GT, M, horizontal=TRUE,
                 tableOptions="cellspacing=10")
plot(GTM)

line <- gvisLineChart(OpenClose, "Weekday", c("Open", "Close"),
                      options=list(legend="none", width=300, height=150))
column <- gvisColumnChart(OpenClose, "Weekday", c("Open", "Close"),
                          options=list(legend="none", width=300, height=150))
area <- gvisAreaChart(OpenClose, "Weekday", c("Open", "Close"),
                      options=list(legend="none", width=300, height=150))
bar <- gvisBarChart(OpenClose, "Weekday", c("Open", "Close"),
                    options=list(legend="none", width=300, height=150))
lcab <- gvisMerge(gvisMerge(line, column), gvisMerge(area, bar),
                  horizontal=TRUE, tableOptions="bgcolor=\"#AABBCC\"")
plot(lcab)

# 예제 5-25. Sankey Chart 로 표현하기
install.packages(c("devtools","RJSONIO", "knitr", "shiny", "httpuv")) 
library(devtools) 
install_github("mages/googleVis") 

data1 <- read.csv("data/rchart연습.csv")
data1
require(googleVis) 

san <- gvisSankey(data1, from="항목", to="목적지", weight="크기", 
                  options=list(height=550, width=800,
                               sankey="{link:{color:{fill:'lightblue'}}}" 
                  )) 
header <- san$html$header
header <- gsub('charset=utf-8', 'charset=euc-kr', header)
san$html$header <- header
plot(san)

# 경상남도 2015년 예산 표현하기
data1 <- read.csv("data/경상남도_2015_예산.csv")
data1 
san <- gvisSankey(data1, from="총예산", to="세부지출", weight="예산", 
                  options=list(height=550, width=800, 
                               sankey="{link:{color:{fill:'lightblue'}}}" ))
header <- san$html$header
header <- gsub('charset=utf-8', 'charset=euc-kr', header)
san$html$header <- header
plot(san)

# 영화 배우와 출연 작품 표현
data1 <- read.csv("data/영화배우와_출연작품.csv")
data1 
san <- gvisSankey(data1, from="배우명", to="영화명", weight="관객수", 
                  options=list(height=550, width=800,
                               sankey="{link:{color:{fill:'lightblue'}}}" ))
header <- san$html$header
header <- gsub('charset=utf-8', 'charset=euc-kr', header)
san$html$header <- header
plot(san)