lab1.exe: lab1.o 1_rrz_met_jawne.o
	gcc -o lab1.exe 1_rrz_met_jawne.o lab1.o -Wall -lm
1_rrz_met_jawne.o: 1_rrz_met_jawne.c 1_rrz_met_jawne.h
	gcc -c 1_rrz_met_jawne.c -Wall
lab1.o: lab1.c 1_rrz_met_jawne.h
	gcc -c lab1.c -Wall
clean:
	rm -rf *.o
clear:
	rm -rf *.o
	rm -rf lab1.exe
check:
	valgrind ./lab1.exe
run:
	./lab1.exe