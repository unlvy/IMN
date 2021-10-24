#include <stdio.h>
#include <stdlib.h>
#include <math.h>

/* 1. Problem autonomiczny */
/* Funkcje pomocnicze do RK4, sluzace do obliczania parametrow k */
double k1(double y, double lambda);
double k2(double y, double lambda, double dt);
double k3(double y, double lambda, double dt);
double k4(double y, double lambda, double dt);

/**
 * Funkcja tworzaca wektory t na potrzeby zadania pierwszego
 * @param filename1 nazwa pliku do ktorego zapisane zostana wektory dla dt = 0.01
 * @param filename2 nazwa pliku do ktorego zapisane zostana wektory dla dt = 0.1
 * @param filename3 nazwa pliku do ktorego zapisane zostana wektory dla dt = 1
 * */
void tVectors(const char* filename1, const char* filename2, const char* filename3);

/**
 * Funkcja oblicza wyniki dla danego kroku czasowego i zapisuje
 * wektory t oraz f(t) do danych plikow
 * @param dt krok czasowy
 * @param filename nazwa pliku na wektor f(t)
 * @param mode tryb, w jakim zostanie uruchomiona funkcja (Euler = 0/RK2 = 1/RK4 = 2)
 * */
void forwardMethod(double dt, char* filename, unsigned mode);

/* 2. RRZ 2 rzedu */

/**
 * Oblicza wartosc funkcji napiecia dla danych parametrow
 * @param omegav iloczyn omega * v
 * @param t czas dla jakiego szukamy wartosci
 * @return wartosc funkcji w punkcie
 * */
double functionV(double omegav, double t);

/* Funkcje pomocnicze sluzace do obliczania parametrow k */
double k1Q(double In);
double k1I(double Vn, double Qn, double In, double R, double L, double C);
double k2Q(double Vn, double Qn, double In, double R, double L, double C, double dt);
double k2I(double Vn, double Vn1, double Qn, double In, double R, double L, double C, double dt);
double k3I(double Vn, double Vn1, double Qn, double In, double R, double L, double C, double dt);
double k3Q(double Vn, double Vn1, double Qn, double In, double R, double L, double C, double dt);
double k4Q(double Vn, double Vn1, double Qn, double In, double R, double L, double C, double dt);
double k4I(double Vn, double Vn1, double Vn2, double Qn, double In, double R, double L, double C, double dt);

/**
 * Funkcja rozwiazuje rownanie zawierajace RRZ drugiego rzedy za pomoca metody RK4
 * @param omegav parametr bedacy iloczynem omega * v
 * @param filename1 nazwa pliku do ktorego zapisuje wektor t
 * @param filename2 nazwa pliku do ktorego zapisuje wektor Q
 * @param filename3 nazwa pliku do ktorego zapisuje wektor I
 * */
void RRZ2(double omegav, const char* filename1, const char* filename2, const char* filename3);
