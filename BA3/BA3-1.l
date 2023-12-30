%{
#include "BA3-1.tab.h"

%}

%option noyywrap
%option yylineno
%%

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
[0-9]+      {
                yylval.fval=atof(yytext);
                return(FNUMBER);
            }
[0-9]*"."[0-9]+   {
                yylval.fval=atof(yytext);
                return(FNUMBER);
            }
[0-9]+"."[0-9]*   {
                yylval.fval=atof(yytext);
                return(FNUMBER);
            }

[\n\t\r ]   { }
.           { 
                return(yytext[0]);
            }
%%
