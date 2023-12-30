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


int bookflag = 0;
%}

BOOKNAME ([A-Z][a-z]*)("_"[A-Z][a-z]*)*
AUTHOR [A-Z]+", "[A-Z][a-z]*"-"[A-Z][a-z]*
DATE [0-9]{4}"/"(([0][1-9])|([1][0-2]))"/"(([0][1-9])|([1-2][0-9])|([3][0-1]))
ISBN "978-"[0-9]"-"[0-9]{6}"-"[0-9]{2}"-"[0-9]

%option noyywrap
%option yylineno
%%

{BOOKNAME} {
    if (bookflag == 0){
        printf("Book name:%s\n", yytext);
        bookflag = 1;
    }
}

{AUTHOR} {
    printf("Author:%s\n", yytext);
    bookflag = 0;
}

{DATE} {
    int month;
    int day;


    mysubstr(yytext, 5, 6, dest);
    month = atoi(dest);
    mysubstr(yytext, 8, 9, dest);
    day = atoi(dest);

    if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8
        || month == 10 || month == 12){
            if ( 0 < day && day <= 31){
                printf("Publication date:%s\n", yytext);
            }
    }else if (month == 2){
        if (0 < day && day <= 29){
                printf("Publication date:%s\n", yytext);
        }
    }else if (month == 4 || month == 6 || month == 9 || month == 11){
        if (0 < day && day <= 30){
                printf("Publication date:%s\n", yytext);
        }
    }else {
        printf("error: should not be here\n");
    }
    // printf("month: %d\n", month);
    // printf("day: %d\n", day);
    bookflag = 0;
}

{ISBN} {
    printf("ISBN:%s\n", yytext);
    bookflag = 0;
}

. { }
\n { }

%%

int main (int argc, char * argv[]){
    yylex();
    return 0;
}