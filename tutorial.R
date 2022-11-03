test1 <- require("lattice")
test2 <- require("slam")
test3 <- require("gurobi")
test4 <- require("designmatch")

list_test <- list(test1, test2, test3, test4)

if ("FALSE" %in% list_test) {cat("You are not ready to work with designmatch.\n")} else {cat("You are ready to work with designmatch\n")}
