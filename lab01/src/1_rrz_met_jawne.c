#include "1_rrz_met_jawne.h"

/* 1. Problem autonomiczny */
double k1(double y, double lambda) {
	return lambda * y;
}

double k2(double y, double lambda, double dt) {
	return lambda * (y + (dt / 2.0) * k1(y, lambda));
}

double k3(double y, double lambda, double dt) {
	return lambda * (y + (dt / 2.0) * k2(y, lambda, dt));
}

double k4(double y, double lambda, double dt) {
	return lambda * (y + dt * k3(y, lambda, dt));
}

void tVectors(const char* filename1, const char* filename2, const char* filename3) {

	FILE* f1 = fopen(filename1, "w");
	FILE* f2 = fopen(filename2, "w");
	FILE* f3 = fopen(filename3, "w");

	fprintf(f1, "0.0 ");
	fprintf(f2, "0.0 ");
	fprintf(f3, "0.0 ");

	if (f1) {
		double dt = 0.01;
		for (int i = 1; i <= (5.0 / dt); i++) {
			fprintf(f1, "%lf ", i * dt);
		}
	}

	if (f2) {
		double dt = 0.1;
		for (int i = 1; i <= (5.0 / dt); i++) {
			fprintf(f2, "%lf ", i * dt);
		}
	}

	if (f3) {
		double dt = 1.0;
		for (int i = 1; i <= (5.0 / dt); i++) {
			fprintf(f3, "%lf ", i * dt);
		}
	}

	fclose(f1);
	fclose(f2);
	fclose(f3);
}

void forwardMethod(double dt, char* filename, unsigned mode) {

	FILE* f1 = fopen(filename, "w");

	if (!f1 || mode < 0 || mode > 2) {
		fclose(f1);
		return;
	}

	const double LAMBDA = -1.0; 

	double y0 = 1.0;
	double y;

	fprintf(f1, "%lf ", y0);

	for (int i = 1; i <= (5.0 / dt); i++) {
		switch (mode) {
			case 0:
				y = y0 + dt * LAMBDA * y0;
				break;
			case 1:
				y = y0 + (dt  / 2.0) * (LAMBDA * y0 + LAMBDA * (y0 + dt * (LAMBDA * y0)));
				break;
			case 2:
				y = y0 + (dt / 6.0) * (k1(y0, LAMBDA) + 2 * k2(y0, LAMBDA, dt) 
		 			+ 2 * k3(y0, LAMBDA, dt) + k4(y0, LAMBDA, dt));
				break; 
		}
		
		fprintf(f1, "%lf ", y);
		y0 = y;
	}

	fclose(f1);
}

/* 2. RRZ 2 rzedu */
double functionV(double omegav, double t) {
	return 10 * sin(omegav * t);
}

double k1Q(double In) {
	return In;
}

double k1I(double Vn, double Qn, double In, double R, double L, double C) {
	return (Vn / L) - (Qn / (L * C)) - ((R * In) / L);
}

double k2Q(double Vn, double Qn, double In, double R, double L, double C, double dt) {
	return In + (dt / 2.0) * k1I(Vn, Qn, In, R, L, C);
}

double k2I(double Vn, double Vn1, double Qn, double In, double R, double L, double C, double dt) {
	return (Vn1 / L) - ((Qn + (dt / 2.0 * k1Q(In))) / (L * C)) - (R / L) * (In + (dt / 2.0) * k1I(Vn, Qn, In, R, L, C));
}

double k3I(double Vn, double Vn1, double Qn, double In, double R, double L, double C, double dt) {
	return (Vn1 / L) - ((Qn + (dt / 2.0 * k2Q(Vn, Qn, In, R, L, C, dt))) / (L * C)) - (R / L) * (In + (dt / 2.0) * k2I(Vn, Vn1, Qn, In, R, L, C, dt));
}

double k3Q(double Vn, double Vn1, double Qn, double In, double R, double L, double C, double dt) {
	return In + (dt / 2.0) * k2I(Vn, Vn1, Qn, In, R, L, C, dt);
}

double k4Q(double Vn, double Vn1, double Qn, double In, double R, double L, double C, double dt) {
	return In + dt * k3I(Vn, Vn1, Qn, In, R, L, C, dt);
}

double k4I(double Vn, double Vn1, double Vn2, double Qn, double In, double R, double L, double C, double dt) {
	return (Vn2 / L) - ((Qn + (dt * k3Q(Vn, Vn1, Qn, In, R, L, C, dt))) / (L * C)) - (R / L) * (In + dt * k3I(Vn, Vn1, Qn, In, R, L, C, dt));
}

void RRZ2(double omegav, const char* filename1, const char* filename2, const char* filename3) {

	FILE* f1 = fopen(filename1, "w");
	FILE* f2 = fopen(filename2, "w");
	FILE* f3 = fopen(filename3, "w");

	if (!(f1 && f2 && f3)) {
		fclose(f1);
		fclose(f2);
		fclose(f3);
		return;
	}

	const double dt = 0.0001;
	const double R = 100.0;
	const double L = 0.1;
	const double C = 0.001;
	const double omega0 = 1.0 / sqrt(L * C);
	const double T0 = 2 * M_PI / omega0;

	double t0 = 0.0;
	double q0 = 0.0;
	double i0 = 0.0;
	double q = 0.0;
	double i = 0.0;

	fprintf(f1, "%lf ", t0);
	fprintf(f2, "%lf ", q0);
	fprintf(f3, "%lf ", i0);

	for (int j = 1; j <= ((4.0 * T0) / dt); j++) {
	
		q = q0 + (dt / 6.0) * (k1Q(i) + 2.0 * k2Q(functionV(omegav, j * dt), q0, i0, R, L, C, dt) + 2.0 * k3Q(functionV(omegav, j * dt), 
			functionV(omegav, (j + 0.5) * dt), q0, i0, R, L, C, dt) + k4Q(functionV(omegav, j * dt), functionV(omegav, (j + 0.5) * dt), q0, i0, R, L, C, dt));
		i = i0 + (dt / 6.0) * (k1I(functionV(omegav, j * dt), q0, i0, R, L, C) + 2.0 * k2I(functionV(omegav, j * dt), functionV(omegav, (j + 0.5) * dt), 
			q0, i0, R, L, C, dt) + 2.0 * k3I(functionV(omegav, j * dt), functionV(omegav, (j + 0.5) * dt), q0, i0, R, L, C, dt) + k4I(functionV(omegav, j * dt), 
			functionV(omegav, (j + 0.5)), functionV(omegav, (j + 1.0) * dt), q0, i0, R, L, C, dt));
	
		fprintf(f1, "%lf ", j * dt);
		fprintf(f2, "%lf ", q);
		fprintf(f3, "%lf ", i);

		q0 = q;
		i0 = i;
	}

	fclose(f1);
	fclose(f2);
	fclose(f3);

}
