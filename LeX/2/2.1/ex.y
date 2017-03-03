/**
 * Программа транспонирования календаря 2.y
 *
 * Copyright (c) 2017, Bazhenov Nikita <bazhenov@cs.karelia.ru>
 *
 * This code is licensed under a MIT-style license.
 *
 * Usage:
 * $ cal 11 1337 | ./a.out
 */

%{
#include <stdio.h>
#include <string.h>
#include <locale.h>

int i = 0;
int sym = 0;
int tr = 0;
int c = 0;
int j,k = 0;
int isdate = 0;
const char *A[7][7] = {"Пн ", "Вт ", "Ср ", "Чт ", "Пт ", "Сб ", "Вс "};
int D[6][7];

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
        setlocale(LC_ALL, "ru_RU.UTF-8");
        yyparse();
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
            if (isdate == 0) printf("%d", yylval.number);
            if (isdate != 0) {
                tr = 1;
                D[i][j] = yylval.number;
                j++;
            }
        }
;

f_char:
       CHAR
       {
           if (isdate == 1) {
               printf("");
           }
       }
;

f_endofline:
       ENOL
       {
           if (isdate < 2) {
               if (isdate == 0) printf("\n");
               else printf("");
               isdate++;
           } else {
               j = 0;
               i++;
               if (i == 6) {
                   for (k = 0; k < 7; k++) {
                       for (j = 0; j < 6; j++) {
                           if (j == 0) printf("%s", A[j][k]);
                           if (!D[j][k]) printf("   ");
                           else if (D[j][k] && D[j][k] < 10) printf("%d  ", D[j][k]);
                           else if (D[j][k] >= 10) printf("%d ", D[j][k]);
                           else printf("  ");
                       }
                       printf("\n");
                   }
               }
           }
       }
;

f_spacetab:
      STAB
      {
          if (isdate == 0) printf("%s", yylval.string);
          if (isdate == 2 && tr == 0) {
              c++;
              if (c % 3 == 2) {
                  D[i][j] = 0;
                  j++;
              }
          }
      }

f_other:
      OTHR
      {
          if (isdate != 0) printf("");
          else printf("%s", yylval.string);
      }
;
%%
