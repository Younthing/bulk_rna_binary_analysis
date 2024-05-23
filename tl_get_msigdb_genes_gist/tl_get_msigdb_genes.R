# path/filename: msigdb_gene_extraction.R

library(msigdbr)
library(stringr)

#' @title 下载和匹配MSigDB数据并提取唯一基因
#' @description 该函数下载MSigDB数据，根据描述进行精确或模糊匹配，并提取唯一的基因集。
#' @param species 字符串，表示物种名称（如 "Homo sapiens" 或 "Mus musculus"）。
#' @param keyword 字符串，表示要匹配的关键字。
#' @param match_type 字符串，"exact" 表示精确匹配，"fuzzy" 表示模糊匹配。
#' @return 一个字符向量，包含唯一的基因。
#' @usage
#' get_msigdb_genes(species, keyword, match_type = "exact")
#' @examples
#' # 下载人类的MSigDB数据，进行精确匹配并提取唯一基因
#' unique_genes <- get_msigdb_genes("Homo sapiens", "mitophagy", "exact")
#' print(unique_genes)
#'
#' # 下载小鼠的MSigDB数据，进行模糊匹配并提取唯一基因
#' unique_genes <- get_msigdb_genes("Mus musculus", "mitophagy", "fuzzy")
#' print(unique_genes)
#' @details 该函数首先从MSigDB数据库下载指定物种的基因集数据，然后根据提供的关键字在基因集描述中进行匹配，最后提取并返回唯一的基因集。
#' @keywords MSigDB GSEA gene extraction
#' @note 请确保安装并加载`msigdbr`和`stringr`包。
#' @import msigdbr stringr
#' @export
get_msigdb_genes <- function(species, keyword, match_type = "exact") {
  # 定义下载和匹配函数
  download_and_match_msigdb <- function(species, keyword, match_type) {
    cat("\033[1;34m开始下载 MSigDB 数据...\033[0m\n")
    # 下载指定物种的MSigDB数据
    gsea_db <- msigdbr::msigdbr(species = species)
    cat("\033[1;32m数据下载完成\033[0m\n")

    cat("\033[1;34m开始匹配数据...\033[0m\n")
    # 根据匹配类型进行匹配
    if (match_type == "exact") {
      matched_gsea <- gsea_db[stringr::str_detect(
        gsea_db$gs_description,
        regex(paste0("\\b", keyword, "\\b"), ignore_case = TRUE)
      ), ]
    } else if (match_type == "fuzzy") {
      matched_gsea <- gsea_db[agrep(keyword, gsea_db$gs_description, ignore.case = TRUE), ]
    } else {
      stop("无效的匹配类型。请使用 'exact' 或 'fuzzy'。")
    }
    cat("\033[1;32m数据匹配完成\033[0m\n")

    # 返回匹配结果
    return(matched_gsea)
  }

  # 定义提取唯一基因函数
  extract_unique_genes <- function(gsea_df) {
    cat("\033[1;34m开始提取唯一基因...\033[0m\n")
    # 提取MEMBERS_SYMBOLIZED列中的基因列表
    gsea_genes <- unlist(strsplit(gsea_df$gene_symbol, ";"))

    # 返回唯一的基因集
    unique_genes <- unique(gsea_genes)
    cat("\033[1;32m唯一基因提取完成\033[0m\n")
    return(unique_genes)
  }

  cat("\033[1;34m下载并匹配 MSigDB 数据...\033[0m\n")
  # 下载并匹配MSigDB数据
  matched_gsea <- download_and_match_msigdb(species, keyword, match_type)

  cat("\033[1;34m提取唯一基因...\033[0m\n")
  # 提取唯一的基因
  unique_genes <- extract_unique_genes(matched_gsea)

  cat("\033[1;32m任务完成，返回唯一基因集\033[0m\n")
  # 返回唯一基因集
  return(unique_genes)
}
