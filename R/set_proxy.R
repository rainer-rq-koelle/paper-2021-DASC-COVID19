#' Utility function to help when password changed or the Environmental variables are not loaded
#'
#' @param .pw (string) password
#' @param .name (string) username
#'
#' @return NIL sets proxy variables
#' @export

set_proxy <- function(.pw, .name="rkoelle"){
  proxy_string <- paste0(.name,":",.pw,"@pac.eurocontrol.int:9512/M")
  Sys.setenv("https_proxy" = paste0("https://", proxy_string))
  Sys.setenv("http_proxy"  = paste0("http://",  proxy_string))
}
