%{
#include "hw3-2.tab.h"

size_t pos_counter = 0;
%}

%option noyywrap
%option yylineno
%%

"+"         {
                pos_counter++;
                yylval.loc_num = pos_counter;
                return(ADD);
            }
"-"         {
                pos_counter++;
                yylval.loc_num = pos_counter;
                return(SUB);
            }
"*"         {
                pos_counter++;
                yylval.loc_num = pos_counter;
                return(MUL);
            }
"\^T"       {
                pos_counter+=strlen(yytext);
                return(TRANSPOSE);
            }
[0-9]+      {
                pos_counter+=strlen(yytext);
                yylval.ival=atoi(yytext);
                return(INUMBER);
            }
[\(\)\[\]\,] {
                pos_counter++;
                return(yytext[0]);
            }   
[\n\t\r ]   { 
                pos_counter++;
            }
.           { 
                pos_counter++;
                return(yytext[0]);
            }
%%
