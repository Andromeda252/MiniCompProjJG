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

stmt: var ASSIGN expr SEMI {printf("MOV %s, R1\n", destination);}
      | WHILE wconditional DO stmts ENDWHILE SEMI {printf("JMP wtop1\n");
                                                   printf("end1:\n");}
      | IF ifconditional THEN stmts ENDIF SEMI {printf("JMP end1\n");
                                                printf("else1:\n");
                                                printf("end1:\n");}
      | IF ifconditional THEN stmts ELSE {printf("JMP end1\n");
                                          printf("else1:\n");} stmts ENDIF SEMI {printf("end1:\n");}

expr: var1
       | var1 PLUS varP
       | var1 MINUS varM

var1: VAR {printf("MOV R1, %s\n", varname);}
      | NUM {printf("MOV R1, %d\n", $1);}
varP: VAR {printf("ADD R1, %s\n", varname);}
      | NUM {printf("ADD R1, %d\n", $1);}
      | varP PLUS varP
      | varP MINUS varM
varM: VAR {printf("SUB R1, %s\n", varname);}
      | NUM {printf("SUB R1, %d\n", $1);}
      | varM MINUS varM
      | varM PLUS varP

var: VAR {strcpy(destination, varname);}
     | NUM {valDest = $1;}

wconditional:  OPAREN wcondition CPAREN

ifconditional: OPAREN ifcondition CPAREN

wcondition:  operand LESS operand {printf("wtop1:\n");
                                   printf("MOV R8, %s\n", destination);
                                   printf("MOV R7, %d\n", valDest);
                                   printf("CMP R7\n");
                                   printf("BGE end1\n");
                                   }
            | operand LEQ operand {printf("wtop1:\n");
                                   printf("MOV R8, %s\n", destination);
                                   printf("MOV R7, %d\n", valDest);
                                   printf("CMP R7\n");
                                   printf("BGT end1\n");
                                   }
            | operand GREATER operand {printf("wtop1:\n");
                                       printf("MOV R8, %s\n", destination);
                                       printf("MOV R7, %d\n", valDest);
                                       printf("CMP R7\n");
                                       printf("BLE end1\n");
                                       }
            | operand GEQ operand {printf("wtop1:\n");
                                   printf("MOV R8, %s\n", destination);
                                   printf("MOV R7, %d\n", valDest);
                                   printf("CMP R7\n");
                                   printf("BLT end1\n");
                                   }
            | operand NEQ operand {printf("wtop1:\n");
                                   printf("MOV R8, %s\n", destination);
                                   printf("MOV R7, %d\n", valDest);
                                   printf("CMP R7\n");
                                   printf("BNE end1\n");
                                   }
            | operand EQUAL operand {printf("wtop1:\n");
                                     printf("MOV R8, %s\n", destination);
                                     printf("MOV R7, %d\n", valDest);
                                     printf("CMP R7\n");
                                     printf("BEQ end1\n");
                                     }

ifcondition: operand LESS operand {printf("MOV R8, %s\n", destination);
                                   printf("MOV R7, %d\n", valDest);
                                   printf("CMP R7\n");
                                   printf("BGE else1\n");}
            | operand LEQ operand {printf("MOV R8, %s\n", destination);
                                   printf("MOV R7, %d\n", valDest);
                                   printf("CMP R7\n");
                                   printf("BGT else1\n");}
            | operand GREATER operand {printf("MOV R8, %s\n", destination);
                                       printf("MOV R7, %d\n", valDest);
                                       printf("CMP R7\n");
                                       printf("BLE else1\n");}
            | operand GEQ operand {printf("MOV R8, %s\n", destination);
                                   printf("MOV R7, %d\n", valDest);
                                   printf("CMP R7\n");
                                   printf("BLT else1\n");}
            | operand NEQ operand {printf("MOV R8, %s\n", destination);
                                   printf("MOV R7, %d\n", valDest);
                                   printf("CMP R7\n");
                                   printf("BNE else1\n");}
            | operand EQUAL operand {printf("MOV R8, %s\n", destination);
                                     printf("MOV R7, %d\n", valDest);
                                     printf("CMP R7\n");
                                     printf("BEQ else1\n");}

operand:    VAR {strcpy(destination, varname);}
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