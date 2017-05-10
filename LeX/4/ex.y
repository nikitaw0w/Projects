/**
 * Программа транслирования HTML в TeX ex.y
 *
 * Copyright (c) 2017, Bazhenov Nikita <bazhenov@cs.karelia.ru>
 *
 * This code is licensed under a MIT-style license.
 *
 * Usage:
 * ./a.out < ex1.html
 */

%{
#include <stdio.h>
#include <string.h>
#include <locale.h>
#include <stdlib.h>
#include "clr.c"
#include "mystack.c"
#include "newstack.c"

#define HUN 100
    
int i = 0;
FILE *f;
char D[1000] = "";
char mSQL[1000] = "";

char brobject[100] = "empty()";
int err_sig = 0;

int cur_text_num = 0;
int text_num = 0;
char text[100][100] = {};

int template[10]= {0};

int tdnum = 0;
int trnum = 0;
int thnum1 = 0;
int thnum2 = 0;

void templates();

void templates()
{
    int s = 0;
    for (s = 0; s < 10; s++)
    {
	//printf("da %d", template[s]);
    }
    
    if (template[0] && !template[1] && !template[2] && !template[3] && !template[6] && !template[7])
    {
	fprintf(f, "\\begin{tabular}{cc}\n");
	fprintf(f, "%s & %s\\\\\n", text[cur_text_num], text[cur_text_num + 1]); cur_text_num += 2; 
	fprintf(f, "%s & %s\\\\\n", text[cur_text_num], text[cur_text_num + 1]); cur_text_num += 2;
	fprintf(f, "\\end{tabular}\n\n");
    }

    else if (template[1] && !template[2])
    {
	fprintf(f, "\\begin{tabular}{cc}\n");
	fprintf(f, "\\multicolumn{%d}{l}{%s}\\\\\n", tdnum, text[cur_text_num]); cur_text_num++;
	fprintf(f, "%s & %s\\\\\n", text[cur_text_num], text[cur_text_num + 1]); cur_text_num += 2;
	fprintf(f, "\\end{tabular}\n\n");
    }

    else if (template[2] && !template[1])
    {
	fprintf(f, "\\begin{tabular}{cc}\n");
	fprintf(f, "\\multirow{%d}{*}{%s}&%s\\\\\n", trnum, text[cur_text_num], text[cur_text_num + 1]); cur_text_num += 2;
	fprintf(f, "&%s\\\\\n", text[cur_text_num]); cur_text_num++;
	fprintf(f, "\\end{tabular}\n\n");

    }

    else if (template[3] && template[4])
    {
	fprintf(f, "\\begin{tabular}{ccc}\n");
	fprintf(f, "\\multirow{%d}{*}{\\textbf{%s}}&\\multicolumn{%d}{c}{\\textbf{%s}}\\\\\n", thnum1, text[cur_text_num], thnum2, text[cur_text_num + 1]);
	cur_text_num += 2;
	fprintf(f, "&%s & %s\\\\\n", text[cur_text_num], text[cur_text_num + 1]); cur_text_num += 2;
	fprintf(f, "\\end{tabular}\n\n");
    }

    else if (template[5])
    {
	fprintf(f, "\\begin{tabular}{cc}\n");
	fprintf(f, "\\colorbox{%s}{\\color{%s}\\raisebox{.9\\height}{%s}}&\\colorbox{%s}{%s}\\\\\n", color3, color4, text[cur_text_num], color1,
		text[cur_text_num + 1]); cur_text_num += 2;
	fprintf(f, "\\colorbox{%s}{%s}&\\color{%s}%s\\\\\n", color1, text[cur_text_num], color4, text[cur_text_num + 1]); cur_text_num += 2;  
	fprintf(f, "\\end{tabular}\n\n");
    }

    else if (template[6])
    {
	fprintf(f, "\\begin{tabular}{cc}\n");
        fprintf(f, "%s & %s\\\\\n", text[cur_text_num], text[cur_text_num + 1]); cur_text_num += 2;
        fprintf(f, "%s & \\color{%s}%s\\\\\n", text[cur_text_num], color2, text[cur_text_num + 1]); cur_text_num += 2;
        fprintf(f, "\\end{tabular}\n\n");
	
    }

    else if (template[7])
    {
	fprintf(f, "\\begin{tabular}{cc}\n");
        fprintf(f, "\\color{%s}%s &\\color{%s}%s\\\\\n", color4, text[cur_text_num], color4, text[cur_text_num + 1]); cur_text_num += 2;
        fprintf(f, "\\color{%s}%s &\\colorbox{%s}{\\color{%s}%s}\\\\\n", color4, text[cur_text_num], color1, color4, text[cur_text_num + 1]); cur_text_num += 2;
        fprintf(f, "\\end{tabular}\n\n");

    }
}

void yyerror(const char *str)
{
        fprintf(stderr,"error: %s\n",str);
}

int yywrap()
{
        return 1;
}
main()
{
    f = fopen("out.tex", "w");
    if (f == NULL)
    {
        fprintf(stderr, "Не могу открыть файл\n");
        exit(1);
    }
    
    fprintf(f, "\\documentclass{article}\n");
    fprintf(f, "\\usepackage{longtable}\n");
    fprintf(f, "\\usepackage{booktabs}\n");
    fprintf(f, "\\usepackage{multirow, tabularx}\n");
    fprintf(f, "\\usepackage{array}\n");
    fprintf(f, "\\usepackage[usenames]{color}\n");
    fprintf(f, "\\usepackage{colortbl}\n");
    fprintf(f, "\\usepackage[most]{tcolorbox}\n");
    fprintf(f, "\\usepackage{geometry}\n");
	
    fprintf(f, "\\begin{document}\n\n");
    
    
    setlocale(LC_ALL, "ru_RU.UTF-8");
    yyparse();
    fprintf(f, "\\end{document}\n");
}

%}

%union
{
    int number;
    char *string;
}

%token <number> NUMB /* Список токенов. */
%token <string> CHAR
%token <string> OTBL
%token <string> CTBL
%token <string> OTTR
%token <string> CTTR
%token <string> OTTD
%token <string> TTDC
%token <stirng> TTDR
%token <string> CTTD
%token <string> TTHR
%token <string> TTHC
%token <string> CTTH

%token <string> OSTL
%token <string> CSTL
%token <string> GRID
%token <string> DOCL
%token <string> TBID
%token <string> TBTR
%token <string> TDFG
%token <string> TDID
%token <string> TDCL
%token <string> TDST
%token <string> TLID
%token <string> SPST
%token <string> OSPN

%token <string> TEXT
%token <string> ENOL
%token <string> OTHR

%%
commands: /* Список команд может быть пустым... */
| commands command    //| commands command /* ...или состоять из множества комманд */
;

command:
        f_number
        | f_char
	| f_opentable
	| f_closetable
	| f_opentagtr
	| f_closetagtr
	| f_opentagtd
	| f_tagtdcolspan
	| f_tagtdrowspan
	| f_closetagtd
        | f_tagthrowspan
        | f_tagthcolspan
        | f_closetagth
	| f_openstyle
	| f_closestyle
	| f_gridid
	| f_docclass
	| f_tableid
	| f_tabletr
	| f_tdfg
	| f_tdid
	| f_tdclass
	| f_tdstyle
	| f_tablelid
	| f_spanstyle
	| f_openspan
	| f_text
	| f_endofline
	| f_other
;

f_number:
        NUMB
        {
            //D[i] = yylval.string;
            //i++;//printf("%s", yylval.string);
        }
;

f_char: 
        CHAR
	{
	    //printf("CHAR\n");
	    //printf("%s\n", yylval.string);
	}
;

f_opentable:
        OTBL
	{
	    printf("OTBL\n");
	    printf("%s\n", yylval.string);
	    push(yylval.string);
	    npush("table");
	}
;

f_closetable:
        CTBL
	{
	    printf("CTBL\n");
	    printf("%s\n", yylval.string);
	    push(yylval.string);
	    npush("table");
	    
	    int tags = count();
	    printf("tags %d\n", tags);
	    if ((tags % (tags / 2)) != 0)
	    {
		printf("Незакрытый тег\n");
		//return -1;
	    }

   
	    
	    //запоминание
	    int j = 0;
	    int key = 0;

	    char t1[100][100] = {};
	    char t2[100][100] = {};
	    
	    **t1 = '\0';
	    **t2 = '\0';
	    
	    for (j = 0; j < tags; j++)
	    {
		if (j == (tags / 2)) key++;
		if (!key)
		{
		    char *temp1;
		    temp1 = pop();
		    strcat(t1[j], temp1);
		    *temp1 = '\0';
		}
		if (key)
		{
		    char *temp2;
		    temp2 = pop();
		    strcat(t2[j], temp2);
		    *temp2 = '\0';
		}
	    }

	    char nt1[100][100] = {};
	    char nt2[100][100] = {};

	    **nt1 = '\0';
	    **nt2 = '\0';

	    //вложенность и корректность
	    /*key = 0;
	    j = 0;
	    for (j = 0; j < tags; j++)
            {
                if (j == (tags / 2)) key++;
                if (!key)
                {
                    char *ntemp1;
                    ntemp1 = npop();
                    strcat(nt1[j], ntemp1);
                    *ntemp1 = '\0';
                }
                if (key)
                {
                    char *ntemp2;
                    ntemp2 = npop();
                    strcat(nt2[j], ntemp2);
                    *ntemp2 = '\0';
                }
            }
	    
	    
	    j = 0; int ncur = tags;
	    for (j = 0; j < tags; j++)
	    {
		if (j == (tags / 2)) break;
		ncur -= 1;
		printf("CMP %s %s\n", nt1[j], nt2[ncur]);
		if (strcmp(nt1[j], nt2[ncur]))
		{
		    printf("Неправильно вложенный тег\n");
		    return -1;
		}
		
		} */   

	    //вложенность и корректность 2
	    j = 0; key = 0;
	    for (j = 0; j < tags; j++)
	    {
		char *ntemp1;
		ntemp1 = npop();
		strcat(nt1[j], ntemp1);
		*ntemp1 = '\0';
	    }

	    for (j = 0; j < tags; j++) printf("%s", nt1[j]); printf("\n");
	    
	    for (j = 0; j < tags; j++)
	    {
		if (j == 0) npush(nt1[j]);
		else {
		    if (strcmp(nt1[j], nstack[ntop - 1])) npush(nt1[j]);
		    else npop(); 
		}
	    }
	    
	    if (ntop > 0)
	    {
		printf("Неправильная вложенность тегов\n");
		return -1;
	    }
	    
	    templates();
	    
	    for (j = 0; j < 10; j++) template[j] = 0;

	    //for (j = 0; j < 10; j++) printf("temp %d\n", template[j]);

            for (j = 0; j < text_num; j++) printf("text is: %s\n", text[j]);   
	    
	    /*
	    for (j = (tags - 1); j > 0; j--)
            {
                if (j == (tags / 2)) key++;
                if (!key)
                {
                    printf("%s\n", t2[j]);
                }
                if (key)
                {
                    printf("%s\n", t1[j]);
                }
            }
	    */
	    
	}
;

f_opentagtr:
        OTTR
	{
	    printf("OTTR\n");
	    printf("%s\n", yylval.string);
	    push(yylval.string);
	    npush("tr");
	}
;

f_closetagtr:
        CTTR
        {
            printf("CTTR\n");
	    printf("%s\n", yylval.string);
	    push(yylval.string);
	    npush("tr");
	}
;

f_opentagtd:
        OTTD
        {
	    template[0] = 1;
	    printf("OTTD\n");
	    printf("%s\n", yylval.string);
	    push(yylval.string);
	    npush("td");
	}
;

f_tagtdcolspan:
        TTDC
        {
	    template[1] = 1;
	    int l = 0;
	    while (yylval.string[l])
	    {
		if (yylval.string[l] == '"')
		{
		    char this = yylval.string[l + 1];
		    tdnum = (this - '0');
		    break;
		}
		l++;
	    }
            printf("TTDC\n");
	    printf("%s\n", yylval.string);
	    push(yylval.string);
	    npush("td");
	}
;

f_tagtdrowspan:
        TTDR
        {
	    template[2] = 1;
	    int l = 0;
            while (yylval.string[l])
            {
                if (yylval.string[l] == '"')
                {
                    char this = yylval.string[l + 1];
                    trnum = (this - '0');
                    break;
                }
                l++;
            }
            printf("TTDR\n");
	    printf("%s\n", yylval.string);
	    push(yylval.string);
	    npush("td");
	}
;

f_closetagtd:
        CTTD
	{
	    printf("CTTD\n");
	    printf("%s\n", yylval.string);
	    push(yylval.string);
	    npush("td");
	}
;

f_tagthrowspan:
        TTHR
        {
	    template[3] = 1;
	    int l = 0;
            while (yylval.string[l])
            {
                if (yylval.string[l] == '"')
                {
                    char this = yylval.string[l + 1];
                    thnum1 = (this - '0');
                    break;
                }
                l++;
            }
	    printf("TTHR\n");
	    printf("%s\n", yylval.string);
	    push(yylval.string);
	    npush("th");
	}
;

f_tagthcolspan:
        TTHC
	{
	    template[4] = 1;
	    int l = 0;
            while (yylval.string[l])
            {
                if (yylval.string[l] == '"')
                {
                    char this = yylval.string[l + 1];
                    thnum2 = (this - '0');
                    break;
                }
                l++;
            }
	    printf("TTHC\n");
	    printf("%s\n", yylval.string);
	    push(yylval.string);
	    npush("th");
	}
;

f_closetagth:
        CTTH
	{
	    printf("CTTH\n");
	    printf("%s\n", yylval.string);
	    push(yylval.string);
	    npush("th");
	}
;

f_openstyle:
       OSTL
       {
	   ////////////////////////////////////////////////////////////////
	   printf("OSTL\n");
	   printf("%s\n", yylval.string);
       }
;

f_closestyle:
       CSTL
       {
           printf("CSTL\n");
           printf("%s\n", yylval.string);
       }
;

f_gridid:
       GRID
       {
           printf("GRID\n");
           printf("%s\n", yylval.string);
       }
;

f_docclass:
       DOCL
       {
           printf("DOCL\n");
           printf("%s\n", yylval.string);
       }
;

f_tableid:
       TBID
       {
           printf("TBID\n");
           printf("%s\n", yylval.string);
       }
;

f_tabletr:
       TBTR
       {
           printf("TBTR\n");
           printf("%s\n", yylval.string);
       }
;

f_tdfg:
       TDFG
       {
           printf("TDFG\n");
           printf("%s\n", yylval.string);
       }
;

f_tdid:
       TDID
       {
	   template[5] = 1;
           printf("TDID\n");
           printf("%s\n", yylval.string);
       }
;

f_tdclass:
       TDCL
       {
           printf("TDCL\n");
           printf("%s\n", yylval.string);
       }
;

f_tdstyle:
       TDST
       {
	   template[6] = 1;
           printf("TDST\n");
           printf("%s\n", yylval.string);
	   push(yylval.string);
	   npush("td");
       }
;

f_tablelid:
       TLID
       {
           printf("TLID\n");
           printf("%s\n", yylval.string);
           push(yylval.string);
           npush("table");
           //npush("span");
           //npush("span");
       }
;

f_spanstyle:
       SPST
       {
	   template[7] = 1;
           printf("SPST\n");
           printf("%s\n", yylval.string);
	   //push(yylval.string);
           //npush("span");
	   //npush("span");
	   //npush("span");
       }
;

f_openspan:
       OSPN
       {
           printf("OSPN\n");
           printf("%s\n", yylval.string);
           //push(yylval.string);
           //npush("span");
           //npush("span");
       }
;


f_text:
        TEXT
	{
	    //printf("TEXT\n");
	    //printf("%s\n", yylval.string);
	    //push(yylval.string);
	    strcat(text[text_num], yylval.string); text_num++;
	}
;

f_endofline:
        ENOL
	{
	    //printf("");
	    //printf("%s\n", yylval.string);
	}
;

f_other:
        OTHR
        {
            printf("");
            //printf("%s\n", yylval.string);
        }
;
