%{
#include "hw.tab.h"

%}

%option noyywrap
%option yylineno
%%

\n          {return(0);}
[\t]        {}
[0-9]+      {
                yylval.ival=atoi(yytext);
                return(INUMBER);
            }
[a-zA-Z]+   {
                yylval.word=yytext;
                return(WORD);
            }
.           {
                // return(yytext[0]);
            }
%%
