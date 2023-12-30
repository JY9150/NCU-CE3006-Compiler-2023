%{
#include "base3-2.tab.h"

%}

%option noyywrap
%option yylineno
%%

"<true/>"   {
                return(TRUE_token);
            }
"<false/>"  {
                return(FALSE_token);
            }
"<and>"     {
                return(AND_start);
            }
"</and>"    {
                return(AND_end);
            }
"<or>"      {
                return(OR_start);
            }
"</or>"     {
                return(OR_end);
            }
"<not>"     {
                return(NOT_start);
            }
"</not>"    {
                return(NOT_end);
            }
[\n\t\r ]   { }
.           { }
%%