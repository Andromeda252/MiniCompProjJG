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
        | WHILE conditional DO stmts ENDWHILE SEMI {printf("valid while\n");}
        | IF conditional THEN stmts ENDIF SEMI {printf("valid if then\n");}
        | IF conditional THEN stmts ELSE stmts ENDIF SEMI {printf("valif if then else\n");}

expr:   term
        | term PLUS term
        | term MINUS term
        
term:   VAR
        | NUM
        | term PLUS term
        | term MINUS term

conditional:  OPAREN condition CPAREN {printf("valid conditional\n");}


condition:  operand LESS operand
            | operand LEQ operand
            | operand GREATER operand
            | operand GEQ operand
            | operand NEQ operand
            | operand EQUAL operand

operand:    VAR
            | NUM

%%  

int main()
{
    yyparse();
}

void yyerror (char *msg)
{
    printf("Syntax error line %d\n", msg);
}