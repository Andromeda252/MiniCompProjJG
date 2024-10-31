%{
    #include <stdio.h>
    #include <string.h>
    #include "y.tab.h"
%}

%%

"while"     printf("WHILE\n");
"do"        printf("DO\n");
"endwhile"  printf ("ENDWHILE\n");
"if"        printf ("IF\n");
"then"      printf ("THEN\n");
"else"      printf ("ELSE\n");
"endif"     printf ("ENDIF\n");
"<"         printf ("LESS\n");
"<="        printf ("LEQ\n");
">"         printf ("GREATER\n");
">="        printf ("GEQ\n");
"<>"        printf ("NEQ\n");
"=="        printf ("EQUAL\n");
"="         printf ("ASSIGN\n");
"+"         printf ("PLUS\n");
"-"         printf ("MINUS\n");
";"         printf ("SEMI\n");
"("         printf ("OPAREN\n");
")"         printf ("CPAREN\n");
[0-99]+     printf ("NUM\n");
[a-z]+      printf ("VAR\n");
[ \n\t]+    ;
.           printf ("JUNK\n");

%%