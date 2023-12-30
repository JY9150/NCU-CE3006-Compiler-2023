%{
#include "BA3-2.tab.h"

%}

%option noyywrap
%option yylineno
%%

0|[1-9][0-9]*|-[1-9][0-9]* {
            //    printf("get >%s<\n", yytext);
                yylval.ival = atoi(yytext);
                return(NUMBER);
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

[\n\t\r ]   { }
.           { 
                return(yytext[0]);
            }
%%
