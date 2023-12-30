%{
/*
CE3006-* BA3-1 
110504514
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_STACK_SIZE 10
typedef struct {
    int arr[MAX_STACK_SIZE];
    int top;
}Stack;

// ================ Func Declare ================
void yyerror(const char* message);
int yylex();

// stack operation
int stack_init(Stack* stack);
int stack_push(Stack* stack, int in_val);
int stack_pop(Stack* stack);
int stack_isEmpty(Stack* stack);
int stack_isFull(Stack* stack);
void stack_print(Stack* stack);

// ================ Global Variable ================
char errorMsgbuffer[128];
Stack my_stack;

%}
%union{
    int ival;
    float fval;
}

%token<ival> NUMBER 
%token ADD SUB MUL DIV


%left ADD SUB
%left MUL DIV
%type<fval> exp

%%
program: exps 
        {
            
        }
;
exps: exp exps
        {

        }
    | exp
        {

        }
;
exp: ADD
        {
            int val1 = stack_pop(&my_stack);
            int val2 = stack_pop(&my_stack);
            stack_push(&my_stack, val1 + val2);
            stack_print(&my_stack);
        }
    | SUB
        {

            int val1 = stack_pop(&my_stack);
            int val2 = stack_pop(&my_stack);
            stack_push(&my_stack, val2 - val1);
            stack_print(&my_stack);
        }
    | MUL 
        {
            int val1 = stack_pop(&my_stack);
            int val2 = stack_pop(&my_stack);
            stack_push(&my_stack, val1 * val2);
            stack_print(&my_stack);
        }
    | DIV
        {
            int val1 = stack_pop(&my_stack);
            int val2 = stack_pop(&my_stack);
            stack_push(&my_stack, val2 / val1);
            stack_print(&my_stack);
        }
    | NUMBER
        {
            stack_push(&my_stack, $1);
            stack_print(&my_stack);
        }
;
%%

void yyerror (const char *message){
	// extern int yylineno;
	// fprintf(stderr, "%s Error in line %d.\n", errorMsgbuffer, yylineno);
    // sprintf(errorMsgbuffer, "Unable to pop stack, stack is empty");
	// fprintf(stderr, "Syntax error on line %d: \n", yylineno);
    printf("Invalid Value");
    exit(0);
}

void raiseError(const char* msg){
    // fprintf(stderr, "%s\n", msg);
    printf("%s\n", msg);
    exit(0); // should not be -1, OJ will capture it as run error
}

int main(){
    stack_init(&my_stack);
	yyparse();
	return 0;
}

// ============================== function Implementation ==============================

int stack_init(Stack* stack){
    stack->top = -1;
}

int stack_push(Stack* stack, int val){
    if (stack_isFull(stack)){
        // sprintf(errorMsgbuffer, "Unable to push stack with value: %d, Stack overflow", val);
        raiseError("Runtime Error: The push will lead to stack overflow.");
        return -1;
    }
    stack->top++;
    stack->arr[stack->top] = val;
    return 0;
}

int stack_pop(Stack* stack){
    if (stack_isEmpty(stack)){
        raiseError("Runtime Error: The pop will lead to stack underflow.");
        return -1;
    }
    stack->top--;
    return stack->arr[stack->top+1];
}

int stack_isEmpty(Stack* stack){
    return stack->top < 0;
}

int stack_isFull(Stack* stack){
    // printf("top: %d, size: %d\n", stack->top, MAX_STACK_SIZE - 1);
    // stack_print(stack);
    return stack->top >= MAX_STACK_SIZE - 1;
}

void stack_print(Stack* stack){
    int i = 0;
    printf("The contents of the stack are:");
    for (i = 0; i <= stack->top; i++){
        printf(" %d", stack->arr[i]);
    }
    printf("\n");
}