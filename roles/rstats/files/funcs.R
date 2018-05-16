# PCA via SVD with straight-forward normalization option
prcomp2 <- function(x, scale=FALSE) {
  m <- x - rowMeans(x) # mean-center
  if(scale) m <- m/(apply(x, 1, sd)) # scale rows by SD
  S <- svd(m) # SVD
  Y <- t(m) %*% S$u # project data onto rotations
	rownames(S$u) <- rownames(x)
	rownames(Y) <- colnames(x)
	colnames(Y) <- sapply(1:ncol(Y), function(p) paste("PC", p, sep=""))
	return(list(rotation=Y, x=S$u, sd=S$d))
}

#read in ped and map files
read_ped <- function(ped, map, missing=FALSE, na=0, verbose=TRUE) {
	raw.ids <- readLines(map) # read in map file
	chr <- as.vector(sapply(X=raw.ids, FUN=function(x) {
			strsplit(x, split="\t")[[1]][1]
		})) # chromosomes
	pos <- as.numeric(as.vector(sapply(X=raw.ids, FUN=function(x) {
			strsplit(x, split="\t")[[1]][4]
		}))) # SNP position
	row.names <- as.vector(sapply(X=raw.ids, FUN=function(x) {
			strsplit(x, split="\t")[[1]][2]
		}))
	num.rows <- length(row.names)
	num.cmd <- system(paste("wc -l", ped), intern=TRUE)
	num.cols <- as.integer(strsplit(num.cmd, split=" ")[[1]][1])
	col.names <- array(dim=num.cols)
	
	if(verbose) { print("Beginning file scan") }
	t0 <- Sys.time()
	line <- scan(file=ped, what="character", sep=" ", quiet=TRUE)
	num.elems <- length(line) - (6 * num.cols)
	if(num.elems/num.cols != (2 * num.rows)) {
		stop("Number of genotypes in ped does not match number of loci in map file!")
	}
	starts <- (seq(0, (2 * num.rows + 6) * num.cols, 2 * num.rows + 6))
	remove <- NULL
	for(i in 1:length(starts)) {
		remove <- c(remove, (starts[i] + 1):(starts[i] + 6))
	}
	col.names <- line[starts + 2]
	line <- as.integer(line[-remove])
	odds <- seq(1, num.elems, 2)
	line <- line[odds] + line[odds + 1] - 2
	if(missing) {
		line[line > 0] <- 0
		line[line < 0] <- 1
	} else {
		line[line < 0] <- 0
	}
	genotypes <- matrix(nrow=num.rows, ncol=num.cols, data=line)
	rm(line)
	gc()
	t1 <- Sys.time()
	if(verbose) { 
		print(paste("Processed", num.rows, "rows in", as.character(t1-t0))) 
	}
	rownames(genotypes) <- row.names[1:nrow(genotypes)]
	colnames(genotypes) <- col.names[1:ncol(genotypes)]
	contents <- list()
	contents$chr <- chr
	contents$pos <- pos
	contents$genotypes <- genotypes
	return(contents)
}

# rejection sampling for truncated normal
trunc <- function(x, m, s, l, u) {
	# if value is within bounds return
	# else, reject and propose new value
	if(x > l & x < u) return(x)
	return(trunc(rnorm(1, m, s), m, s, l, u))
}
rtruncnorm <- function(n, mu=0, sigma=1, lower, upper) {
	# propose n values from normal distribution
	res <- rnorm(n, mu, sigma)
	# make sure all n values are from truncated distribution
	out <- which(res < lower | res > upper)
	res[out] <- sapply(res[out], function(x)
		trunc(x, mu, sigma, lower, upper)
	)	
	return(res)
}
