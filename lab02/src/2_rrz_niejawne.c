#include "2_rrz_niejawne.h"

double picard(double alpha, double beta, double u, double u1, double dt) {
	return u + (dt / 2.0) * ((alpha * u - beta * u * u) + (alpha * u1 - beta * u1 * u1));
}

double newton(double alpha, double beta, double u, double u1, double dt) {
	return u1 - (u1 - u - (dt / 2.0) * ((alpha * u - beta * u * u) + (alpha * u1 - beta * u1 * u1))) / (1 - (dt / 2.0) * (alpha - 2 * beta * u1));
}

void trapezoidalRule(const char* fileName, double beta, double gamma, int N, int tMax, double dt, int u0, double TOL, int mode) {
	
	FILE* f = fopen(fileName, "w");
	if (!f) {
		return;
	}

	double alpha, t, u, u1;
	int mu;

	t = dt;
	u = u0;
	alpha = beta * N - gamma;

	fprintf(f, "%lf ", u);

	while (t <= tMax) {
		
		mu = 0;
		
		u1 = mode ? picard(alpha, beta, u, u, dt) : newton(alpha, beta, u, u, dt);
		
				
		while (fabs(u1 - u) < TOL && mu++ <= 20) {
			u1 = mode ? picard(alpha, beta, u, u1, dt) : newton(alpha, beta, u, u1, dt);
		}

		u = u1;
		t += dt;

		fprintf(f, "%lf ", u);

	}

	fclose(f);

}

double fun(double t, double u, double beta, int N, double gamma) {
	return (beta * N - gamma) * u - beta * u * u;
}

void RK2(const char* fileName, double beta, double gamma, int N, int tMax, double dt, int u0, double TOL) {

	FILE* f = fopen(fileName, "w");
	if (!f) {
		return;
	}

	double a11 = 0.25;
	double a12 = 0.25 - sqrt(3.0) / 6.0;
	double a21 = 0.25 + sqrt(3.0) / 6.0;
	double a22 = 0.25;
	double b1 = 0.5;
	double b2 = 0.5;
	double c1 = 0.5 - sqrt(3.0) / 6.0;
	double c2 = 0.5 + sqrt(3.0) / 6.0;
	double m11, m12, m21, m22, F1, F2, U1, U2, u, t;
	double alpha = beta * N - gamma;
	int mu;

	u = u0;
	fprintf(f, "%lf ", u);
	t = dt;

	while (t <= tMax) {

		mu = 0;
		U1 = U2 = u;

		while (fabs(U1 - u) < TOL && mu++ <= 20) {

			m11 = 1 - dt * a11 * (alpha - 2.0 * beta * U1);
			m12 = -dt * a12 * (alpha - 2.0 * beta * U2);
			m21 = -dt * a21 * (alpha - 2.0 * beta * U2); 
			m22 = 1 - dt *  a22 * (alpha - 2.0 * beta * U2);

			F1 = U1 - u - dt * (a11 * (alpha * U1 - beta * U1 * U1) + a12 * (alpha * U2 - beta * U2 * U2));
			F2 = U2 - u - dt * (a21 * (alpha * U1 - beta * U1 * U1) + a22 * (alpha * U2 - beta * U2 * U2));

			U1 +=  (F2 * m12 - F1 * m22) / (m11 * m22 - m12 * m21);
			U2 += (F1 * m21 - F2 * m11) / (m11 * m22 - m12 * m21);

		}

		u = u + dt * (b1 * fun(t + c1 * dt, U1, beta, N, gamma) + b2 * fun(t + c2 * dt, U2, beta, N, gamma));
		t += dt;

		fprintf(f, "%lf ", u);

	}

	fclose(f);

}
