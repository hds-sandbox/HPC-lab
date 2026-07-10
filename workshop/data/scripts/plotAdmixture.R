args = commandArgs(trailingOnly=TRUE)
if (length(args) != 1) {
	stop("Please provide Q file!\n", call.=FALSE)
}
if (substr(args[1], nchar(args[1])-1, nchar(args[1])) != ".Q") {
	stop("Please provide correct file format!\n", call.=FALSE)
}

# Load data
Q <- as.matrix(read.table(args[1]))

# Plot and save
png(
	paste0(substr(args[1], 1, nchar(args[1])-2), ".png"), 
	height=4, 
	width=10, 
	units="in", 
	res=300
)
barplot(
	t(Q), 
	space=0, 
	border=NA, 
	col=c("dodgerblue", "firebrick2", "darkorange")
)
dev.off()
