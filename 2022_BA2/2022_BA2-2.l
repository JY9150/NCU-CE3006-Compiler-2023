%{
/*
CE3006-* 2022 Code Transformation
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

name [A-Z]+,[ ][A-Z][a-z]*-[A-Z][a-z]*
ID [A-Z][1-2][0-9]{8}
email [0-9]+[@][a-z]+(\.[a-z]+)*
birthday [0-9]+"/"("0"[0-9]|"1"[0-2])"/"("0"[0-9]|[12][0-9]|"3"[0-1])
phone "+886"[0-9]{9}

%option noyywrap
%option yylineno
%%

{name} {
    if (start == 1){
        printf("\n");
    }
    printf("%s\n", yytext);
    start = 1;
}
{ID} {
    printf("identity number: %s\n", yytext);
}
{email} {
    printf("email: %s\n", yytext);
}
{birthday} {
    printf("birthday: %s\n", yytext);
}
{phone} {
    printf("phone: %s\n", yytext);
}

. { }

%%

int main (int argc, char * argv[]){
    yylex();
    return 0;
}