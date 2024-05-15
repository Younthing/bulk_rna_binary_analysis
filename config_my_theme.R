#  固定变量名 ：my_theme

my_theme <-
  theme(
    plot.margin = margin(0.1, 0.1, 0.1, 0.1, "cm"), # 图像
    plot.title = element_text(
      size = 7, hjust = 0, vjust = 0.5,
      margin = unit(c(0.1, 0.1, 0.1, 0.1), "cm")
    ), panel.grid = element_line(
      colour = "grey90",
      size = 0.75 * 0.47, linetype = 1
    )
  ) +
  theme(
    panel.background = element_blank(), # 面板
    panel.border = element_rect(fill = NA, linewidth = 0.75 * 0.47), # 添加外框
    panel.grid = element_blank()
  ) +
  theme(
    axis.line = element_line(size = 0.75 * 0.47), # 坐标轴
    axis.text = element_text(size = 6, color = "black"), # 坐标文字为黑色
    axis.title = element_text(size = 6),
    axis.ticks = element_line(size = 0.75 * 0.47)
  ) +
  theme(
    legend.title = element_text(size = 6),
    legend.text = element_text(size = 6),
    legend.position = "top", # 图注位置（上）
    legend.direction = "horizontal",
    legend.key.size = unit(c(0.15, 0.15), "cm"),
    legend.margin = margin(0, 0, 0, 0, "cm"),
    legend.box.margin = margin(),
    legend.box.spacing = unit(0, "cm"),
    legend.background = element_blank(), legend.spacing = unit(0, "cm"),
    legend.box.background = element_blank()
  )
