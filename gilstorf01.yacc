%{
    #include <stdio.h>
    #include <string.h>

    extern int yylex();
    void yyerror(char *);

    int yylineno;
    char varname[20];
    char destination[20];
    int valDest = 0;

    int endCount = 1;
    int whileCount = 1;
    int elseCount = 1;
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
      | WHILE wconditional DO stmts ENDWHILE SEMI {printf("JMP wtop%d\n", whileCount - 1);
                                                   printf("end%d:\n", endCount - 1);}
      | IF ifconditional THEN stmts ENDIF SEMI {printf("JMP end%d\n", endCount - 1);
                                                printf("else%d:\n", elseCount - 1);
                                                printf("end%d:\n", endCount - 1);}
      | IF ifconditional THEN stmts ELSE {printf("JMP end%d\n", endCount - 1);
                                          printf("else%d:\n", elseCount - 1);}
                                          stmts ENDIF SEMI {printf("end%d:\n", endCount - 1);}

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

wconditional:  OPAREN wcondition CPAREN {whileCount++;
                                         endCount++;}

ifconditional: OPAREN ifcondition CPAREN {elseCount++;
                                          endCount++;}

wcondition:  operand {printf("wtop%d:\n", whileCount);
                      printf("MOV R8, %s\n", destination);}
                      LESS operand {printf("MOV R7, %s\n", destination);
                                    printf("CMP R7\n");
                                    printf("BGE end%d\n", endCount);
                                    }
            | operand {printf("wtop%d:\n", whileCount);
                       printf("MOV R8, %s\n", destination);}
                       LEQ operand {printf("MOV R7, %s\n", destination);
                                    printf("CMP R7\n");
                                    printf("BGT end%d\n", endCount);
                                    }
            | operand {printf("wtop%d:\n", whileCount);
                       printf("MOV R8, %s\n", destination);}
                       GREATER operand {printf("MOV R7, %s\n", destination);
                                        printf("CMP R7\n");
                                        printf("BLE end%d\n", endCount);
                                        }
            | operand {printf("wtop%d:\n", whileCount);
                       printf("MOV R8, %s\n", destination);}
                       GEQ operand {printf("MOV R7, %s\n", destination);
                                    printf("CMP R7\n");
                                    printf("BLT end%d\n", endCount);
                                    }
            | operand {printf("wtop%d:\n", whileCount);
                       printf("MOV R8, %s\n", destination);}
                       NEQ operand {printf("MOV R7, %s\n", destination);
                                    printf("CMP R7\n");
                                    printf("BNE end%d\n", endCount);
                                    }
            | operand {printf("wtop%d:\n", whileCount);
                       printf("MOV R8, %s\n", destination);}
                       EQUAL operand {printf("MOV R7, %s\n", destination);
                                      printf("CMP R7\n");
                                      printf("BEQ end%d\n", endCount);
                                      }

ifcondition: operand LESS operand {printf("MOV R8, %s\n", destination);
                                   printf("MOV R7, %d\n", valDest);
                                   printf("CMP R7\n");
                                   printf("BGE else%d\n", elseCount);}
            | operand LEQ operand {printf("MOV R8, %s\n", destination);
                                   printf("MOV R7, %d\n", valDest);
                                   printf("CMP R7\n");
                                   printf("BGT else%d\n", elseCount);}
            | operand GREATER operand {printf("MOV R8, %s\n", destination);
                                       printf("MOV R7, %d\n", valDest);
                                       printf("CMP R7\n");
                                       printf("BLE else%d\n", elseCount);}
            | operand GEQ operand {printf("MOV R8, %s\n", destination);
                                   printf("MOV R7, %d\n", valDest);
                                   printf("CMP R7\n");
                                   printf("BLT else%d\n", elseCount);}
            | operand NEQ operand {printf("MOV R8, %s\n", destination);
                                   printf("MOV R7, %d\n", valDest);
                                   printf("CMP R7\n");
                                   printf("BNE else%d\n", elseCount);}
            | operand EQUAL operand {printf("MOV R8, %s\n", destination);
                                     printf("MOV R7, %d\n", valDest);
                                     printf("CMP R7\n");
                                     printf("BEQ else%d\n", elseCount);}

operand:    VAR {strcpy(destination, varname);}
            | NUM {valDest = $1;
                   sprintf(destination, "%d", valDest);}

%%  

int main()
{
    yyparse();
}

void yyerror (char *msg)
{
    printf("%s line %d\n", msg, yylineno);
}