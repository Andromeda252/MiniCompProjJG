%{
    #include <stdio.h>
    #include <string.h>

    extern int yylex();
    void yyerror(char *);

    int yylineno;
    char varname[20];
    char destination[20];
    int valDest;
%}

%union {
        int ival;
    }

%token <ival> NUM
%token WHILE DO ENDWHILE IF THEN ELSE ENDIF LESS LEQ GREATER GEQ NEQ EQUAL ASSIGN PLUS MINUS SEMI OPAREN CPAREN VAR JUNK

%%

prog:   stmts

stmts:  stmt
        | stmt stmts

stmt: var ASSIGN mexpr SEMI {printf("yacc found stmt\n");
                            printf("MOV %s, R1\n", destination);}

mexpr: var1 {printf("yacc found mexpr\n");}
       | var1 PLUS var2 {printf("yacc found mexpr\n");}
       | var1 MINUS var2 {printf("yacc found mexpr\n");}


var1: VAR {printf("MOV R1, %s\n", varname);}
      | NUM {printf("MOV R1, %d\n", $1);}
var2: VAR {printf("ADD R1, %s\n", varname);}
      | NUM {printf("ADD R1, %d\n", $1);}
      | var2 PLUS var2
      | var2 MINUS var2

var: VAR {strcpy(destination, varname);}
     | NUM {valDest = $1;}

%%  

int main()
{
    yyparse();
}

void yyerror (char *msg)
{
    printf("%s line %d\n", msg, yylineno);
}