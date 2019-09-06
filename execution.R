h <- updateHistory()
h <- enrichHistory(h)

h2016 <- h[(as.numeric(as.character(h$year)) >= 2016) & (h$games > 3),]

trainingRowIndex <- sample(1:nrow(h2016), 0.8*nrow(h2016))
trainingData <- h2016[trainingRowIndex, ]
testData  <- h2016[-trainingRowIndex, ]

fit <- lm(dk.points ~ displayName + team + year + h.a + week + pos, data = trainingData)
summary(fit)

mean((predict(fit, trainingData) - trainingData$dk.points) ^ 2)
mean((predict(fit, testData) - testData$dk.points) ^ 2)
