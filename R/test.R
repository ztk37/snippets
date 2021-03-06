#R version 3.4.4

s = structure(1)

attr(s, "x") <- 2
attr(s, "y") <- 3
attr(s, "z") <- 5
  
print(c(attributes(s)))

foo <- function(...) {
    structure(list(...), class="foo")
}

derp.foo <- function(x) {
    print("derp that derp")
}

is.foo <- function(x) inherits(x, "foo")

print.foo <- function(x, ...) {
  cat(format(x, ...), "\n", sep = "")
}

f <- foo(x=1, y=2, z=3)
    
derp <- function(x) {
    UseMethod("derp")
} 

print(typeof(f))
print(class(f))
print(attributes(f))

summary(f)
    
print(f)
derp(f)
print(methods("foo"))
   
print(c(1, "asd"))
    
Enum <- function(...) {

  ## EDIT: use solution provided in comments to capture the arguments
  values <- sapply(match.call(expand.dots = TRUE)[-1L], deparse)

  stopifnot(identical(unique(values), values))

  res <- setNames(seq_along(values), values)
  res <- as.environment(as.list(res))
  lockEnvironment(res, bindings = TRUE)
  res
}
    
ABC <- Enum(A, B, C)
    
print(ABC$A)
    
a <- function(...) {
    match.call(expand.dots=TRUE)
} 
    
print(a(a=1,b=2))
    
b <- function(value=42, ...) {
    match.call(expand.dots=FALSE)
}
    
print(b(x=1))
print(typeof(c(1, "adad", TRUE)))
