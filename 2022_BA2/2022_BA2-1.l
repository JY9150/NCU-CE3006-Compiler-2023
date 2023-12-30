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

void removeChar(char *str, char target) {
    int i, j;

    for (i = 0, j = 0; str[i] != '\0'; ++i) {
        if (str[i] != target) {
            str[j++] = str[i];
        }
    }
    str[j] = '\0';
}


char* filter_one_comment(char* in_str){
    const char tofind[] = "// ";
    char* place = strstr(in_str, tofind);  

    // printf("%s", place+3);

    return place+3;
}

char* filter_muti_comment(char* in_str){
    const char tofindend[] = "*/";
    char * place = strstr(in_str, tofindend);

    mysubstr(in_str, 2, strlen(in_str)-3, dest);
    removeChar(dest, '\t');
    return dest;
}

char* filter_print(char* in_str){
    // printf("inside: %s\n", in_str);
    mysubstr(in_str, 8, strlen(in_str)-10, dest);
    return dest;
}

char* filter_if(char* in_str){
    mysubstr(in_str, 3, strlen(in_str)-4, dest);
    if (strcmp(dest, "true") == 0){
        return "True";
    }else if (strcmp(dest, "false") == 0){
        return "False";
    }else {
        printf("error should not be here\n");
    }
    return dest;
}




// int strindex (const char* input, const char* tofind){
//     char* place = strstr(input, tofind);
//     return (int)place - input;
// }

// char* a = "123";
// char* b = "2";
// printf("%d", strindex(a, b));

%}


one_line_comment "// ".*
muti_line_comment "/*"[^*]*"*/"
print_stmt "cout << "((\"[^"]*\")|([0-9]+))" << endl;"
if_stmt "if("("true"|"false")") {"

%option noyywrap
%option yylineno
%%

"    " {
    // printf("get\n");
    printf("    ");
}
{one_line_comment} {
    // filter_one_comment(yytext);
    printf("# %s", filter_one_comment(yytext));
}

{muti_line_comment} {
    printf("\"\"\"%s\"\"\"", filter_muti_comment(yytext));
}

{print_stmt} {
    printf("print(%s)", filter_print(yytext));
}
{if_stmt} {
    printf("if %s:", filter_if(yytext));
}

. { }

%%

int main (int argc, char * argv[]){
    yylex();
    return 0;
}