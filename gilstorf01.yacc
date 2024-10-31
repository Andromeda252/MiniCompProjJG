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

stmt:   NUM             {printf("yep thats a number");}
        | PLUS NUM      {printf("yep thats addition");}

%%  

int main()
{
    yyparse();
}

void yyerror (char *msg)
{
    printf("\n%s\n", msg);
}