%{
    #include <stdio.h>
    #include <string.h>

    extern int yylex();
    void yyerror(char *);
%}

%token WHILE DO ENDWHILE IF THEN ELSE ENDIF LESS LEQ GREATER GEQ NEQ EQUAL ASSIGN PLUS MINUS SEMI OPAREN CPAREN NUM VAR JUNK

%%

prog:   stmts

stmts:  stmt
        | stmt stmts

stmt:   VAR ASSIGN expr SEMI {printf("valid assignment\n");}

expr:   term
        | term PLUS term
        | term MINUS term
        
term:   VAR
        | NUM
        | term2 PLUS term2
        | term2 MINUS term2

term2:  VAR
        | NUM

%%  

int main()
{
    yyparse();
}

void yyerror (char *msg)
{
    printf("\n%s\n", msg);
}