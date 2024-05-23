library(homologene)

#' @title 基因同源物转换
#' @description 该函数使用homologene包在人的基因和小鼠的基因之间进行转换。
#' @param genes 字符向量，包含基因名称。
#' @param from 源物种，"human"表示人类，"mouse"表示小鼠。
#' @param to 目标物种，"human"表示人类，"mouse"表示小鼠。
#' @return 一个数据框，包含转换后的基因同源物。
#' @usage
#' homology_gene_convert(genes, from = "human", to = "mouse")
#' @examples
#' # 示例人类基因列表
#' sample_human_genes <- c("BRCA1", "TP53", "EGFR")
#' # 示例小鼠基因列表
#' sample_mouse_genes <- c("Brca1", "Trp53", "Egfr")
#'
#' # 从人类基因转换为小鼠基因
#' mouse_homologs <- homology_gene_convert(sample_human_genes, from = "human", to = "mouse")
#' print(mouse_homologs)
#'
#' # 从小鼠基因转换为人类基因
#' human_homologs <- homology_gene_convert(sample_mouse_genes, from = "mouse", to = "human")
#' print(human_homologs)
#' @details 该函数根据指定的方向（从人类到小鼠或从小鼠到人类）查询homologene数据库，获取相应的基因同源物。
#' @keywords gene conversion homologene human mouse
#' @note 请确保安装并加载`homologene`包。
#' @import homologene
#' @export

homology_gene_convert <- function(genes, from = "human", to = "mouse") {
  # 定义人类和小鼠的分类ID
  human_tax <- 9606
  mouse_tax <- 10090

  # 根据指定的转换方向设置输入和输出分类
  if (from == "human" && to == "mouse") {
    in_tax <- human_tax
    out_tax <- mouse_tax
  } else if (from == "mouse" && to == "human") {
    in_tax <- mouse_tax
    out_tax <- human_tax
  } else {
    stop("指定的转换方向无效。请使用 'human' 到 'mouse' 或 'mouse' 到 'human'。")
  }

  # 查询homologene数据库以获取同源物
  homologs <- homologene::homologene(genes, inTax = in_tax, outTax = out_tax)

  # 返回同源物
  return(homologs)
}
