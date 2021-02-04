library(httr)
library(XML)

scrapeData = function(urlprefix, urlend, startyr, endyr) {
  master = data.frame()
  for (i in startyr:endyr) {
    cat('Loading Year', i, '\n')
    URL = GET(paste(urlprefix, as.character(i), urlend, sep = ""))
    table = readHTMLTable(rawToChar(URL$content), stringsAsFactors=F)
    table$Year = i
    master = rbind(table$team_stats, master)
  }
  return(master)
}

### I want to scrape https://www.pro-football-reference.com/years/2020/index.htm & https://www.pro-football-reference.com/years/2020/opp.htm

###example 
defense = scrapeData('http://www.pro-football-reference.com/years/', '/opp.htm',
                    2000, 2020)


###TRYING ESPN, because I couldn't cleanly scrape all of pFR

https://www.espn.com/nfl/stats/team/_/season/2020/seasontype/2
https://www.espn.com/nfl/stats/team/_/view/defense/season/2020/seasontype/2

scrapeData = function(side, startyr, endyr) {
  master = data.frame()
  if (side == "offense") {
    urlprefix = "https://www.espn.com/nfl/stats/team/_/season/"
  } else {
    urlprefix = glue("https://www.espn.com/nfl/stats/team/_/view/",side,"/season/")
  }
  
  urlend = "/seasontype/2"
    
  for (i in startyr:endyr) {
    cat('Loading Year', i, '\n')
    URL = GET(paste(urlprefix, as.character(i), urlend, sep = ""))
    table = Reduce(cbind,readHTMLTable(rawToChar(URL$content), stringsAsFactors=F))
    table$Year = i
    master = rbind(table, master)
  }
  return(master)
}

offense = scrapeData("offense",
                     2000, 2020)

defense = scrapeData("defense", 
                     2000, 2020)

turnovers =  scrapeData("turnovers",
                        2000, 2020)
