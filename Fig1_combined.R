# Fig. 1 — combined panels (a) boxplot by habitat, (b) CORT by nestling age
# Built from "Nestling CORT 2017.Rmd" (Fig.1.1 and fig.2), with:
#   - matching y-axis label and font sizes in both panels
#   - significance asterisk (no bracket) in panel (a) (habitat effect, LMM p = 0.027)
#   - legend removed from panel (b)
# Output: 190 mm wide (Elsevier full-page width), 1000 dpi JPEG

library(dplyr)
library(ggplot2)
library(patchwork)

cort <- read.csv("Nestling.CORT.2017.csv")
cort <- cort %>% filter(bhco.nestling %in% c("no"))

habitat_colors <- c("Urban" = "grey60", "Rural" = "green4")
fam <- "Arial"   # use "Liberation Sans" on Linux if Arial is not installed

shared_theme <- theme_classic(base_size = 18, base_family = fam) +
  theme(
    axis.title = element_text(size = 18),
    axis.text  = element_text(size = 15, colour = "black"),
    legend.position = "none",
    plot.tag = element_text(size = 20, face = "bold")
  )

y_lab <- "Baseline corticosterone (ng/mL)"
y_lim <- c(-0.5, 21)

# ---- Panel (a): boxplot ----
ymax <- max(cort$Baseline.cort, na.rm = TRUE)
br_y <- ymax + 1.2

fig_a <- ggplot(cort, aes(x = Habitat, y = Baseline.cort, color = Habitat)) +
  geom_boxplot(coef = 5, width = 0.5) +
  geom_point(
    aes(fill = Habitat), shape = 21, color = "black",
    position = position_jitterdodge(jitter.width = 0.3, dodge.width = 0.9, seed = 1),
    size = 4, stroke = 0.5
  ) +
  geom_point(stat = "summary", fun = mean, shape = "+", size = 6,
             color = "blue", position = position_dodge(0.9)) +
  # significance asterisk (no bracket, to match other figures)
  annotate("text", x = 1.5, y = br_y, label = "*", size = 10, vjust = 0, family = fam) +
  scale_color_manual(values = habitat_colors) +
  scale_fill_manual(values = habitat_colors) +
  scale_x_discrete(expand = expansion(mult = c(0.1, 0.1))) +
  scale_y_continuous(limits = y_lim, breaks = seq(0, 20, 5)) +
  labs(x = "Habitat", y = y_lab) +
  shared_theme

# ---- Panel (b): CORT by age ----
fit <- lm(Baseline.cort ~ Habitat * Day, data = cort)
p_int <- anova(fit)["Habitat:Day", "Pr(>F)"]

fig_b <- ggplot(cort, aes(x = Day, y = Baseline.cort, color = Habitat, fill = Habitat)) +
  geom_smooth(method = "lm", se = TRUE, alpha = 0.2, linewidth = 0.9, show.legend = FALSE) +
  geom_point(shape = 21, color = "black", stroke = 0.4, size = 2.5, alpha = 0.9,
             position = position_jitter(width = 0.1, height = 0, seed = 1)) +
  annotate("text", x = Inf, y = -Inf,
           label = paste0("Habitat × Day: p = ", sprintf("%.3f", p_int)),
           hjust = 1.05, vjust = -1, fontface = "italic", color = "grey40",
           size = 4.5, family = fam) +
  scale_fill_manual(values = habitat_colors) +
  scale_color_manual(values = habitat_colors) +
  scale_x_continuous(breaks = 5:10) +
  coord_cartesian(ylim = y_lim) +
  scale_y_continuous(breaks = seq(0, 20, 5)) +
  labs(x = "Nestling age (days)", y = y_lab) +
  shared_theme

fig1 <- (fig_a | fig_b) +
  plot_annotation(tag_levels = "a", tag_prefix = "(", tag_suffix = ")")

# 16 x 6.5 in layout scaled to 190 mm wide at 1000 dpi (7480 px)
w_in <- 16; h_in <- 6.5
res  <- 7480 / w_in
jpeg("Fig1_baseline_CORT.jpg", width = w_in, height = h_in, units = "in",
     res = res, quality = 95, type = "cairo")
print(fig1)
dev.off()
