#include "1_rrz_met_jawne.h"

int main() {

	/* Zadanie 1 */

	/* Stworzenie wektorow t na potrzeby zadania pierwszego */
	tVectors("../results/t1.dat", "../results/t2.dat", "../results/t3.dat");	

	/* 1.1 Metoda jawna Eulera */
	/* delta = 0.01 */
	forwardMethod(0.01, "../results/FEMy1.dat", 0);

	/* delta = 0.1 */
	forwardMethod(0.1, "../results/FEMy2.dat", 0);

	/* delta = 1 */
	forwardMethod(1.0, "../results/FEMy3.dat", 0);

	/* 1.2 Metoda RK2 */
	/* delta = 0.01 */
	forwardMethod(0.01, "../results/RK2y1.dat", 1);

	/* delta = 0.1 */
	forwardMethod(0.1, "../results/RK2y2.dat", 1);

	/* delta = 1 */
	forwardMethod(1.0, "../results/RK2y3.dat", 1);

	/* 1.3 Metoda RK4 */
	/* delta = 0.01 */
	forwardMethod(0.01, "../results/RK4y1.dat", 2);

	/* delta = 0.1 */
	forwardMethod(0.1, "../results/RK4y2.dat", 2);

	/* delta = 1 */
	forwardMethod(1.0, "../results/RK4y3.dat", 2);

	/* 2. RRZ 2 rzedu */

	const double omega0 = 1.0 / sqrt(0.1 * 0.001);

	/* 2.1 omegav = 0.5 omega0 */
	RRZ2(0.5 * omega0, "../results/RRZ2t1.dat", "../results/RRZ2q1.dat", "../results/RRZ2i1.dat");

	/* 2.2 omegav = 0.8 omega0 */
	RRZ2(0.8 * omega0, "../results/RRZ2t2.dat", "../results/RRZ2q2.dat", "../results/RRZ2i2.dat");

	/* 2.3 omegav = 1.0 omega0 */
	RRZ2(1.0 * omega0, "../results/RRZ2t3.dat", "../results/RRZ2q3.dat", "../results/RRZ2i3.dat");

	/* 2.4 omegav = 1.2 omega0 */
	RRZ2(1.2 * omega0, "../results/RRZ2t4.dat", "../results/RRZ2q4.dat", "../results/RRZ2i4.dat");

	return 0;
}
