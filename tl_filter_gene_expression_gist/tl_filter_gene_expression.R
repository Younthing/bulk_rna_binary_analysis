#' @title 基因表达数据处理与保存
#' @description 该函数接受基因表达数据和样本分组信息，筛选指定基因的表达数据，并生成相应的CSV文件。
#' @param expr_data 数据框，包含基因表达数据，行名为基因，列名为样本。
#' @param group 数据框，包含样本名称和分组信息，需包含列：sample（样本名称）和group（分组信息）。
#' @param genes 字符向量，包含需要筛选的基因名称。
#' @param output_dir 字符串，表示输出文件夹名称。默认值为 "./Filtered_expr"。
#' @return 无返回值。该函数生成两个CSV文件，分别为筛选后的基因表达矩阵和转置后的基因表达矩阵。
#' @usage
#' filter_gene_expression(expr_data, group, genes, output_dir = "./Filtered_expr")
#' @examples
#' # 读取基因表达数据和分组信息
#' expr_data <- read.csv("path/to/expr_data.csv", row.names = 1)
#' group <- read.csv("path/to/group.csv")
#' genes <- c("gene1", "gene2", "gene3")
#' # 调用函数处理数据
#' filter_gene_expression(expr_data, group, genes)
#' @details 该函数首先创建输出目录，然后标准化样本名称以匹配表达数据的列名，接着筛选指定基因的表达数据，并分别生成两个CSV文件：一个为筛选后的基因表达矩阵，另一个为转置后的基因表达矩阵，包含分组信息。
#' @keywords gene expression data filter
#' @note 请确保安装并加载`dplyr`和`fs`包。
#' @import dplyr fs
#' @export
filter_gene_expression <- function(
    expr_data,
    group,
    genes,
    output_dir = "./Filtered_expr") {
  # 加载包
  require(dplyr)
  require(fs)
  # 创建输出目录
  dir_create(output_dir)

  # 标准化样本名称并匹配表达数据列名与样本名
  group$sample <- make.names(group$sample)
  expr_data <- expr_data[, group$sample, drop = FALSE]

  # 过滤显著基因的表达数据
  diff_expr_data <- expr_data[genes, , drop = FALSE]

  # 保存差异基因表达矩阵
  write.csv(
    diff_expr_data,
    file.path(output_dir, "gene_expr_list.csv"),
    row.names = TRUE
  )
  cat("gene_expr_list.csv\n")

  # 生成特定分组的差异基因表达矩阵，并保存为CSV文件
  dat_t <- cbind(group = group$group, t(diff_expr_data)) %>%
    as.data.frame()
  write.csv(dat_t, file.path(output_dir, "gene_transposed_matrix.csv"))

  cat("文件已成功生成并保存。\n")
}
