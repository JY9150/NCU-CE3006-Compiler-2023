%{
#include "hw3-1.tab.h"

%}

%option noyywrap
%option yylineno
%%


"add"       {
                return(ADD);
            }
"sub"       {
                return(SUB);
            }
"mul"       {
                return(MUL);
            }       
"mod"       {
                return(MOD);
            }
"load"      {
                return(LOAD);
            }
"inc"       {
                return(INC);
            }
"dec"       {
                return(DEC);
            }
[0-9]+      {
                yylval.ival=atoi(yytext);
                return(INUMBER);
            }
[\n\t\r ]   { }
.           { }
%%
