library(ggplot2)

ggplot(mtcars, aes(x = drat, y = mpg)) +
  geom_point()