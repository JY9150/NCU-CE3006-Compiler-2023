%{
/*
CE3006-* Final
110504514
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "final.tab.h"

// ================ Func Declare ================
void yyerror(const char* message);
void raiseErrorOnLocation(int loc);
int yylex();


ASTTree my_ast;
// ================ Global Variable ================
char errorMsgbuffer[128];

%}
%code requires {
    #include <iostream>
    #include <string>
    #include "ASTTree.h"
    #include "SymbolTable.h"
    #include "ASTNode.h"

    using namespace std;

}
%union{
    int ival;
    char* text;
    ASTNode* node;
}

%token<ival> INUMBER BOOLVAL
%token<text> ID
%token ADD SUB MUL DIV MOD GREATER SMALLER EQUAL
%token AND OR NOT
%token DEFINE FUN IF PRINT_NUM PRINT_BOOL


%left ADD SUB
%left MUL DIV
%type<node> stmts stmt 
%type<node> print_stmt exp num_op exps logicl_op def_stmt variable if_exp 
%type<node> fun_exp fun_ids ids fun_body fun_name fun_call params

%%
program: stmts
        {
            my_ast = ASTTree($1);
        }
;
stmts: stmts stmt 
        {
            $$ = new ASTNode(NULL_TYPE, $1, $2);
        }
    | stmt
        {
            $$ = $1;
        }
;
stmt: exp 
        {
            $$ = $1;
        }
    | def_stmt
        {
            $$ = $1;
        }
    | print_stmt
        {
            $$ = $1;
        }
;
print_stmt: '(' PRINT_NUM exp ')'
        {
            $$ = new ASTNode(PRINT_NUM_TYPE, $3, NULL);
        }
        | '(' PRINT_BOOL exp ')'
        {
            $$ = new ASTNode(PRINT_BOOL_TYPE, $3, NULL);
        }
;
exp: 
    BOOLVAL
        {
            $$ = makeBoolValNode($1);
        }
    | INUMBER
        {
            $$ = makeINumberNode($1);
        }
    | variable
        {
            $$ = $1;
        }
    | num_op
        {
            $$ = $1;
        }
    | logicl_op
        {
            $$ = $1;
        }
    | fun_exp
        {
            $$ = $1;
        }
    | fun_call
        {
            $$ = $1;
        }
    | if_exp
        {
            $$ = $1;
        }
;
num_op: '(' ADD exp exps ')' 
        {
            $$ = new ASTNode(ADD_TYPE, $3, $4);
        }
    | '(' SUB exp exp ')'
        {
            $$ = new ASTNode(SUB_TYPE, $3, $4);
        }
    | '(' MUL exps exp ')' 
        {
            $$ = new ASTNode(MUL_TYPE, $3, $4);
        }
    | '(' DIV exp exp ')'
        {
            $$ = new ASTNode(DIV_TYPE, $3, $4);
        }
    | '(' MOD exp exp ')'
        {
            $$ = new ASTNode(MOD_TYPE, $3, $4);
        }
    | '(' GREATER exp exp ')'
        {
            $$ = new ASTNode(GREATER_TYPE, $3, $4);
        }
    | '(' SMALLER exp exp ')'
        {
            $$ = new ASTNode(SMALLER_TYPE, $3, $4);
        }
    | '(' EQUAL exps exp ')' // fix here
        {
            $$ = new ASTNode(EQUAL_TYPE, $3, $4);
        }
;
exps: exps exp
        {
            $$ = new ASTNode(NULL_TYPE, $1, $2);
        }
    | exp
        {
            $$ = $1;
        }
;
logicl_op: '(' AND exps exp ')'
        {
            $$ = new ASTNode(AND_TYPE, $3, $4);
        }
    | '(' OR exps exp ')'
        {
            $$ = new ASTNode(OR_TYPE, $3, $4);
        }
    | '(' NOT exp ')'
        {
            $$ = new ASTNode(NOT_TYPE, $3, NULL);
        }
;
def_stmt: '(' DEFINE variable exp ')'
        {
            $$ = makeDefineNode($3, $4);
        }
;
variable: ID
        {
            $$ = makeIDNode($1);
        }
;
fun_exp: '(' FUN fun_ids fun_body ')'
        {
            $$ = makeFunNode($3, $4);
        }
;
fun_ids: '(' ids ')'
        {
            $$ = $2;
        }
;
ids: ids ID 
        {
            $$ = new ASTNode(NULL_TYPE, $1, makeIDNode($2));
        }
    | 
        {
            $$ = nullptr;
        }
;
fun_body: exp
        {
            $$ = $1;
        }
;
fun_call: '(' fun_exp params ')'
        {
            $$ = new ASTNode(FUN_CALL_TYPE, $2, $3);
        }
    | '(' fun_name params ')'
        {
            $$ = new ASTNode(FUN_CALL_TYPE, $2, $3);
        }
    ;
params: params exp
        {
            $$ = new ASTNode(NULL_TYPE, $1, $2);
        }
        |
        {
            $$ = nullptr;
        }
;
fun_name: ID
        {
            $$ = makeIDNode($1);
        }
;
if_exp: '(' IF exp exp exp ')'
        {
            $$ = makeIFNode($3, $4, $5);
        }
;

%%

void yyerror (const char *message){
	extern int yylineno;
	// fprintf(stderr, "%s Error in line %d.\n", errorMsgbuffer, yylineno);
    // sprintf(errorMsgbuffer, "Unable to pop stack, stack is empty");
	fprintf(stderr, "Syntax error on line %d \n", yylineno);
    // printf("Invalid Value");
    exit(0);
}

void raiseErrorOnLocation(int loc){
    // fprintf(stderr, "%s\n", msg);
    printf("Semantic error on col %d\n", loc);
    exit(0); // should not be -1, OJ will capture it as run error
}

int main(){
	yyparse();
    my_ast.run();
	return 0;
}

// ============================== function Implementation ==============================


