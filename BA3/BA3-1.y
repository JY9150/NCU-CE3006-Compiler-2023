%{
/*
CE3006-* BA3-1 
110504514
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


// ================ Func Declare ================
void yyerror(const char* message);
void raiseErrorOnLocation(int loc);
int yylex();



// ================ Global Variable ================
char errorMsgbuffer[128];

%}
%code requires {
    typedef struct{  // write it here because union needs it
        size_t i;
        size_t j;
    } Matrix;
}
%union{
    int ival;
    float fval;
}

%token<fval> FNUMBER 
%token ADD SUB MUL DIV


%left ADD SUB
%left MUL DIV
%type<fval> exp

%%
program: exp 
        {
            printf("%.3f", $1);
        }
;
exp: exp ADD exp
        {
            $$ = $1 + $3;
        }
    | exp SUB exp
        {
            $$ = $1 - $3;
        }
    | exp MUL FNUMBER
        {
            $$ = $1 * $3;
        }
    | exp DIV FNUMBER
        {
            if ($3 == 0){
                yyerror("");
            }
            $$ = $1 / $3;
        }
    | FNUMBER
        {
            $$ = $1;
        }
%%

void yyerror (const char *message){
	// extern int yylineno;
	// fprintf(stderr, "%s Error in line %d.\n", errorMsgbuffer, yylineno);
    // sprintf(errorMsgbuffer, "Unable to pop stack, stack is empty");
	// fprintf(stderr, "Syntax error on line %d: \n", yylineno);
    printf("Invalid Value");
    exit(0);
}

void raiseErrorOnLocation(int loc){
    // fprintf(stderr, "%s\n", msg);
    printf("Semantic error on col %d\n", loc);
    exit(0); // should not be -1, OJ will capture it as run error
}

int main(){
	yyparse();
	return 0;
}

// ============================== function Implementation ==============================
