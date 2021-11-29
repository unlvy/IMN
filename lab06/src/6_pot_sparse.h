#pragma once

#include <stdio.h>
#include <math.h>

#include "mgmres.h"	


#define ITR_MAX 500
#define MR 500
#define TOL_ABS 1.0e-8
#define TOL_REL 1.0e-8
#define DELTA 0.1

int get_j(int l, int N_X);

int get_i(int l, int N_X);

void solve(int N_X, int N_Y, int EPSILON_1, int EPSILON_2, int V_1, int V_2, int V_3, int V_4, const char* filename, int rho_flag);

void fill_matrix(double* a, int* ja, int* ia, double* b, int N_X, int N_Y, int EPSILON_1, int EPSILON_2, int V_1, int V_2, int V_3, int V_4, int N, int flag, int rho_flag);

double epsilon_l(int l, int EPSILON_1, int EPSILON_2, int N_X);


