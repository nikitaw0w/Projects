copy: lex.yy.c y.tab.c
	gcc lex.yy.c y.tab.c

lex.yy.c: ex.l
	flex ex.l

y.tab.c: ex.y
	yacc -d ex.y

clean:
	rm -Rf example y.tab.c lex.yy.c y.tab.h

.PHONY: clean

