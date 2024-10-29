%{
    #include <stdio.h>
    #include <string.h>
%}

%%

"while"     printf ("WHILE");
"do"        printf ("DO");
"endwhile"  printf ("ENDWHILE");
"if"        printf ("IF");
"then"      printf ("THEN");
"else"      printf ("ELSE");
"endif"     printf ("ENDIF");
"<"         printf ("LESS");
"<="        printf ("LEQ");
">"         printf ("GREATER");
">="        printf ("GEQ");
"<>"        printf ("NEQ");
"=="        printf ("EQUAL");
"="         printf ("ASSIGN");
"+"         printf ("PLUS");
"-"         printf ("MINUS");
";"         printf ("SEMI");
[0-99]+     printf ("NUM");
[a-z]+      printf ("VAR");
.           printf ("JUNK");

%%

int main()
{
    while (yylex());
}
