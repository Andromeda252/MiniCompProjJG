%{
    #include <stdio.h>
    #include <string.h>

    extern int yylex();
    void yyerror(char *);

    int yylineno;
    char varname[20];
    char destination[20];
%}

%token WHILE DO ENDWHILE IF THEN ELSE ENDIF LESS LEQ GREATER GEQ NEQ EQUAL ASSIGN PLUS MINUS SEMI OPAREN CPAREN NUM VAR JUNK

%%

%%  

int main()
{
    yyparse();
}

void yyerror (char *msg)
{
    printf("%s line %d\n", msg, yylineno);
}