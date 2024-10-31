%{
    #include <stdio.h>
    #include <string.h>

    extern int yylex();
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