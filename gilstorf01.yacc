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

stmt:   VAR ASSIGN              
        | VAR SEMI          {printf("valid assignment\n");}
        | NUM SEMI          {printf("valid assignment\n");}
        | VAR PLUS VAR SEMI {printf("valid assignment\n");}

%%  

int main()
{
    yyparse();
}

void yyerror (char *msg)
{
    printf("\n%s\n", msg);
}