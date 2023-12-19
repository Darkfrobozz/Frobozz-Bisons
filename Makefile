SRC_FILES := $(shell find src -name '*.c')
BASE_NAMES := $(notdir $(SRC_FILES))
OBJ_FILES := $(patsubst %.c, bin/%.o, $(BASE_NAMES))
PROGRAM_LOG := log.txt
CUNIT := -lcunit
gcovarg1 := 
# -ftest-coverage
gcovarg2 := 
# -fprofile-arcs 
gprofarg1 := 
# -pg

FLAGS := -Wall -g ${gcovarg1} ${gcovarg2} ${gprofarg1}


# echo: 
# 	${OBJ_FILES}
all: make_dirs t.out

testReport:
	make t.out gcovarg1="-ftest-coverage" gcovarg2="-fprofile-arcs" gprofarg1="-pg"
	make make_dirs
	make run
	make genCoverage && make genProfile

run: t.out
	./t.out

t.out: test/tests.c $(OBJ_FILES)
	gcc ${FLAGS} $< $(OBJ_FILES) ${CUNIT} -o  $@

bin/temp.o: src/temp.c include/temp.h	 
	gcc ${FLAGS} -c $< -o $@

.PHONY: make_dirs valgrind genCoverage genProfile clean
make_dirs:
	mkdir -p bin
	mkdir -p report

valgrind: t.out
	valgrind ./t.out

genCoverage:
	find . -name "*.gcda" -exec gcov {} >> report/coverage.txt \;
	mv *.gcov report

genProfile:
	gprof t.out gmon.out >> report/profile.txt


## Compile source code here. Remember to specify dependency on header and not link them.
clean:
	rm -rf ${PROGRAM_LOG}
	rm -rf *.out
	rm -rf bin/*
	rm -rf *.gcda *.gcno 
	rm -rf report/*.gcov
	rm -rf report/*.txt
	rm -rf report