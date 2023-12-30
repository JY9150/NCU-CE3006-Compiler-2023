%{
#include "base3-1.tab.h"

%}

%option noyywrap
%option yylineno
%%

"+"         {
                return(PLUS);
            }
"-"         {
                return(MINUS);
            }
[Pp]        {
                return(P);
            }
[Cc]        {
                return(C);
            }
[0-9]+      {
                yylval.ival=atoi(yytext);
                return(INUMBER);
            }
[\n\t\r ]   { }
.           { }
%%