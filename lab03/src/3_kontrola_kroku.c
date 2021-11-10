#include "3_kontrola_kroku.h"

double funF(double xn, double xn1, double vn, double vn1, double dt) {
	return xn1 - xn - (dt / 2.0) * (vn + vn1);
}

double funG(double xn, double xn1, double vn, double vn1, double dt) {
	return vn1 - vn - (dt / 2.0) * ((ALPHA * (1.0 - pow(xn, 2)) * vn - xn) + (ALPHA * (1.0 - pow(xn1, 2)) * vn1 - xn1));
}

void trapezoidalRule(double* xn, double* vn, double dt) {

	double a11, a12, a21, a22, F, G, xn1, vn1, dx, dv;

	a11 = 1.0;
	a12 = -dt / 2.0;

	xn1 = *xn;
	vn1 = *vn;

	do {

		a21 = (-dt / 2.0) * ((-2.0) * ALPHA * xn1 * vn1 - 1.0);
		a22 = 1.0 - (dt / 2.0) * ALPHA * (1.0 - pow(xn1, 2));

		F = funF(*xn, xn1, *vn, vn1, dt);
		G = funG(*xn, xn1, *vn, vn1, dt);

		dx = ((-F) * a22 + G * a12) / (a11 * a22 - a12 * a21);
		dv = (a11 * (-G) + a21 * F) / (a11 * a22 - a12 * a21);

		xn1 += dx;
		vn1 += dv;

	} while(fabs(dx) >= DELTA || fabs(dv) >= DELTA) ;

	*xn = xn1;
	*vn = vn1;	
}

void RK2(double* xn, double* vn, double dt) {

	double x = *xn;
	double v = *vn;

	double k1x = v;
	double k1v = ALPHA * (1.0 - pow(x, 2)) * v - x;

	double k2x = v + dt * k1v;
	double k2v = ALPHA * (1.0 - pow(x + dt * k1x, 2)) * (v + dt * k1v) - (x + dt * k1x);

	*xn += (dt / 2.0) * (k1x + k2x);
	*vn += (dt / 2.0) * (k1v + k2v);

}

void timeStep(double TOL, unsigned mode, const char* ft, const char* fdt, const char* fx, const char* fv) {

	double t, dt, x11, v11, x12, v12, x2, v2, Ex, Ev, eMax;

	FILE* fileT = fopen(ft, "w");
	FILE* fileDT = fopen(fdt, "w");
	FILE* fileX = fopen(fx, "w");
	FILE* fileV = fopen(fv, "w");

	if (!(fileT && fileDT && fileX && fileV)) {
		return;
	}

	dt = DT_0;
	t = T_0;
	x11 = x12= x2 = X_0;
	v11 = v12 = v2 = V_0;

	fprintf(fileT, "%lf ", t);
	fprintf(fileDT, "%lf ", dt);
	fprintf(fileV, "%lf ", v11);
	fprintf(fileX, "%lf ", x11);

	do {

		if (mode) {

			// 2 steps
			x12 = x11;
			v12 = v11;
			trapezoidalRule(&x12, &v12, dt);
			trapezoidalRule(&x12, &v12, dt);
			// 1 step
			x2 = x11;
			v2 = v11;
			trapezoidalRule(&x2, &v2, 2 * dt);

		} else {

			// 2 steps
			x12 = x11;
			v12 = v11;
			RK2(&x12, &v12, dt);
			RK2(&x12, &v12, dt);
			// 1 step
			x2 = x11;
			v2 = v11;
			RK2(&x2, &v2, 2 * dt);

		}

		Ex = fabs((x12 - x2) / (pow(2.0, P) - 1.0));
		Ev = fabs((v12 - v2) / (pow(2.0, P) - 1.0));

		eMax = Ex > Ev ? Ex : Ev;

		if (eMax < TOL) {
			x11 = x12;
			v11 = v12;
			t += 2 * dt;
			fprintf(fileT, "%lf ", t);
			fprintf(fileDT, "%lf ", dt);
			fprintf(fileV, "%lf ", v11);
			fprintf(fileX, "%lf ", x11);
		}

		dt = pow(((S * TOL) / eMax), (1.0 / (P + 1.0))) * dt;

	} while (t < T_MAX);

	fclose(fileT);
	fclose(fileDT);
	fclose(fileX);
	fclose(fileV);

}
