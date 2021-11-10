#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define DELTA 1.0e-10
#define S 0.75
#define X_0 0.01
#define V_0 0.0
#define T_0 0.0
#define DT_0 1.0
#define P 2
#define T_MAX 40
#define ALPHA 5

double funF(double xn, double xn1, double vn, double vn1, double dt);
double funG(double xn, double xn1, double vn, double vn1, double dt);
void trapezoidalRule(double* xn, double* vn, double dt);
void RK2(double* xn, double* vn, double dt);
void timeStep(double TOL, unsigned mode, const char* ft, const char* fdt, const char* fx, const char* fv);