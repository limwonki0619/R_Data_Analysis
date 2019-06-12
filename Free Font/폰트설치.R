# 폰트적용하기 ----------------------------------------------

install.packages("extrafont")
library(extrafont)

font_import(pattern = 'TmonMonsori') #폰트설치 
font_import(pattern = 'Jalnan')
font_import(pattern = 'BMDOHYEON')
font_import(pattern = 'BM') 
font_import(pattern = 'Binggrae') 

loadfonts() # 설치된 폰트 확인 


# 테스트 ------------------------------------------------------------

windowsFonts(hanna=windowsFont("BM HANNA 11yrs old")) # 폰트이름 변경 
windowsFonts(dohyeon=windowsFont("BM DoHyeon"))
windowsFonts(jalnan=windowsFont("Jalnan"))
windowsFonts(tb=windowsFont("TmonMonsori Black"))
windowsFonts(binggrae=windowsFont("Binggrae Taom"))
windowsFonts(nbg=windowsFont("나눔바른고딕"))

iris %>% 
  ggplot(aes(x=Sepal.Length, y=Petal.Length, color=Species)) +
  geom_point() +
  theme_bw(base_family = "나눔바른고딕", base_size = 10) +
  theme(legend.position = "top") +
  labs(title="붓꽃 데이터 한글 글꼴 적용", color="붓꽃 종류") +
  theme(plot.title = element_text(family = "jalnan", face = "bold", hjust = 0.5, size = 15, color = "grey20"))
