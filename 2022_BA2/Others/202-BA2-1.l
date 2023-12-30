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


int strindex (const char* input, const char* tofind){
    char* place = strstr(input, tofind);
    return place - input;
}

// char* a = "123";
// char* b = "2";
// printf("%d", strindex(a, b));

int start = 0;
%}

header1 [#]{1}[ ][^\n]*
header2 [#]{2}[ ][^\n]*
header3 [#]{3}[ ][^\n]*
header4 [#]{4}[ ][^\n]*
header5 [#]{5}[ ][^\n]*
header6 [#]{6}[ ][^\n]*
spilt ^"---"
image "!["[A-Za-z 0-9]*"]("[^)]*")"
select_checked "- ["[Xx]"] "[A-Za-z 0-9]*
select_unchecked "- [ ] "[A-Za-z 0-9]*


%option noyywrap
%option yylineno
%%

{spilt} {
    printf("<hr />\n");
}

{select_checked} {
    mysubstr(yytext, 6, strlen(yytext), dest);
    printf("<p>\n\t<input checked=\"checked\" type=\"checkbox\" /> %s\n</p>\n", dest);
}

{select_unchecked} {
    mysubstr(yytext, 6, strlen(yytext), dest);
    printf("<p>\n\t<input type=\"checkbox\" /> %s\n</p>\n", dest);
}


{image} {
    int sIndex = strindex(yytext, "]\0");
    char alt[200];
    char src[200];

    mysubstr(yytext, 2, sIndex-1, dest);
    strcpy(alt, dest);
    mysubstr(yytext, sIndex+2, strlen(yytext)-2, dest);
    strcpy(src, dest);
    printf("<img alt=\"%s\" src=\"%s\">\n", alt, src);
}

{header6} {
    mysubstr(yytext, 7, strlen(yytext), dest);
    printf("<h6> %s </h6>\n", dest);
}
{header5} {
    mysubstr(yytext, 6, strlen(yytext), dest);
    printf("<h5> %s </h5>\n", dest);
}
{header4} {
    mysubstr(yytext, 5, strlen(yytext), dest);
    printf("<h4> %s </h4>\n", dest);
}
{header3} {
    mysubstr(yytext, 4, strlen(yytext), dest);
    printf("<h3> %s </h3>\n", dest);
}
{header2} {
    mysubstr(yytext, 3, strlen(yytext), dest);
    printf("<h2> %s </h2>\n", dest);
}
{header1} {
    mysubstr(yytext, 2, strlen(yytext), dest);
    printf("<h1> %s </h1>\n", dest);
}


. { }
\n { }

%%

int main (int argc, char * argv[]){
    yylex();
    return 0;
}