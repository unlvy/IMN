#include "6_pot_sparse.h"

void solve(int N_X, int N_Y, int EPSILON_1, int EPSILON_2, int V_1, int V_2, int V_3, int V_4, const char* filename, int rho_flag) {

	int N = (N_X + 1) * (N_Y + 1);

	// wektory definiujace macierz ukladu
	double a[5 * N];
	int ja[5 * N];
	int ia[N + 1];
	for (int i = 0; i < 5 * N; i++) {
		ja[i] = 0;
	}

	// wektor wyrazow wolnych
	double b[N];
	// wektor rozwiazan
	double V[N];
	for (int i = 0; i < N; i++) { V[i] = 0.; } 

	// WB Dirichleta
	fill_matrix(a, ja, ia, b, N_X, N_Y, EPSILON_1, EPSILON_2, V_1, V_2, V_3, V_4, N, 0, rho_flag);

	// rozwiazanie ukladu
	pmgmres_ilu_cr(N, ia[N], ia, ja, a, V, b, ITR_MAX, MR, TOL_ABS, TOL_REL);

	// zapis macierzy bedacej rozwiazaniem do pliku
	FILE* f = fopen(filename, "w");
	if (f) {
    	for(int l = 0; l < N; l++) {
	        fprintf(f,"%lf ", V[l]);
	        if (!((l+1) % (N_X+ 1)))
	        	fprintf(f,"\n");
	    }
	}
	
}



void fill_matrix(double* a, int* ja, int* ia, double* b, int N_X, int N_Y, int EPSILON_1, int EPSILON_2, int V_1, int V_2, int V_3, int V_4, int N, int flag, int rho_flag) {

	FILE* f1 = NULL;
	FILE* f2 = NULL;

	if (flag) {
		f1 = fopen("../results/M_N0.dat", "w");
		f2 = fopen("../results/b_N0.dat", "w");
	}
	
	double x_max = DELTA * N_X;
	double y_max = DELTA * N_Y;
	double sigma = x_max / 10;
	
	int k = -1;

	for (int l = 0; l < N; l++) {

		int border = 0;
		double vb = 0.0;

		int j = get_j(l, N_X);
		int i = get_i(l, N_X);

		// lewy brzeg
		if (i == 0) {
			border = 1;
			vb = V_1;
		} // gorny brzeg
		if (j == N_Y) {
			border = 1;
			vb = V_2;
		} // prawy brzeg
		if (i == N_X) {
			border = 1;
			vb = V_3;
		} // dolny brzeg
		if (j == 0) {
			border = 1;
			vb = V_4;
		}

		// wyrazy wolne
		if (rho_flag) {
			// UZUPELNIJ
			double x = DELTA * i;
			double y = DELTA * j;
			b[l] = -(exp(-(pow(x - 0.25 * x_max, 2) / pow(sigma, 2)) - (pow(y - 0.5 * y_max, 2) / pow(sigma, 2)))
					- (exp(-(pow(x - 0.75 * x_max, 2) / pow(sigma, 2)) -(pow(y - 0.5 * y_max, 2) / pow(sigma, 2)))));
		}
		else { b[l] = - (0); }
		// wartosc potencjalu na brzegu
		if (border) {
			b[l] = vb;
		}

		// wskaznik dla pierwszego elementu w wierszu
		ia[l] = -1;

		// lewa skrajna przekatna
		if (l - N_X - 1 >= 0 && border == 0) {
			k++;
			if (ia[l] < 0 ) { ia[l] = k; }
			a[k] = epsilon_l(l, EPSILON_1, EPSILON_2, N_X) / pow(DELTA, 2);
			ja[k] = l - N_X - 1;
		}

		// poddiagonala
		if (l - 1 >= 0 && border == 0) {
			k++;
			if (ia[l] < 0 ) ia[l] = k;
			a[k] = epsilon_l(l, EPSILON_1, EPSILON_2, N_X) / pow(DELTA, 2);
			ja[k] = l - 1;
			
		}

		// diagonala
		k++;
		if (ia[l] < 0) ia[l] = k;
		if (border == 0) {
			a[k] = - (2 * epsilon_l(l, EPSILON_1, EPSILON_2, N_X)
				+ epsilon_l(l + 1, EPSILON_1, EPSILON_2, N_X) 
				+ epsilon_l(l + N_X + 1, EPSILON_1, EPSILON_2, N_X)) / pow(DELTA, 2);
		} else {
			a[k] = 1;
		}
		ja[k] = l;

		// naddiagonala
		if (l < N && border == 0) {
			k++;
			a[k] = epsilon_l(l + 1, EPSILON_1, EPSILON_2, N_X) / pow(DELTA, 2);
			ja[k] = l + 1;
		}
		// prawa skrajna przekatna
		if (l < N - N_X - 1 && border == 0) {
			k++;
			a[k] = epsilon_l(l + N_X + 1, EPSILON_1, EPSILON_2, N_X) / pow(DELTA, 2);
			ja[k] = l + N_X + 1; 
		}
		

	}

	if (flag) {
		// zapis do pliku
		if (f1) {
			for (int l = 0; l < N * 5; l++) {
				if (1) {
					int i = get_i(l, N_X);
					int j = get_j(l, N_X);
					fprintf(f1, "l = %2d, i[l] = %2d, j[l] = %2d a[l] = %.2lf\n", l, i, j, a[l]);
				}	
			}
			fclose(f1);
		} 
		if (f2) {
			for (int l = 0; l < N; l++) {
				if (b[l] != 0) {
					int i = get_i(l, N_X);
					int j = get_j(l, N_X);
					fprintf(f2, "l = %2d, i[l] = %2d, j[l] = %2d b[l] = %.2lf\n", l, i, j, b[l]);
				}
			}	
			fclose(f2);
		}
	}
		
	// ilosc niezerowych elementow
	int nz_num = k + 1;
	ia[N] = nz_num;
	printf("%d", nz_num);


}

double epsilon_l(int l, int EPSILON_1, int EPSILON_2, int N_X) {
	return ((get_i(l, N_X) <= N_X/2) ? EPSILON_1 : EPSILON_2);
}

int get_j(int l, int N_X) { return floor(l / (N_X + 1.0)); }

int get_i(int l, int N_X) { return l - get_j(l, N_X) * (N_X + 1); }