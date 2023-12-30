%{
/*
CE3006-* HW2-1 Coding Style
110504514
*/

#include "string.h"
size_t tabCounter = 0;
int startOfLine = 1;

void printTab(){
    if (startOfLine){
        for (int i = 0; i < tabCounter; i++){
            printf("\t");
        }
        startOfLine = 0;
    }
}

%}

%option noyywrap
%option yylineno
%%


"\{"        { 
                printTab();
                printf("%s", yytext); tabCounter++;
            }
"\}"        { 
                tabCounter--;
                printTab();
                printf("%s", yytext);  
            }
"\n"        { 
                printTab();
                printf("%s", yytext); 
                startOfLine = 1;
            }    
.			{ 
                printTab();
                printf("%s", yytext);
            }
%%

int main (int argc, char * argv[]){
    yylex();
    return 0;
}