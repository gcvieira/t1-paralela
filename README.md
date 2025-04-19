# Monte Carlo algorithm

Assignment T1 for the Parallel computing subject.

# Algorithm

Monte Carlo methods, or Monte Carlo experiments, are a broad class of computational algorithms that rely on repeated random sampling to obtain numerical results. The underlying concept is to use randomness to solve problems that might be deterministic in principle.

The program works by receiving the total number of points to be generated (iterations), and then, for each iteration, two random numbers `x` and `y` between 0 and 1 are generated, representing the coordinates of a point inside the square.  
The point is considered to be inside the circle if it satisfies the inequality `x^2 + y^2 <= 1`.

At the end, the proportion of points inside the circle is calculated and multiplied by 4 to obtain an estimate of `π`.  
The program measures the total execution time using `clock()` for future comparison with the parallel version.

# Run it

	gcc mc_sequential.c -o sequential
	gcc -fopenmp mc_parallel.c -o parallel

	./sequential
	./parallel

The program will ask you how many numbers to generate and will display the results for you on the screen.

or you can use the automation which automaticlly compiles and runs both sequential and parallel versions testing increasing numbers of rounds (number generation) with:

	chmod +x runMonteCarlo.sh
	./runMonteCarlo.sh

After running all instances it will save the results to a results file and automatically open it.
