%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
extern YYSTYPE yylval;
%}

%%

\<table\>              {
                       yylval.string = strdup(yytext);
                       return OTBL;
                       }
\<\/table\>            {
                       yylval.string = strdup(yytext);
                       return CTBL;
                       }
\<tr\>                 {
                       yylval.string = strdup(yytext);
                       return OTTR;
                       }
\<\/tr\>               {
                       yylval.string = strdup(yytext);
                       return CTTR;
                       }
\<td\>                 {
                       yylval.string = strdup(yytext);
                       return OTTD;
                       }
\<td\ colspan=\"[0-9]\"\> {
                       yylval.string = strdup(yytext);
                       return TTDC;
                       }
\<td\ rowspan=\"[0-9]\"\> {
                       yylval.string = strdup(yytext);
                       return TTDR;
                       }
\<\/td\>               {
                       yylval.string = strdup(yytext);
                       return CTTD;
                       }
\<th\ rowspan=\"[0-9]\"\> {
                       yylval.string = strdup(yytext);
                       return TTHR;
                       }
\<th\ colspan=\"[0-9]\"\> {
                       yylval.string = strdup(yytext);
                       return TTHC;
                       }
\<\/th\>               {
                       yylval.string = strdup(yytext);
                       return CTTH;
                       }
class1|id1|background|color|ff0000|height|90px|id2|00ff00|width|140pt|0000ff {
                       yylval.string = strdup(yytext);
                       return OTHR;
                       }
[a-zA-Z0-9]*           {
                       yylval.string = strdup(yytext);
                       return TEXT;
                       }
[\t\n ]*               {
                       yylval.string = strdup(yytext);
                       return ENOL;
                       }
\<style\>              {
                       yylval.string = strdup(yytext);
                       return OSTL;
                       }
\<\/style\>            {
                       yylval.string = strdup(yytext);
                       return CSTL;
                       }
\#id[0-9]\ \{[ a-z\ \# \;\n]*\} {
                       yylval.string = strdup(yytext);
                       return GRID;
                       }
\.\#class[0-9]\ \{[a-zA-Z:#\;\n]\n\} {
                       yylval.string = strdup(yytext);
                       return DOCL;
                       }
table\#table[0-9]\ \{\n\ \ \ \ color:\ [#a-zA-Z0-9]*\;\n\} {
                       yylval.string = strdup(yytext);
                       return TBID;
                       }
table\ tr\ td\#id[0-9]\ \{\n\ \ \ \ vertical\-align:\ top\;\n\} {
                       yylval.string = strdup(yytext);
                       return TBTR;
                       }
td\ \{\n\ \ \ \ text\-align:\ center\;\n\} {
                       yylval.string = strdup(yytext);
                       return TDFG;
                       }
\<td\ id=\"id[0-9]\"\> {
                       yylval.string = strdup(yytext);
                       return TDID;
                       }
\<td\ class=\"class[0-9]\"\> {
                       yylval.string = strdup(yytext);
                       return TDCL;
                       }
\<td\ style=\"color:[a-z0-9:#\;]*\"\> {
                       yylval.string = strdup(yytext);
                       return TDST;
                       }
\<table\ id=\"table[0-9]\"\> {
                       yylval.string = strdup(yytext);
                       return TLID;
                       }
\<span\ style=\"background-color:[a-z0-9:#\;]*\"\> {
                       yylval.string = strdup(yytext);
                       return SPST;
                       }
\<span\>               {
                       yylval.string = strdup(yytext);
                       return OSPN;
                       }

[^0-9]                 {
                       yylval.string = strdup(yytext);
                       return OTHR;
                       }

%%
