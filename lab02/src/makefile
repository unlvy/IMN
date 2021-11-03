EXEC = lab2
CC = gcc
CFLAGS = -Wall
SRC = $(wildcard *.c)
OBJS = $(SRC:.c=.o)
LIBS = -lm

all: $(EXEC) clear run

$(EXEC): $(OBJS)
	$(CC) $^ -o $@ $(CFLAGS) $(LIBS)
clear:
	rm -rf *.o

clean:
	rm -rf *.o $(EXEC)
check:
	valgrind ./$(EXEC)

run:
	./$(EXEC)