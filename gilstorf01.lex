%{
    #include <stdio.h>
    #include <string.h>
    #include "y.tab.h"

    extern int yylineno;
    extern char varname[];
%}

%%

"while"     { printf ("lex found while\n"); return WHILE; }
"do"        { printf ("lex found do \n"); return DO; }
"endwhile"  { printf ("lex found endwhile\n"); return ENDWHILE; }
"if"        { printf ("lex found if\n"); return IF; }
"then"      { printf ("lex found then\n"); return THEN; }
"else"      { printf ("lex found else\n"); return ELSE; }
"endif"     { printf ("lex found endif\n"); return ENDIF; }
"<"         { printf ("lex found less\n"); return LESS; }
"<="        { printf ("lex found leq\n"); return LEQ; }
">"         { printf ("lex found greater\n"); return GREATER; }
">="        { printf ("lex found geq\n"); return GEQ; }
"<>"        { printf ("lex found NEQ\n"); return NEQ; }
"=="        { printf ("lex found equal\n"); return EQUAL; }
"="         { printf ("lex found assign\n"); return ASSIGN; }
"+"         { printf ("lex found plus\n"); return PLUS; }
"-"         { printf ("lex found minus\n"); return MINUS; }
";"         { printf ("lex found semi\n"); return SEMI; }
"("         { printf ("lex found oparen\n"); return OPAREN; }
")"         { printf ("lex found cparen\n"); return CPAREN; }
[0-99]+     { printf ("lex found num\n"); return NUM; }
[a-z]+      { printf ("lex found var\n"); return VAR; }
[ \n\t]+    ;
.           return JUNK;

%%