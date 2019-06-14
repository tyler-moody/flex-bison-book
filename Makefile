all: fb3-1

fb3-1: fb3-1.l fb3-1.y fb3-1.functions.c
	bison -d fb3-1.y
	flex -o fb3-1.lex.c fb3-1.l
	gcc -o $@ -I. fb3-1.tab.c fb3-1.lex.c fb3-1.functions.c

fb3-2: fb3-2.l fb3-2.y fb3-2.functions.c
	bison -d fb3-2.y
	flex -o fb3-2.lex.c fb3-2.l
	gcc -o $@ fb3-2.tab.c fb3-2.lex.c fb3-2.functions.c -lm

fb9-6: fb9-6.l fb9-6.y
	bison fb9-6.y
	flex -o fb9-6.lex.c fb9-6.l
	g++ -o $@ fb9-6.tab.cc fb9-6.lex.c

clean:
	rm -f *.tab.[ch]*
	rm -f *.lex.c
	rm -f lex.yy.c
	rm -f position.hh stack.hh location.hh
	rm -f fb3-1
	rm -f fb3-2
	rm -f fb9-6
