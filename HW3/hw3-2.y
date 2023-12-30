%{
/*
CE3006-* HW3-1 Stack-base machine
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
    size_t loc_num;
    Matrix matrix;
}

%token<ival> INUMBER 
%token<loc_num> ADD SUB MUL 
%token TRANSPOSE
%token '[' ']' '(' ')' ','

%left ADD SUB
%left MUL
%right TRANSPOSE
%type<matrix> MATRIX

%%
program: MATRIX
;
MATRIX: MATRIX ADD MATRIX
        {
            if (($1.i == $3.i) && ($1.j == $3.j)){
                $$ = $1;
            }else{
                raiseErrorOnLocation($2);
            }
        }
        | MATRIX SUB MATRIX
        {
            if (($1.i == $3.i) && ($1.j == $3.j)){
                $$ = $1;
            }else{
                raiseErrorOnLocation($2);
            }
        }
        | MATRIX MUL MATRIX
        {
            if ($1.j == $3.i){
                Matrix mt = {$1.i, $3.j};
                $$ = mt;
            }else{
                raiseErrorOnLocation($2);
            }
        }
        | MATRIX TRANSPOSE
        {
            Matrix mt = {$1.j, $1.i};
            $$ = mt;
        }
        | '(' MATRIX ')'
        {
            $$ = $2;
        }
        | '[' INUMBER ',' INUMBER ']' 
        {
            Matrix mt = {$2, $4};    
            $$ = mt;
        }

%%

void yyerror (const char *message){
	// extern int yylineno;
	// fprintf(stderr, "%s Error in line %d.\n", errorMsgbuffer, yylineno);
    // sprintf(errorMsgbuffer, "Unable to pop stack, stack is empty");
	// fprintf(stderr, "Syntax error on line %d: \n", yylineno);
    printf("Syntax Error\n");
    exit(0);
}

void raiseErrorOnLocation(int loc){
    // fprintf(stderr, "%s\n", msg);
    printf("Semantic error on col %d\n", loc);
    exit(0); // should not be -1, OJ will capture it as run error
}

int main(){
	yyparse();
    printf("Accepted\n");
	return 0;
}

// ============================== function Implementation ==============================
