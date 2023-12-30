%{
/*
CE3006-* 202? functin call
110504514
*/

#include "string.h"

char dest[200];
// 輸入字串 開始位置 結束位置 輸出字串
void mysubstr (const char* input, int start, int end, char* dest){
    memset(dest, '\0', 200);
    if (start > end || end > strlen(input) )
        return;
    strncpy (dest, input + start, end - start + 1); // + 1 是比較直觀一些
}


// int strindex (const char* input, const char* tofind){
//     char* place = strstr(input, tofind);
//     return (int)place - input;
// }

// char* a = "123";
// char* b = "2";
// printf("%d", strindex(a, b));

int start = 0;
%}

function ^([A-Za-z_][A-Za-z_0-9]*"("(""|([A-Za-z_][A-Za-z_0-9]*)(", "[A-Za-z_][A-Za-z_0-9]*)*)")")

%option noyywrap
%option yylineno
%%

{function} {
    printf("%s\n", yytext);
}

. { }
\n { }

%%

int main (int argc, char * argv[]){
    yylex();
    return 0;
}