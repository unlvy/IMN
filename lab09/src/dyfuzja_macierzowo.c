#include "dyfuzja_macierzowo.h"

int getL(int i, int j) {
	return i + j * (N_X + 1);
}

void initCN(gsl_matrix *A, gsl_matrix *B, gsl_vector* c,  gsl_vector* T) {

	double val;
	int l;

	// wnetrze obszaru
	val = D_T / (2 * pow(DELTA, 2));
	for (int i = 1; i < N_X; i++) {
		for (int j = 1; j < N_Y; j++) {
			l = getL(i, j);

			gsl_matrix_set(A, l, l - N_X - 1, val);
            gsl_matrix_set(A, l, l - 1, val);
            gsl_matrix_set(A, l, l + 1, val);
            gsl_matrix_set(A, l, l + N_X + 1, val);

            gsl_matrix_set(A, l, l, -4 * val - 1);

            gsl_matrix_set(B, l, l - N_X - 1, -val);
            gsl_matrix_set(B, l, l - 1, -val);
            gsl_matrix_set(B, l, l + 1, -val);
            gsl_matrix_set(B, l, l + N_X + 1, -val);

            gsl_matrix_set(B, l, l, 4 * val - 1);
		}
	}

	// WB Dirichleta: lewy, prawy brzeg
	val = 1.0;
	for (int i = 0; i <= N_X; i += N_X) {
		for (int j = 0; j <= N_Y; j++) {
			l = getL(i, j);
			gsl_matrix_set(A, l, l, val);
            gsl_matrix_set(B, l, l, val);
            gsl_vector_set(c, l, 0.0);
		}
	}

	// WB von Neumanna: gorny brzeg w chwili n + 1
	val = 1.0 / (K_B * DELTA);
	for (int i = 1; i < N_X; i++) {
		l = getL(i, N_Y);
		gsl_matrix_set(A, l, l - N_X - 1, -val);
		gsl_matrix_set(A, l, l, 1.0 + val);
		gsl_vector_set(c, l, T_B);
		for (int j = 0; j < N; j++) {
			gsl_matrix_set(B, l, j, 0.0);
		}
	}

	// WB von Neumanna: dolny brzeg w chwili n + 1
	for (int i = 1; i < N_X; i++) {
		l = getL(i, 0);
		gsl_matrix_set(A, l, l, 1.0 + val);
		gsl_matrix_set(A, l, l + N_X + 1, -val);
		gsl_vector_set(c, l, T_D);
		for (int j = 0; j < N; j++) {
			gsl_matrix_set(B, l, j, 0.0);
		}
	}

	// Wektor T
	for (int j = 0; j <= N_Y; j++) {
		// lewy brzeg
		l = getL(0, j);
		gsl_vector_set(T, l, T_A);
		// prawy brzeg
		l = getL(N_X, j);
		gsl_vector_set(T, l, T_C);
		// pozostaly obszar
		for (int i = 1; i < N_X; i++) {
			l = getL(i, j);
			gsl_vector_set(T, l, 0.0);
		}
	}
}

double grad2T(gsl_vector* T, int l) {
    return ((gsl_vector_get(T, l + 1) - 2.0 * gsl_vector_get(T, l) + gsl_vector_get(T, l - 1)) / pow(DELTA, 2)) 
    + ((gsl_vector_get(T, l + N_X + 1) - 2.0 * gsl_vector_get(T, l)	+ gsl_vector_get(T, l - N_X - 1)) / pow(DELTA, 2));
}

void solve() {

	double l;
	int signum;
	char fpath[100];

	// CN
	// alokacja pamieci
	gsl_matrix *A = gsl_matrix_calloc(N, N);
	gsl_matrix *B = gsl_matrix_calloc(N, N);
	gsl_vector *c = gsl_vector_calloc(N);
	gsl_vector *d = gsl_vector_calloc(N);
    gsl_vector *T = gsl_vector_calloc(N);
    gsl_permutation* p = gsl_permutation_calloc(N);

	// inicjalizacja
	initCN(A, B, c, T);

	// rozklad LU: A
	gsl_linalg_LU_decomp(A, p, &signum);

	// glowna petla
	for (int it = 0; it <= IT_MAX; it++) {

		// Mnozenie  B * T
		gsl_blas_dgemv(CblasNoTrans, 1.0, B, T, 0.0, d);
		// dodawanie wektorow
        gsl_blas_daxpy(1.0, c, d);
        // rozwiazanie ukladu z LU
        gsl_linalg_LU_solve(A, p, d, T);

        if (it == 100 || 
        	it == 200 || 
        	it == 500 ||
        	it == 1000 || 
        	it == 2000) {

        	// zapis do pliku
        	sprintf(fpath, "%s%d%s", "../results/T_", it, ".dat");
			FILE* f1 = fopen(fpath, "w");
			sprintf(fpath, "%s%d%s", "../results/DT_", it, ".dat");
            FILE* f2 = fopen(fpath, "w");
            if (f1 && f2) {

	            for(int i = 1; i < N_X; i++) {
	                for(int j = 1; j < N_Y; j++) {
	                	l = getL(i, j);
	                    fprintf(f1, "%lf ", gsl_vector_get(T, l));
	                    fprintf(f2, "%.12lf ", grad2T(T, l));
	                }
	                fprintf(f1, "\n");
	                fprintf(f2, "\n");
	            }
	        }
            fclose(f1);
            fclose(f2);

        }

	}


	// zwalnianie pamieci
	gsl_matrix_free(A);
	gsl_matrix_free(B);
	gsl_vector_free(c);
	gsl_vector_free(d);
	gsl_vector_free(T);
	gsl_permutation_free(p);

}
