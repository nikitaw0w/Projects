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
#include "par.c"

#define HUN 100
    
int i = 0;
FILE *f;
char D[1000] = "";
char mSQL[1000] = "";

char brobject[100] = "empty()";
int err_sig = 0;

void modifyword(char *w);

int find(char *findword)
{
    FILE * infile;
    int st = 0;
    char word[1000];
    infile = fopen ("example_test" , "r");
    if (infile == NULL) perror ("Error opening file");
    else {    
	while (!feof(infile))
	{
	    fscanf(infile, "%s", word);
	    modifyword(word);
	    if (!strcmp(word, findword))
            { 
		printf("Найдено %s\n", word);
		st++;
		return 0;
            } 
	} 
	if (st == 0) printf("Не найдено %s\n", word);
	fclose(infile);
    }
}

void modifyword(char* w)
{   // все кроме букв убираем в конце слова 
    int i = strlen(w), st = 0;
    char *ch = w;
    while(i)
    {
        if(isalpha(*(w + i)))
            break;
        i--;
    }
    *(w + i + 1) = '\0'; 
    ////////////////////////////////////////
    // все кроме букв убираем в начале слова 
    while(*w)
    {
        if(isalpha(*w)) st = 1;
        if(st)
	    *(ch++) = *w ;
	w++;
    }
    *ch = '\0'; 
}

int selecting(char *s1, char c1, char *s2, char c2, char *s3, char c3)
{
    
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
    par();
    f = fopen("output.txt", "w");
    if (f == NULL)
    {
        fprintf(stderr, "Не могу открыть файл\n");
        exit(1);
    }
    setlocale(LC_ALL, "ru_RU.UTF-8");
    yyparse();
    //fprintf(f, "\\end{document}\n");

}

%}

%union
{
    int number;
    char *string;
}

%token <number> NUMB /* Список токенов. */
%token <string> CHAR
%token <string> FNAM
%token <string> GRD1
%token <string> GRD2
%token <string> GRD3
%token <string> GRD4
%token <stirng> BRCK
%token <string> GRD5
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
	| f_fnam
	| f_grd1
	| f_grd2
	| f_grd3
	| f_grd4
	| f_brck
	| f_grd5
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
	    printf("CHAR\n");

	    *D = '\0';
	    *mSQL = '\0';

	    strcat(D, yylval.string);
	    printf("%s\n", D);

	    
	    strcat(mSQL, "select * from ");	    
	    strcat(mSQL, D);
	    
	    printf("%s\n", mSQL);

	    find(D);
	}
;

f_fnam:
        FNAM
	{
	    printf("FNAM\n");

	    *D = '\0';
	    *mSQL = '\0';
	    i = 0;
	    char temp1[HUN] = "";
	    char temp2[HUN] = "";
	    int key = 0;
	    int cur = 0;
	    
	    strcat(D, yylval.string);
            printf("%s\n", D);

	    strcat(mSQL, "select ");

	    while (D[i])
	    {
		if (D[i] == '[') key++;
		else if (D[i] == ']') ;
		else if (key == 0) temp1[i] = D[i];
		else if (key == 1) { temp2[cur] = D[i]; cur++; }
		i++;
	    }
	    
	    strcat(mSQL, temp2);
	    strcat(mSQL, " from ");
	    strcat(mSQL, temp1);
	    
	    printf("%s\n", mSQL);

	    find(temp1);
	}
;

f_grd1:
        GRD1
	{
	    printf("GRD1\n");

	    *D = '\0';
	    *mSQL = '\0';
	    i = 0;
	    char temp1[HUN] = "";
            char temp2[HUN] = "";
            int key = 0;
            int cur = 0;
	    
	    strcat(D, yylval.string);
            printf("%s\n", D);

	    strcat(mSQL, "select * from ");

	    while (D[i])
	    {
		if (D[i] == '#' || D[i] == '(') key = 1;
		else if (D[i] == ')') ;
		else if (key == 0) { temp1[i] = D[i]; }
		else if (key == 1) { temp2[cur] = D[i]; cur++; }
		i++;
	    }
	    
	    strcat(mSQL, temp1);
	    strcat(mSQL, " where ");
	    strcat(mSQL, temp2);

	    printf("%s\n", mSQL);

	    find(temp1);
	}
;

f_grd2:
        GRD2
        {
            printf("GRD2\n");

            *D = '\0';
            *mSQL = '\0';
            i = 0;
            char temp1[HUN] = "";
            char temp2[HUN] = "";
	    char temp3[HUN] = "";
	    char temp4[HUN] = "";
            int key = 0;
            //int cur1 = 0;
	    int cur2 = 0;
	    int cur3 = 0;
	    int cur4 = 0;
	    
            strcat(D, yylval.string);
            printf("%s\n", D);

            strcat(mSQL, "select * from ");

            while (D[i])
            {
                if (D[i] == '#') { key++; i++; }
		else if (D[i] == '(') { key++;  }
                else if (D[i] == ')' || D[i] == ' ' || D[i] == '&') key = 4;
		else if (D[i] == '|') { key++; i++; } 
                else if (key == 0) temp1[i] = D[i];
		else if (key == 1) { temp2[cur2] = D[i]; cur2++; temp3[cur3] = D[i]; cur3++; }
		else if (key == 2) { temp2[cur2] = D[i]; cur2++; }
	        else if (key == 3) { temp3[cur3] = D[i]; cur3++; }
		else if (key == 4) { temp4[cur4] = D[i]; cur4++; }
                i++;
            }

            strcat(mSQL, temp1);
            strcat(mSQL, " where ");
            strcat(mSQL, temp2);
	    strcat(mSQL, " or ");
	    strcat(mSQL, temp3);
	    strcat(mSQL, " and ");
	    strcat(mSQL, temp4);

            printf("%s\n", mSQL);

	    find(temp1);
	}
;

f_grd3:
        GRD3
        {
            printf("GRD3\n");

            *D = '\0';
            *mSQL = '\0';
            i = 0;
            char temp1[HUN] = "";
            char temp2[HUN] = "";
            char temp3[HUN] = "";
            char temp4[HUN] = "";
            int key = 0;
            //int cur1 = 0;
            int cur2 = 0;
            int cur3 = 0;
            int cur4 = 0;

            strcat(D, yylval.string);
            printf("%s\n", D);
	    
            strcat(mSQL, "select * from ");

            while (D[i])
            {
                if (D[i] == '#') { key++; i++; }
                else if (D[i] == ')' || D[i] == ' ' && key != 2) ;
		else if (D[i] == '"') { temp3[cur3] = '\''; cur3++; }
		else if (D[i] == '&') { key++; i += 2; }
                else if (key == 0) temp1[i] = D[i];
                else if (key == 1) { temp2[cur2] = D[i]; cur2++; }
                else if (key == 2) { temp3[cur3] = D[i]; cur3++; }
                i++;
            }

            strcat(mSQL, temp1);
            strcat(mSQL, " where ");
            strcat(mSQL, temp2);
            strcat(mSQL, " and ");
            strcat(mSQL, temp3);

	    printf("%s\n", mSQL);

	    find(temp1);
        }
;

f_grd4:
        GRD4
        {
            printf("GRD4\n");

            *D = '\0';
            *mSQL = '\0';
            i = 0;
            char temp1[HUN] = "";
            char temp2[HUN] = "";
            char temp3[HUN] = "";
            char temp4[HUN] = "";
            int key = 0;
            //int cur1 = 0;
            int cur2 = 0;
            int cur3 = 0;
            int cur4 = 0;

            strcat(D, yylval.string);
            printf("%s\n", D);

            strcat(mSQL, "select * from ");

            while (D[i])
            {
                if (D[i] == '#') { key++; i++; temp2[cur2] = '('; cur2++; }
                else if (D[i] == '(') key++; 
		else if (D[i] == '&') { key++; i += 2; }
		else if (D[i] == '|') { key++; i += 2; }
		else if (D[i] == ')') ;
		else if (D[i] == ' ') ;
                else if (key == 0) temp1[i] = D[i];
                else if (key == 1) { temp2[cur2] = D[i]; cur2++; temp3[cur3] = D[i]; cur3++; temp4[cur4] = D[i]; cur4++; }
                else if (key == 2) { temp2[cur2] = D[i]; cur2++; }
                else if (key == 3) { temp3[cur3] = D[i]; cur3++; }
                else if (key == 4) { temp4[cur4] = D[i]; cur4++; }
                i++;
            }

            strcat(mSQL, temp1);
            strcat(mSQL, " where ");
            strcat(mSQL, temp2);
            strcat(mSQL, " and ");
            strcat(mSQL, temp3);
            strcat(mSQL, ") or ");
            strcat(mSQL, temp4);
	    
	    printf("%s\n", mSQL);
	    find(temp1);
	}
;

f_brck:
        BRCK
        {
            printf("BRCK\n");
	    
	    *D = '\0';
            *mSQL = '\0';
            i = 0;
            char temp1[HUN] = "";
            char temp2[HUN] = "";
            char temp3[HUN] = "";
            char temp4[HUN] = "";
            int key = 0;
            //int cur1 = 0;
            int cur2 = 0;
            int cur3 = 0;
            int cur4 = 0;

            strcat(D, yylval.string);
            printf("%s\n", D);

	    char ftemp1[HUN] = "";
	    char ftemp2[HUN] = "";
	    int fcur = 0;
	    int fkey = 0;
	    
	    while(D[i])
	    {
		if (D[i] == '(') fkey++;
		else if (D[i] == ')' || D[i] == ' ') ;
		else if (fkey == 0) ftemp1[i] = D[i];
		else if (fkey == 1) { ftemp2[fcur] = D[i]; fcur++; }
		i++;
	    }

	    strcat(ftemp1, " {");
	    strcat(ftemp2, ": [");

	    int while_key = 0;
	    char cur_info[HUN * 3] = "";
	    i = 0;
	    
	    for (i = 0; i < sizeof_info; i++) 
	    {
		if (!while_key) if (strstr(info[i], ftemp1)) { printf("Найдено %s\n", ftemp1); while_key++; }
		if (while_key) {
		    if (strstr(info[i], ftemp2)) {
			printf("Найдено %s\n", ftemp2);
			while_key++;
			strcat(cur_info, info[i]);
			break;
		    }
		    if (!strcmp(info[i], "},\n")) break;
		}
		
	    }

	    if (while_key != 2)
	    {
		printf("Не найдено %s\n", ftemp2);
		if (while_key != 1) printf("Не найдено %s\n", ftemp1);
		err_sig = 1;
		//break;
	    }
	    
	    char fclass[100] = "";
	    while_key = 0;
	    i = 0;
	    fcur = 0;
	    while (cur_info[i])
	    {
		if (cur_info[i] == '[') while_key++;
		else if (cur_info[i] == ']' || cur_info[i] == ',' || cur_info[i] == '\n') ;
		else if (while_key) { fclass[fcur] = cur_info[i]; fcur++; }
		i++;
	    }

	    strcat(D, " ");
	    strcat(D, fclass);
	    

	    printf("D %s\n", D);

            strcat(mSQL, "select * from ");

	    i = 0;
            while (D[i])
            {
                if (D[i] == '(') key++; 
		else if (D[i] == ' ') ;
                else if (D[i] == ')') key++ ;
                else if (key == 0) temp1[i] = D[i];
                else if (key == 1) { temp2[cur2] = D[i]; cur2++; }
                else if (key == 2) { temp3[cur3] = D[i]; cur3++; }
                i++;
            }

	    if (err_sig == 0) {
	    *brobject = '\0';
	    strcat(brobject, temp3);
	    }

	    if (err_sig == 1) {
		*temp3 = '\0';
		strcat(temp3, "empty()");
	    }
	    
	    snprintf(mSQL, sizeof(mSQL), "select * from %s as %c join %s as %c on %c.id=%c.%s_id join %s as %c on %c.id=%c.%s_id",
		     temp1, temp1[0], temp3, temp3[0], temp1[0], temp3[0], temp1, temp2, temp2[0], temp3[0], temp2[0], temp3);
	    
	    printf("%s\n", mSQL);
	    
        }
;

f_grd5:
        GRD5
	{
            printf("GRD5\n");
	    
            *D = '\0';
            *mSQL = '\0';
            i = 0;
            char temp1[HUN] = "";
            char temp2[HUN] = "";
            char temp3[HUN] = "";
            char temp4[HUN] = "";
            int key = 0;
            //int cur1 = 0;
            int cur2 = 0;
            int cur3 = 0;
            int cur4 = 0;

            strcat(D, yylval.string);
            printf("%s\n", D);

	    if (err_sig == 1) {
		printf("Ошибка содержащегося объекта\n");
		//break;
	    }
	    
            strcat(mSQL, "select * from ");

            while (D[i])
            {
                if (D[i] == '#') { key++; i++; }
                else if (D[i] == ' ') { key++; i++; }
		else if (D[i] == ')') ;
                else if (key == 0) temp1[i] = D[i];
		else if (key == 1) { temp2[cur2] = D[i]; cur2++; }
                else if (key == 2) { temp3[cur3] = D[i]; cur3++; }
                else if (key == 3) { temp4[cur4] = D[i]; cur4++; }
                i++;
            }
	   
		snprintf(mSQL, sizeof(mSQL), "select * from %s as %c join %s as %c on %c.id=%c.%s_id join %s as %c on %c.id=%c.%s_id where %c.%s and %c.%s",
			 temp1, temp1[0], brobject, brobject[0], temp1[0], brobject[0], temp1, temp3, temp3[0], brobject[0], temp3[0], brobject,
			 temp1[0], temp2, temp3[0], temp4);  

	    printf("%s\n", mSQL);
        }
;

f_endofline:
       ENOL
       {
          
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
	   
       }
