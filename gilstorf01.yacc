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

prog:   stmts

stmts:  stmt
        | stmt stmts

stmt: var EQUAL mexpr SEMI {printf("yacc found stmt\n");
                            printf("MOV %s, R0\n", destination);}

mexpr: var1 PLUS var2 {printf("yacc found mexpr\n");}

var1: VAR {printf("MOV R0, %s\n", varname);}
var2: VAR {printf("ADD R0, %s\n", varname);}

var: VAR {strcpy(destination, varname);}

%%  

int main()
{
    yyparse();
}

void yyerror (char *msg)
{
    printf("%s line %d\n", msg, yylineno);
}