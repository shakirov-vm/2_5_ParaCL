compile:
	bison bisoner.y -o parser.cpp --defines="numgrammar.tab.hh"
	flex -o lexer.cpp flexer.l
	g++ parser.cpp lexer.cpp test_flex.cpp -Wall
my_compile:
	bison my.y -o parser.cpp --defines="numgrammar.tab.hh"
	flex -o lexer.cpp flexer.l
	g++ parser.cpp lexer.cpp test_flex.cpp -Wall
run:
	./a.out < input
run_eazy:
	./a.out < eazy