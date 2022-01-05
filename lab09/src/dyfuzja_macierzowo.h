#pragma once

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include <gsl/gsl_math.h>
#include <gsl/gsl_linalg.h>
#include <gsl/gsl_blas.h>

#define N_X 40
#define N_Y 40
#define N ((N_X + 1) * (N_Y + 1))
#define DELTA 1
#define D_T 1
#define T_A 40
#define T_B 0
#define T_C 30
#define T_D 0
#define K_B 0.1
#define K_D 0.6
#define IT_MAX 2000

int getL(int i, int j);

void initCN(gsl_matrix *A, gsl_matrix *B, gsl_vector* c, gsl_vector* T);

double grad2T(gsl_vector* T, int l);

void solve();