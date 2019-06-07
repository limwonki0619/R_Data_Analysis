# R에서 별찍기 !!
# Nested for - loop 해보기

#
##
###
####
#####

for (i in 1:5) {
  line <- ''
  for (k in 1:i) {
    line <- paste0(line, '#')
  }
  print(line)
}


#####
####
###
##
#

for (i in 5:1) {
  line <- ''
  for (k in i:1) {
    line <- paste0(line, "#")
  }
  print(line)
}

#####
 ####
  ###
   ##
    #

for (i in 0:4) {
  line <- ''
  if (i != 0 ){ # 첫번쨰 라인 삭제 R에선 0:0까지도 1로 인식 
    for (k in i:1) {
      line <- paste0(line, " ")
    }
  }
  for (k in i:4) {
    line <- paste0(line, "#")
  }
  print(line)
}

#        i  b        #

     #   4  4 4:1  1 4:4
    ##   3  3 3:1  2 3:4
   ###   2  2 2:1  3 2:4
  ####   1  1 1:1  4 1:4
 #####   0  0  -   5 0:4
  ####   1  1 1:1  4 1:4
   ###   2  2 2:1  3 2:4
    ##   3  3 3:1  2 3:4
     #   4  4 4:1  1 4:4

while (T) {
  for (i in 4:0) {
    line <- ''
    if ( i != 0 ){
      for (k in i:1) {
        line <- paste0(line, " ")
      }
    }
    for (k in i:4) {
      line <- paste0(line, "#")
    }
    print(line) 
  }
  for (i in 1:4) {
    line <- ''
    for (k in i:1) {
      line <- paste0(line, " ")
    }
    for (k in i:4) {
      line <- paste0(line, "#")
    }
    print(line)
  }
  break
}
i <- 3:0
for (k in c(i,3:6)) {
  print(k)
}


#          i    b수 (i:3)  #수 1:(i*2-1)
                  
   #       1    3개 (1:3)  1개 1:(i*2-1) 1  
  ###      2    2개 (2:3)  3개 1:(i*2-1) 3
 #####     3    1개 (3:3)  5개 1:(i*2-1) 5
#######    4    0개 (i!=4) 7개 1:(i*2-1) 7
 #####     3    1개 (3:3)  5개 1:(i*2-1) 5
  ###      2    2개 (3:2)  3개 1:(i*2-1) 3
   #       1    3개 (3:1)  1개 1:(i*2-1) 1

while(T){
  for (i in 1:4) {
    line <- ''
    if(i != 4) {
      for (k in i:3) {
        line <- paste0(line, " ")
      }
    } 
    for (k in 1:(i*2-1)) {
      line <- paste0(line , "#")
    }
    print(line)
  }
  for (i in 3:1) {
    line <- ''
    for (k in 3:i) {
      line <- paste0(line, " ")
    }
    for (k in 1:(i*2-1)) {
      line <- paste0(line, "#")
    }
    print(line)
  }
  break
}

                            # i   b수(i:9)  #수 1:(i*2+1)  
length(1:21)                     
#####################         10  0 (i!=10) 21개          
 ###################           9  1 9:9     19개
  #################            8  2 8:9     17개
   ###############
    #############
     ###########
      #########
       #######
        #####
         ###                   1  9 i:9      3개         
          #                    0             1개   
         ###                   1  9 i:9      3개
        #####                  2  8          5개 1:(i*2+1)
       #######
      #########
     ###########
    #############
   ###############
  #################
 ###################
#####################         10  0 (i!=10)  21개

while (T) {
  for (i in 10:0) {
   line <- ''
   if (i != 10){
     for (k in i:9) {
       line <- paste0(line, ' ')
     }  
   } 
   for (k in 1:(i*2+1)) {
     line <- paste0(line, "#")
   }
   print(line)
  }
  for (i in 1:10) {
    line <- ''
    if (i != 10) {
      for (k in i:9) {
        line <- paste0(line, ' ')
      }
    }
    for (k in 1:(i*2+1)) {
      line <- paste0(line, '#')
    }
    print(line)
  }
  break
}

     #         #
    ###       ###
   #####     ##### 
  #######   #######
 ######### #########
#####################              
 ###################         
  #################           
   ###############
    #############
     ###########
      #########
       #######
        #####
         ###                      
          # 


#  i    b      #           b            #
#  1    5(i:5) 1 1:(i*2-1) 9(i*2-1):9   1 1:(i*2-1)
#  2    4      3           7            3
#  3    3      5           5            5
#  4    2      7           3            7 
#  5    1      9           1            9

while (T) {
  for (i in 1:5) {
    line <- ''
    for (k in i:5) {
      line <- paste0(line, " ")
    }
    for (k in 1:(i*2-1)) {
      line <- paste0(line, "#")
    }
    for (k in (i*2-1):9) {
      line <- paste0(line, " ")
    }
    for (k in 1:(i*2-1)) {
      line <- paste0(line, "#")
    }
    print(line)
  }
  for (i in 10:0) {
    line <- ''
    if (i != 10){
      for (k in i:9) {
        line <- paste0(line, ' ')
      }  
    } 
    for (k in 1:(i*2+1)) {
      line <- paste0(line, "#")
    }
    print(line)
  }
  break
}

     #         #
    ###       ###
   #####     #####
  #######   #######
 ######### #########
          #
         ###
        #####
       #######
      #########
     ###########
    #############
   ###############
  #################
 ###################
#####################

while (T) {
  for (i in 1:5) {
    line <- ''
    for (k in i:5) {
      line <- paste0(line, " ")
    }
    for (k in 1:(i*2-1)) {
      line <- paste0(line, "#")
    }
    for (k in (i*2-1):9) {
      line <- paste0(line, " ")
    }
    for (k in 1:(i*2-1)) {
      line <- paste0(line, "#")
    }
    print(line)
  }
  for (i in 0:10) {
    line <- ''
      if (i != 10) {
        for (k in i:9) {
        line <- paste0(line, ' ')
        }
      }
      for (k in 1:(i*2+1)) {
        line <- paste0(line, '#')
      }
  print(line)
  }
  break
}



