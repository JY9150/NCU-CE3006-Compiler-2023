%{
/*
CE3006-* HW?
110504514
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// ================ Func Declare ================
void yyerror(const char* message);
int yylex();

// ================ Global Variable ================
char errorMsgbuffer[128];


%}
%union{
    int ival;
    char* word;
}

%token<ival> INUMBER
%token<word> WORD
%type<ival> integer
%type<word> test

%%
program: line
;
line: test test integer 
    {
        printf("first: %s, second: %s\n", $1, $2);
        printf("%d\n", $3);
    }
;
test: WORD
    {
        $$=$1;
    }
;
integer: INUMBER
    {
        $$=$1;
    }
;

%%

void yyerror (const char *message){
	extern int yylineno;
	fprintf(stderr, "%s Error in line %d.\n", errorMsgbuffer, yylineno);
	// fprintf(stderr, "Syntax error on line %d: \n", yylineno);
    // printf("yyerror raised");
}

int main(){
	yyparse();
	return 0;
}

// ============================== function Implementation ==============================
