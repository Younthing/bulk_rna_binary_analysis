#' @title 计算两个数字的和
#' @description 该函数计算两个数字的和。它接收两个参数并返回它们的和。
#'
#' @param x 第一个数字，数值类型。
#' @param y 第二个数字，数值类型。
#' @return
#' @usage param <- argparser::include(param_parse_script)
#' @examples
#' # Run the function with default YAML file
#' (function() {
#'   require(argparser)
#'   parser <- arg_parser(description = "Parameters Generator")
#'   parser <- parser |> add_argument("--param_yaml", help = "YAML parameter file", default = "param.yaml")
#'   argv <- parse_args(parser)
#'   global_params <- yaml::read_yaml(argv$param_yaml)
#' })()
#' @details 本函数仅接受数值输入，如果提供非数值输入，将不会正确工作。
#'
#' @note 请确保所有输入都是数值。
#'
#' @author fanxi <fanxingfu3344@gmail.com>
#' @import argparser yaml
#' @importFrom stats setNames
#' @export
#'
#'

(function() {
  require(argparser)
  parser <- arg_parser(description = "Parameters Generator", name = "", hide.opts = FALSE)
  parser <- parser |> add_argument("--param_yaml", help = "YAML parameter file", default = "param.yaml")
  argv <- parse_args(parser)
  global_params <- yaml::read_yaml(argv$param_yaml)
})()
