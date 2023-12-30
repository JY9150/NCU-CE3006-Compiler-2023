%{
#include "final.tab.h"

%}

%option noyywrap
%option yylineno
%%

0|([1-9][0-9]*)|("-"[1-9][0-9]*) {
                yylval.ival = atoi(yytext);
                return(INUMBER);
            }
"#f"        {
                yylval.ival = 0;
                return(BOOLVAL);
            }
"#t"        {
                yylval.ival = 1;
                return(BOOLVAL);
            }
"+"         {
                return(ADD);
            }
"-"         {
                return(SUB);
            }
"*"         {
                return(MUL);
            }
"/"         {
                return(DIV);
            }
"mod"       {
                return(MOD);
            }
">"         {
                return(GREATER);
            }
"<"         {
                return(SMALLER);
            }
"="         {
                return(EQUAL);
            }
"and"       {
                return(AND);
            }
"or"        {
                return(OR);
            }
"not"       {
                return(NOT);
            }
"define"    {
                return(DEFINE);
            }
"if"        {
                
                return(IF);
            }
"fun"       {
                return(FUN);
            }
"print-num" {
                return(PRINT_NUM);
            }
"print-bool" {
                return(PRINT_BOOL);
            }

[a-z]([a-z]|[0-9]|[-])* {
                yylval.text = strdup(yytext);
                return(ID);
            }


[()]        {
                return(yytext[0]);
            }
[\n\t\r ]   { }
.           { 
                return(yytext[0]);
            }
%%
