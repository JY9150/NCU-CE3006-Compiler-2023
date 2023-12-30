%{
/*
CE3006-* HW3-1 Stack-base machine
110504514
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_STACK_SIZE 100
typedef struct {
    int arr[MAX_STACK_SIZE];
    int top;
}Stack;

// ================ Func Declare ================
void yyerror(const char* message);
void raiseError(const char* message);
int yylex();

// stack operation
int stack_init(Stack* stack);
int stack_push(Stack* stack, int in_val);
int stack_pop(Stack* stack);
int stack_isEmpty(Stack* stack);
int stack_isFull(Stack* stack);


// ================ Global Variable ================
char errorMsgbuffer[128];
Stack my_stack;

%}
%union{
    int ival;
    char* word;
}

%token<ival> INUMBER 
%token ADD SUB MUL MOD 
%token LOAD INC DEC 
// %type<ival> not_used

%%
program: lines
;
lines: lines line | line
;
line: ADD   {
                int val1 = stack_pop(&my_stack);
                int val2 = stack_pop(&my_stack);
                stack_push(&my_stack, val1 + val2);
            }
    | SUB
            {
                int val1 = stack_pop(&my_stack);
                int val2 = stack_pop(&my_stack);
                stack_push(&my_stack, val1 - val2);
            }
    | MUL   
            {
                int val1 = stack_pop(&my_stack);
                int val2 = stack_pop(&my_stack);
                stack_push(&my_stack, val1 * val2);
            }
    | MOD
            {
                int val1 = stack_pop(&my_stack);
                int val2 = stack_pop(&my_stack);
                stack_push(&my_stack, val1 % val2);
            }
    | LOAD INUMBER
            {
                stack_push(&my_stack, $2);
            }
    | INC
            {
                int val1 = stack_pop(&my_stack);
                stack_push(&my_stack, val1+1);
            }
    | DEC
            {
                int val1 = stack_pop(&my_stack);
                stack_push(&my_stack, val1-1);
            }
;


%%

void yyerror (const char *message){
	// extern int yylineno;
	// fprintf(stderr, "%s Error in line %d.\n", errorMsgbuffer, yylineno);
    // sprintf(errorMsgbuffer, "Unable to pop stack, stack is empty");
	// fprintf(stderr, "Syntax error on line %d: \n", yylineno);
    printf("Syntax Error\n");
    exit(0);
}

void raiseError(const char* msg){
    // fprintf(stderr, "%s\n", msg);
    printf("Invalid format\n");
    exit(0); // should not be -1, OJ will capture it as run error
}

int main(){
    stack_init(&my_stack);
	yyparse();

    if (my_stack.top > 0 || stack_isEmpty(&my_stack)){
        raiseError("Result of stack should only have one value.");
    }else{
        printf("%d\n", stack_pop(&my_stack));
    }
    // printf("what\n");
	return 0;
}

// ============================== function Implementation ==============================

int stack_init(Stack* stack){
    stack->top = -1;
}

int stack_push(Stack* stack, int val){
    if (stack_isFull(stack)){
        // sprintf(errorMsgbuffer, "Unable to push stack with value: %d, Stack overflow", val);
        raiseError("Unable to push stack, Stack overflow");
        return -1;
    }
    stack->top++;
    stack->arr[stack->top] = val;
    return 0;
}

int stack_pop(Stack* stack){
    if (stack_isEmpty(stack)){
        raiseError("Unable to pop stack, stack is empty");
        return -1;
    }
    stack->top--;
    return stack->arr[stack->top+1];
}

int stack_isEmpty(Stack* stack){
    return stack->top < 0;
}

int stack_isFull(Stack* stack){
    return stack->top > MAX_STACK_SIZE - 1;
}
