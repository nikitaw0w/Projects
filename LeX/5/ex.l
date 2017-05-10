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
[a-zA-Z]*              {
                       yylval.string = strdup(yytext);
                       return CHAR; 
                       }
[a-zA-Z]*"["[a-z]*", "[a-z]*"]"       {
                       yylval.string = strdup(yytext); 
                       return FNAM;
                       }

[a-zA-Z]*"#("[a-z]*"='"[a-z]*"')" {
                       yylval.string = strdup(yytext);
                       return GRD1;
                       }

[a-zA-Z]*"#("[a-z]*"=('"[a-z|']*") && "[a-z]*"='"[a-z]*"')" {
                       yylval.string = strdup(yytext);
                       return GRD2;
                       }

[a-zA-Z]*"#("[a-z]*"='"[a-z]*"' && "[a-z]*"=\""[a-z ]*"\")"  {
                       yylval.string = strdup(yytext);
                       return GRD3;
                       }

[a-zA-Z]*"#("[a-z]*"(>"[0-9]*" && <"[0-9]*" || >"[0-9]*"))" {
                       yylval.string = strdup(yytext);
                       return GRD4;
                       }

[a-zA-Z]*" ("[a-z]*")" {
                       yylval.string = strdup(yytext);
                       return BRCK;
                       }

[a-zA-Z]*"#("[a-z]*"='"[a-z]*"') ("[a-z]*"#("[a-z]*"="[0-9]*"))" {
                       yylval.string = strdup(yytext);
                       return GRD5;
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
