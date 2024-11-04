%{
    #include <stdio.h>
    #include <string.h>
    #include "y.tab.h"
    extern int yylineno;
%}

%%

"while"     return WHILE;
"do"        return DO;
"endwhile"  return ENDWHILE;
"if"        return IF;
"then"      return THEN;
"else"      return ELSE;
"endif"     return ENDIF;
"<"         return LESS;
"<="        return LEQ;
">"         return GREATER;
">="        return GEQ;
"<>"        return NEQ;
"=="        return EQUAL;
"="         return ASSIGN;
"+"         return PLUS;
"-"         return MINUS;
";"         return SEMI;
"("         return OPAREN;
")"         return CPAREN;
[0-99]+     return NUM;
[a-z]+      return VAR;
[ \n\t]+    ;
.           return JUNK;

%%