%{
/*
CE3006-* Base3-1 P & C Calculator
110504514
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


// ================ Func Declare ================
void yyerror(const char* message);
void raiseError(const char* message);
int yylex();


size_t factorial(size_t num);
size_t p_formula(size_t num, size_t k);
size_t c_formula(size_t n, size_t m);


// ================ Global Variable ================
char errorMsgbuffer[128];


%}
%union{
    int ival;
    char* word;
    size_t bigInt;
}

%token<ival> INUMBER 
%token P C
%left PLUS MINUS
%type<bigInt> Number
// %token LOAD INC DEC 
// %type<ival> not_used

%%
program: Number {
                    printf("%zu\n", $1);
                }
;
Number: Number PLUS Number 
                {
                    $$ = $1 + $3;
                }
        | Number MINUS Number
                {
                    $$ = $1 - $3;
                }
        | C INUMBER INUMBER
                {
                    $$ = c_formula($2, $3);
                }
        | P INUMBER INUMBER
                {
                    $$ = p_formula($2, $3);
                }
%%

void yyerror (const char *message){
	// extern int yylineno;
	// fprintf(stderr, "%s Error in line %d.\n", errorMsgbuffer, yylineno);
    // sprintf(errorMsgbuffer, "Unable to pop stack, stack is empty");
	// fprintf(stderr, "Syntax error on line %d: \n", yylineno);
    printf("Wrong Formula\n");
    exit(0);
}

void raiseError(const char* msg){
    // fprintf(stderr, "%s\n", msg);
    printf("Invalid format\n");
    exit(0); // should not be -1, OJ will capture it as run error
}

int main(){
	yyparse();
    // printf("what\n");
	return 0;
}

// ============================== function Implementation ==============================

size_t factorial(size_t num){
    if (num == 1){
        return 1;
    }else{
        return num * factorial(num-1);
    }
}

size_t p_formula(size_t n, size_t k){
    // todo: if k > n
    return factorial(n) / factorial(n-k);
}

size_t c_formula(size_t n, size_t m){
    return factorial(n) / factorial(m) / factorial(n-m);
}