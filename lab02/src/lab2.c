#include "2_rrz_niejawne.h"

int main() {

	/* 1.1 metoda trapezow z iteracja Picarda */
	trapezoidalRule("../results/T_P.dat", 0.001, 0.1, 500, 100, 0.1, 1, 1e-6, 1);

	/* 1.2 metoda trapezow z iteracja Newtona */
	trapezoidalRule("../results/T_N.dat", 0.001, 0.1, 500, 100, 0.1, 1, 1e-6, 0);

	/* 2. metoda niejawna RK2 */
	RK2("../results/RK2.dat", 0.001, 0.1, 500, 100, 0.1, 1, 1e-6);
	return 0;
}
