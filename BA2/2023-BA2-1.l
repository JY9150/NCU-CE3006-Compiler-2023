%{
/*
CE3006-* 2023 BA2-1 Second Question
110504514
*/

#include "string.h"

char dest[200];
// 輸入字串 開始位置 結束位置 輸出字串
void mysubstr (char* input, int start, int end, char* dest){
    memset(dest, '\0', 200);
    // if (start > end || end > strlen(input) )
    //     return;
    strncpy (dest, input + start, end - start + 1); // + 1 是比較直觀一些
}


int strindex (char* input, char* tofind){
    char* place = strstr(input, tofind);
    return place - input;
}



%}

FLOAT ^((([0-9]*[.][0-9]+)|([0-9]+[.][0-9]*))[\n])
INTERGER ^([0-9]+[\n])
STRING ^(((["][^"\n]*["])|(['][^'\n]*[']))[\n])
VARIABLE ^([A-Za-z_][A-Za-z0-9_]*[\n])


%option noyywrap
%option yylineno
%%

{INTERGER} {
    mysubstr(yytext, 0 , strlen(yytext)-2, dest);
    printf("%s INTERGER\n", dest);
}

{FLOAT} {
    // printf("get: >%s<", yytext);
    mysubstr(yytext, 0 , strlen(yytext)-2, dest);
    printf("%s FLOAT\n", dest);
}

{STRING} {
    mysubstr(yytext, 0 , strlen(yytext)-2, dest);
    printf("%s STRING\n", dest);
}

{VARIABLE} {
    mysubstr(yytext, 0 , strlen(yytext)-2, dest);
    printf("%s VARIABLE\n", dest);
}

. { }
\n { }

%%

int main (int argc, char * argv[]){
    yylex();
    return 0;
}