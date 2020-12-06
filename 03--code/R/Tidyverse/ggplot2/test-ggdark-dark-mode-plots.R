library(tidyverse)
library(ggdark)

mtcars %>%
	as_tibble() %>%
	ggplot(aes(x = hp, y = mpg, color = as_factor(cyl))) +
	geom_point() +
	geom_smooth(method = "lm", alpha = 0.2, size = 0.5) +
	theme_classic() +
	dark_mode() +
	theme(
		text = element_text(face = "bold", size = 14, family = "Anonymous Pro"),
		# axis.text.x = element_text(family = "Anonymous Pro")
	) +
	labs(x = "HP",
		 y = "MPG",
		 color = "Cylinders")
s
