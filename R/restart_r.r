#' @title Restart R outside of RStudio
#' 
#' @description Restart R based on \href{https://stackoverflow.com/questions/6313079/quit-and-restart-a-clean-r-session-from-within-r}{the answer with the second-most votes here}. 
#' 
#' @export
reg_rrr <- function() makeActiveBinding("rrr", function() {
    system("R"); 
    path_prof <- file.path(
        usethis:::scoped_path_r('user'), 
        ".Rprofile"
    )
    if(file.exists(path_prof)){
        source(path_prof, local = .GlobalEnv)
    } else{
        path_prof <- file.path(
            usethis:::scoped_path_r('project'), 
            ".Rprofile"
            )
        if(file.exists(path_prof)){
            source(path_prof, local = .GlobalEnv)            
        }
    }
}, .GlobalEnv)