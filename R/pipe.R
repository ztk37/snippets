"%>%" <- function(x,f) do.call(f,list(x))
        
c(1:10) %>% (function(x) x * 2) %>% print
     
df <- data.frame(col.A=c(1,2,3,4))
     
df %>% (function(.df) { df$col.B <- df$col.A * 2; return(df) }) %>% print
