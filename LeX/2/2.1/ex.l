%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
extern YYSTYPE yylval;
%}

%%
[0-9]+                 {
                       yylval.number = atoi(yytext);
                       return NUMB;
                       }
[a-zA-Z]*              return CHAR;
\n                     {
                       yylval.string = strdup(yytext);
                       return ENOL;
                       }
[ \t]                  {
                       yylval.string = strdup(yytext);
                       return STAB;
                       }
[^0-9a-zA-Z\n \t]      {
                       yylval.string = strdup(yytext);
                       return OTHR;
                       }


%%


