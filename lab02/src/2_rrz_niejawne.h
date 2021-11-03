#include <stdio.h>
#include <stdlib.h>
#include <math.h>

/**
 * funkcja pomocnicza obliczajaca wartosc un+1 dla danych parametrow
 * zgodnie z metoda Picarda
 * @param alpha wartosc wspolczynnika alfa
 * @param beta wartosc wspolczynnika beta
 * @param u wartosc u
 * @param u1 wartosc u1
 * @param dt krok czasowys
 * */
double picard(double alpha, double beta, double u, double u1, double dt);

/**
 * funkcja pomocnicza obliczajaca wartosc un+1 dla danych parametrow
 * zgodnie z iteracja Newtona
 * @param alpha wartosc wspolczynnika alfa
 * @param beta wartosc wspolczynnika beta
 * @param u wartosc u
 * @param u1 wartosc u1
 * @param dt krok czasowys
 * */
double newton(double alpha, double beta, double u, double u1, double dt);

/**
 * funkcja rozwiazujaca RRZ metoda trapezow
 * @param fileName nazwa pliku do ktorego zostanie zapisany wynik
 * @param beta wartosc wspolczynnika beta
 * @param gamma wartosc wspolczynnika gamma
 * @param N wartosc N
 * @param tMax wartosc maksymalna t
 * @param dt krok czasowy
 * @param u0 wartosc poczatkowa
 * @param TOL tolerancja
 * @param mode tryb, sposob w jaki wyznaczane zostanie un+1 (1 - Picard, 0 - Newton)
 * 
 * */
void trapezoidalRule(const char* fileName, double beta, double gamma, int N, int tMax, double dt, int u0, double TOL, int mode);

/**
 * funkcja pomocnicza do RK2
 * @param t wartosc t
 * @param u wartosc u
 * @param beta wartosc beta
 * @param N wartosc N
 * @param gamma wartosc gamma
 * */
double fun(double t, double u, double beta, int N, double gamma);

/**
 * funkcja do metody niejawnej RK2
 * @param fileName nazwa pliku do ktorego zostanie zapisany wynik
 * @param beta wartosc wspolczynnika beta
 * @param gamma wartosc wspolczynnika gamma
 * @param N wartosc N
 * @param tMax wartosc maksymalna t
 * @param dt krok czasowy
 * @param u0 wartosc poczatkowa
 * @param TOL tolerancja
 * */
void RK2(const char* fileName, double beta, double gamma, int N, int tMax, double dt, int u0, double TOL);
