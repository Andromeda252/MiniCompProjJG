lex.yy.c y.tab.h: gilstorf01.lex
	lex gilstorf01.lex

y.tab.c: gilstorf01.yacc
	yacc -d gilstorf01.yacc

a.out: y.tab.c lex.yy.c
	cc y.tab.c lex.yy.c -ll -ly -o a.out