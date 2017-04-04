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
#include "mystack.c"
    
int i = 0;
int tr = 0;
int c = 0;
int j,k = 0;
int isuse = 0; //подключ. библиотеки
int isbracket = 0;
char D[100] = "";
char table[500];
char tl[50][50];
char sym[500];
char text[300][300];
int textcount = 0;

int extable[3] = {0, 0, 0};

char *tag1 = "<table>";
char *tag2 = "<td>";
char *tag3 = "<tr>";
char *tag4 = "<th>";

int t1 = 0;
int t2 = 0;
int t3 = 0;
int t4 = 0;

int y = 0;
int z = 0;

int tagcount = 0;

FILE *f;

void yyerror(const char *str)
{
        fprintf(stderr,"error: %s\n",str);
}
 
int yywrap()
{
        return 1;
} 

void func(int a);
void check_tag();
void transform();
void symtotext();

void func(int a)
{
    if (a == 1)
    {
	if (strcmp(D, "<table>") == 0 || strcmp(D, "</table>") == 0)
	{
	    strcat(tl[tagcount], D);
	    printf("tagcount %s\n", tl[tagcount]);
	    tagcount++;
	    strcat(table, D);
	    t1++;
	    if (t1 % 2 == 0)
	    {
		printf("%s\n", table);
		check_tag();
		for (i = 0; i < tagcount; i++) *tl[i] = '\0';
		tagcount = 0;
		for (i = 0; i < z; i++) *text[i] = '\0';
		*sym = '\0';
		y = 0;
		z = 0;
		t1 = 0;
		t2 = 0;
		t3 = 0;
		t4 = 0;
		for (i = 0; i < 3; i++) extable[i] = 0;
		//text = '\0';
	    }
	}
	else if (strcmp(D, "<tr>") == 0 || strcmp(D, "</tr>") == 0)
	{
	    strcat(tl[tagcount], D);
	    printf("tagcount %s\n", tl[tagcount]);
	    tagcount++;
	    strcat(table, D);
	    t2++;
	}
	else if (strcmp(D, "<td>") == 0 || strcmp(D, "</td>") == 0)
        {
	    strcat(tl[tagcount], D);
	    printf("tagcount %s\n", tl[tagcount]);
	    tagcount++;
            strcat(table, D);
            t3++;
        }
	else if (strcmp(D, "<th>") == 0 || strcmp(D, "</th>") == 0)
        {
	    strcat(tl[tagcount], D);
	    printf("tagcount %s\n", tl[tagcount]);	    
	    tagcount++;
            strcat(table, D);
            t4++;
	}
	else if (strcmp(D, "<tdcolspan2>") == 0)
        {
	    extable[0] = 1;
            strcat(tl[tagcount], "<td>");
            printf("tagcount %s\n", tl[tagcount]);
            tagcount++;
            strcat(table, D);
            t3++;
	}
	else if (strcmp(D, "<tdrowspan2>") == 0)
        {
	    extable[1] = 1;
            strcat(tl[tagcount], "<td>");
            printf("tagcount %s\n", tl[tagcount]);
            tagcount++;
            strcat(table, D);
            t3++;
        }
	else if (strcmp(D, "<thcolspan2>") == 0)
        {
	    extable[2] = 1;
            strcat(tl[tagcount], "<th>");
            printf("tagcount %s\n", tl[tagcount]);
            tagcount++;
            strcat(table, D);
            t4++;
        }
	else if (strcmp(D, "<throwspan2>") == 0)
        {
	    extable[2] = 1;
            strcat(tl[tagcount], "<th>");
            printf("tagcount %s\n", tl[tagcount]);
            tagcount++;
            strcat(table, D);
            t4++;
        } else {
	    fprintf(stderr, "Неподдерживаемый тег %s\n", D);
	    exit(1);
	}
    }
}

void check_tag()
{
    char curm[100] = "";
    int k = 0;
    if (t1 % 2 != 0)
    {
	fprintf(stderr, "Незакрытый тег <table>\n");
    }
    if (t2 % 2 != 0)
    {
	fprintf(stderr, "Незакрытый тег <tr>\n");
    }
    if (t3 % 2 != 0)
    {
	fprintf(stderr, "Незакрытый тег <td>\n");
    }
    if (t4 % 2 != 0)
    {
	fprintf(stderr, "Незакрытый тег <th>\n");
    }
    i = 0;
   
    if (strcmp(tl[i], "<table>")
	|| strcmp(tl[i + 1], "<tr>")
	|| (strcmp(tl[i + 2], "<td>")
	    && strcmp(tl[i + 2], "<th>")))
    {
	fprintf(stderr, "Неправильный порядок тегов\n");
	exit(1);
    }
	
    for (i = 0; i < tagcount; i++)
    {
	//printf("tl %s\n", tl[i]);
	if (tl[i][1] == '/')
	{
	    while (tl[i][k])
	    {
		if (k == 0)
		{
		    curm[k] = tl[i][k];
		    //printf("%c\n", curm[k]);
		}
		if (k > 1)
		{
		    curm[k - 1] = tl[i][k];
		    //printf("%c\n", curm[k - 1]);
		}
		k++;
	    }
	    //display();
	    char *pop_from_stack = pop();
	    //display();
	    printf("pop %s %s\n", curm, pop_from_stack); 
	    if (strcmp(pop_from_stack, curm) != 0)
	    {
		fprintf(stderr, "Неправильная вложенность тегов\n");
		exit(1);
	    } else {
		*curm = '\0';
		*pop_from_stack = '\0';
		k = 0;
		printf("THE COMPARING IS COMPLETE\n");
	    }
	} else push(tl[i]);
    }
    i = 0;
    transform();
}

void transform()
{
    fprintf(f, "\\begin{tabular}{");

    if (!extable[2]) {
	for (i = 0; i < t2; i += 2)
	{
	    fprintf(f, "c");
	}
	fprintf(f, "}\n");
    }
    
    symtotext();

    if (!extable[0] && !extable[1] && !extable[2])
    {
	//for (i = 0; i < z; i++) printf("%s\n", text[i]);
	
	i = 0;
	for (i = 0; i < z; i++)
	{
	    if (i % 2 == 0)
	    {
		fprintf(f, "%s", text[i]);
		//fprintf(f, " &");
	    }
	    if (i % 2 == 1)
	    {
		fprintf(f, " &", text[i]);
		fprintf(f, "%s", text[i]);
		fprintf(f, "\\\\\n"); // => \\ + \n
	    }
	}
	if (i % 2 == 1) fprintf(f, "\\\\\n");
    }
    else if (extable[0])
    {
	i = 0;
	fprintf(f, "\\multicolumn{2}{l}{");
	fprintf(f, "%s", text[i]);
	fprintf(f, "}\\\\\n"); // => } + \\ + \n
	fprintf(f, "%s", text[i + 1]);
	fprintf(f, " &", text[i]);
	fprintf(f, "%s", text[i + 2]);
	fprintf(f, "\\\\\n");
    }
    else if (extable[1])
    {
        i = 0;
        fprintf(f, "\\multirow{2}{*}{");
        fprintf(f, "%s", text[i]);
        fprintf(f, "}&%s", text[i + 1]);
        fprintf(f, "\\\\\n");
        fprintf(f, "&%s", text[i + 2]);
        fprintf(f, "\\\\\n");
    }
    else if (extable[2])
    {
	for (i = 0; i < (t2 + 1); i += 2)
        {
            fprintf(f, "c");
        }
	fprintf(f, "}\n");

        i = 0;
        fprintf(f, "\\multirow{2}{*}{");
        fprintf(f, "\\textbf{%s}", text[i]);
        fprintf(f, "}&\\multicolumn{2}{c}{");
	fprintf(f, "\\textbf{%s}}", text[i + 1]);
        fprintf(f, "\\\\\n");
        fprintf(f, "&%s", text[i + 2]);
	fprintf(f, " &%s", text[i + 3]);
        fprintf(f, "\\\\\n");
    }


    
	fprintf(f, "\\end{tabular}\n\n");
	//fprintf(f, "\\end{document}\n");
    
	//*tl[i] = '\0';
	printf("THE TRANSFORMING IS COMPLETE\n");
}

void symtotext()
{
    i = 0;
    z = 0;
    y = 0;
    while (sym[i])
    {
	text[z][y] = sym[i];
	y++;
	i++;
	if (sym[i] == ' ')
	{
	    z++;
	    y = 0;
	}
    }
}

main()
{
    f = fopen("output.txt", "w");
    if (f == NULL)
    {
	fprintf(stderr, "Не могу открыть файл\n");
	exit(1);
    }
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
%token <string> ENOL
%token <string> STAB
%token <string> OTHR

%%
commands: /* Список команд может быть пустым... */
| commands command    //| commands command /* ...или состоять из множества комманд */
;

command:
        f_number
	| f_char
	| f_endofline
	| f_spacetab
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
	   strcat(D, yylval.string);
       }
;

f_endofline:
       ENOL
       {
	   if (isuse == 0)
	   {
	       fprintf(f, "\\documentclass{article}\n");
	       fprintf(f, "\\usepackage{longtable}\n");
	       fprintf(f, "\\usepackage{booktabs}\n");
	       fprintf(f, "\\usepackage{multirow, tabularx}\n");
	       fprintf(f, "\\usepackage{array}\n\n");
	       fprintf(f, "\\begin{document}\n\n");
	       isuse++;
	   } else if (isuse == 1) {
	       //printf("%s", D);
	       //*D = '\0';
	       
	       //printf("\n");
	   }
	   else ;//printf("\n");
       }
;

f_spacetab:
       STAB
       {
	   //printf("%s", yylval.string);
       }

f_other:
       OTHR
       {
	   if (isuse == 0)
           {
               fprintf(f, "\\documentclass{article}\n");
               fprintf(f, "\\usepackage{longtable}\n");
               fprintf(f, "\\usepackage{booktabs}\n");
               fprintf(f, "\\usepackage{multirow, tabularx}\n");
               fprintf(f, "\\usepackage{array}\n\n");
               fprintf(f, "\\begin{document}\n\n");
               isuse++;
	   }
	   if (isbracket == 0)
	   {
	       if (strcmp(D, "") != 0)
	       {
		   strcat(sym, D);
		   strcat(sym, " ");
	       }
	       *D = '\0';
	   }
	   strcat(D, yylval.string);
	   isbracket++;
	   if (isbracket == 2)
	   {
	       func(1);
	       *D = '\0';
	       isbracket = 0;
	   }
       }
;
%%
