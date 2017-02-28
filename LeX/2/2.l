%{
#include <stdlib.h>
#include <stdio.h>
#include "y.tab.h"
#include <locale.h>
/* yylval = atoi(yytext); return INTEGER; */
/*for (i = 0; i < 7; i++) { for (j = 0; j < 7; j++) { printf("%s", A[i][j]); } printf("\n"); } */
int i=0;
int sym=0;
int tr=0;
int c=0;
int j,k,isdate=0;
const char *A[7][7] = {"Ïí ", "Âò ", "Ñð ", "×ò ", "Ïò ", "Ñá ", "Âñ "};
int D[6][7];
const char *C[10];
int charCount=0;
int wordCount=0;
int lineCount=0;
#define INTEGER 258
extern YYSTYPE yylval;
%}

%%
[0-9]+                 { if (isdate == 0) { ECHO; } else { tr=1; D[i][j] = atoi(yytext); j++; } }
[a-zA-Z]*              { if (isdate == 1) { printf(""); } }
\n                     { if (isdate < 2) { if (isdate == 0) printf("\n"); else printf(""); isdate++; } else { j = 0; i++; if (i == 6) for (k = 0; k < 7; k++) { for (j \
= 0; j < 6; j++) { if (j == 0) printf("%s", A[j][k]); if (!D[j][k]) printf("   "); else if (D[j][k] && D[j][k] < 10) printf("%d  ", D[j][k]); else if (D[j][k] >= 10) p\
rintf("%d ", D[j][k]);  else printf("  "); } printf("\n"); } } }
[ \t]                  { if (isdate == 0) { ECHO; } if (isdate == 2 && tr == 0) { c++; if (c % 3 == 2) { D[i][j] = 0; j++; } } }
[^0-9a-zA-Z\n \t]      { if (isdate == 0) ECHO; else printf(""); }
%%
