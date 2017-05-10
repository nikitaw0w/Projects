#include <stdio.h>
#include <string.h>
#include <locale.h>
#include <stdlib.h>

char info[1000][1000];
int sizeof_info = 0;

void par()
{
    FILE *p_file;
    char new_word[1000] = "";
    //char info[100][100];
    int current = 0;
    p_file = fopen("newexample_test", "r");
    if (!p_file) printf("Error to open file\n");
    while (!feof(p_file))
    {	
	fgets(new_word, sizeof(new_word), p_file);
	strcat(info[current], new_word);
	//printf("info %s\n", info[current]);
	current++;
	sizeof_info++;
    }
}
