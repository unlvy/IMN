#include "6_pot_sparse.h"

int main() {

	// 1.
	solve(4, 4, 1, 1, 10, -10, 10, -10, "../results/V_1.dat", 0);
	// 2.
	solve(50, 50, 1, 1, 10, -10, 10, -10, "../results/V_2_50.dat", 0);
	solve(100, 100, 1, 1, 10, -10, 10, -10, "../results/V_2_100.dat", 0);
	solve(200, 200, 1, 1, 10, -10, 10, -10, "../results/V_2_200.dat", 0);
	// 3.
	solve(100, 100, 1, 1, 0, 0, 0, 0, "../results/V_3_1.dat", 1);
	solve(100, 100, 1, 2, 0, 0, 0, 0, "../results/V_3_2.dat", 1);
	solve(100, 100, 1, 10, 0, 0, 0, 0, "../results/V_3_3.dat", 1);

	return 0;
}
