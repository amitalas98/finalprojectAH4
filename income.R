
income_data <- read.csv("./incomeforfinalproject.csv", stringsAsFactors = FALSE)

names(income_data) <- c("State","2015", "20152", "2010", "20102", "2005", "20052", "2000", "20002")

income_data <- income_data[-c(1, 2, 3, 4), ]

income_data$"20152" <- NULL
income_data$"20102" <- NULL
income_data$"20052" <- NULL
income_data$"20002" <- NULL

