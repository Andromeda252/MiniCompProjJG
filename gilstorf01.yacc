%{
    #include <stdio.h>
    #include <string.h>

    extern int yylex();
    void yyerror(char *);

    int yylineno;
    char varname[20];
    char destination[20];
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

mexpr: var1 PLUS var2 {printf("yacc found mexpr\n");}
       | var1 {printf("yacc found mexpr\n");}


var1: VAR {printf("MOV R1, %s\n", varname);}
      | NUM {printf("MOV R1, %s\n", varname);}
var2: VAR {printf("ADD R1, %s\n", varname);}
      | NUM {printf("ADD R1, %s\n", varname);}

var: VAR {strcpy(destination, varname);}
     | NUM {destination = $1;}

%%  

int main()
{
    yyparse();
}

void yyerror (char *msg)
{
    printf("%s line %d\n", msg, yylineno);
}