# makeCacheMatrix() returns an object to contain a matrix and cache a computed inverse of it as computed by cacheSolve()
# cacheSolve() method to solve inverse matrices and cache the result in an object created by makeCacheMatrix()

# Example usage:

# m1 <- makeCacheMatrix( matrix(data = sapply(1:9, function(x) runif(1) ), nrow = 3, ncol = 3) )
# cacheSolve(m1)

# makeCacheMatrix

# Returns an object (apparently this is what R objects look like) with set, get, set_cached_inverse_matrix, and get_cached_inverse_matrix methods.

# set() stores an unsolved matrix.  This method also clears out any cached solved matrix.
# get() fetches that same unsolved matrix.
# set_cached_inverse_matrix() stores a solved matrix.
# get_cached_inverse_matrix() fetches the stored, solved matrix.

makeCacheMatrix <- function(x = matrix()) {
        cached_inverse_matrix <- NULL
        set <- function(y) {
                x <<- y
                cached_matrix <<- NULL
        }
        get <- function() x
        set_cached_inverse_matrix <- function(mat) cached_inverse_matrix <<- mat
        get_cached_inverse_matrix<- function() cached_inverse_matrix
        list(set = set, get = get,
             set_cached_inverse_matrix = set_cached_inverse_matrix,
             get_cached_inverse_matrix = get_cached_inverse_matrix)
}

# cacheSolve

# Takes an object created by makeCachMatrix() and returns the solved matrix, employing caching.

cacheSolve <- function(x, ...) {
        cached_inverse_matrix <- x$get_cached_inverse_matrix()
        if(!is.null(cached_inverse_matrix)) {
                message("getting cached data")
                return(cached_inverse_matrix)
        }
        original_matrix <- x$get()
        m <- solve(original_matrix, ...)
        x$set_cached_inverse_matrix(m)
        m
}
