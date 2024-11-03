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

stmt:   VAR              
        | VAR ASSIGN
        | NUM
        | PLUS VAR
        | MINUS VAR
        | PLUS NUM
        | MINUS NUM
        | SEMI          {printf("valid assignment\n");}
        | WHILE DO

%%  

int main()
{
    yyparse();
}

void yyerror (char *msg)
{
    printf("\n%s\n", msg);
}