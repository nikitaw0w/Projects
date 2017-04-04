%{
#include <stdio.h> 
#include <string.h>
#include "y.tab.h" 
extern YYSTYPE yylval; 
%}

%%
[0-9]+                 {
                       yylval.string = strdup(yytext);
                       return CHAR;
                       }       
[a-zA-Z/]*             {
                       yylval.string = strdup(yytext);
                       return CHAR; 
                       }
\n                     {
                       yylval.string = strdup(yytext);
                       return ENOL;
                       } 
[ \t]                  {
                       yylval.string = strdup(yytext);
                       return STAB;
                       }
["\ =\ "]              {
                       yylval.string = strdup(yytext);
                       return NUMB;
                       }

[^0-9a-zA-Z/\n \t]     {
                       yylval.string = strdup(yytext);
                       return OTHR;
                       }
 

%%
