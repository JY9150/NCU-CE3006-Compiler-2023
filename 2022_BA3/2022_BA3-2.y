%{
/*
CE3006-* Base3-1 P & C Calculator
110504514
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TRUE 1
#define FALSE 0

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
    int tf;
    int op[2];
}

%token TRUE_token FALSE_token
%token AND_start AND_end OR_end NOT_start NOT_end OR_start
%type<op> stmts stmt

%%
program: stmts 
            {
                if($1[0] == -1){ // do or
                    if ($1[1] == TRUE){
                        printf("true");
                    }else{
                        printf("false");
                    }
                }else{ // do and
                    if ($1[0] == TRUE){
                        printf("true");
                    }else{
                        printf("false");
                    }
                }
            }
;
stmts: AND_start stmts AND_end
            {
                $$[0] = $2[0];
                $$[1] = -1;
            }
    | OR_start stmts OR_end
            {
                $$[0] = -1;
                $$[1] = $2[1];

            }
    | NOT_start stmts NOT_end
            {
                if ($2[0] > 0){
                    $$[0] = FALSE;
                }else{
                    $$[0] = TRUE;
                }

                if ($2[1] > 0){
                    $$[1] = FALSE;
                }else{
                    $$[0] = TRUE;
                }

            }
    | stmts stmt
            {
                $$[0] = $1[0] * $2[0];
                $$[1] = $1[1] + $2[1];

                // if ($-1 == 1){
                //     if ($1 == FALSE || $2 == FALSE){
                //         $$ = FALSE;
                //     }else{
                //         $$ = TRUE;
                //     }
                // }else if ($-1 == 2){
                //     if ($1 == TRUE || $2 == TRUE){
                //         $$ = TRUE;
                //     }else{
                //         $$ = FALSE;
                //     }
                // }else {
                //     $$ = FALSE;
                //     printf("error should not be here\n");
                // }
            }
    | stmt
            {
                $$[0] = $1[0];
                $$[1] = $1[0];
            }
;
stmt: AND_start AND_end
            {
                $$[0] = TRUE;
                $$[1] = TRUE;
            }
    | OR_start OR_end
            {
                $$[0] = FALSE;
                $$[1] = FALSE;
            }
    | TRUE_token
            {
                $$[0] = TRUE;
                $$[1] = TRUE;
            }
    | FALSE_token
            {
                $$[0] = FALSE;
                $$[1] = FALSE;
            }
;
    
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