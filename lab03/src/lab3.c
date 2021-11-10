#include "3_kontrola_kroku.h"

int main() {

	timeStep(1.0e-2, 1, "../results/T1t.dat", "../results/T1dt.dat", "../results/T1x.dat", "../results/T1v.dat");
	timeStep(1.0e-5, 1, "../results/T2t.dat", "../results/T2dt.dat", "../results/T2x.dat", "../results/T2v.dat") ;

	timeStep(1.0e-2, 0, "../results/RK21t.dat", "../results/RK21dt.dat", "../results/RK21x.dat", "../results/RK21v.dat");
	timeStep(1.0e-5, 0, "../results/RK22t.dat", "../results/RK22dt.dat", "../results/RK22x.dat", "../results/RK22v.dat") ;

	return 0;
}