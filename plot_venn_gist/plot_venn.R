# path/filename: venn_plot.R

library(ggplot2)
library(ggvenn)

#' @title 绘制并保存韦恩图
#' @description 该函数使用ggvenn包绘制韦恩图并保存为文件。可以传递额外的ggvenn和ggsave参数进行定制。
#' @param venn_list 列表，表示要绘制的韦恩图数据。
#' @param directory 字符串，表示输出文件的目录，默认值为 "venn_plot"。
#' @param color 向量，表示各集合的颜色。
#' @param ... 额外的参数，用于定制ggvenn和ggsave的行为。
#' @return 返回生成的韦恩图对象。
#' @examples
#' # 绘制韦恩图并保存为文件
#' venn_list <- list(A = 1:5, B = 4:8, C = 6:10)
#' venn_plot(venn_list, "output_directory", c("red", "green", "blue"))
#' @details 该函数允许通过传递额外参数自定义韦恩图的显示和保存选项。
#' @keywords Venn diagram ggvenn ggsave
#' @import ggplot2 ggvenn
#' @export
venn_plot <- function(venn_list, directory = "venn_plot", color = c("red", "#f6b030", "blue"), ...) {
  # 定义ggvenn和ggsave的默认参数
  default_ggvenn_params <- list(
    show_percentage = FALSE,
    fill_color = color,
    set_name_size = 4
  )
  default_ggsave_params <- list(
    width = 5,
    height = 5,
    create.dir = TRUE
  )

  # 通过...收集额外的参数
  extra_params <- list(...)

  # 合并默认参数和额外参数，额外参数优先
  ggvenn_params <- modifyList(default_ggvenn_params, extra_params)
  ggsave_params <- modifyList(default_ggsave_params, extra_params)

  # 从ggsave_params中移除非ggsave参数
  ggsave_only_params <- intersect(names(ggsave_params), names(formals(ggsave)))
  ggsave_params <- ggsave_params[ggsave_only_params]

  # 创建目录（如果不存在）
  if (!dir.exists(directory)) {
    dir.create(directory, recursive = TRUE)
  }

  # 定义保存文件路径和文件名
  output <- file.path(directory, "venn_diagram.pdf")

  # 调用ggvenn::ggvenn，传递参数列表
  p <- ggvenn::ggvenn(
    data = venn_list,
    fill_color = ggvenn_params$fill_color,
    show_percentage = ggvenn_params$show_percentage,
    set_name_size = ggvenn_params$set_name_size
  )

  # 保存图片，确保包含output路径
  ggsave(
    filename = output,
    plot = p,
    width = ggsave_params$width,
    height = ggsave_params$height,
    create.dir = ggsave_params$create.dir
  )

  return(p)
}
