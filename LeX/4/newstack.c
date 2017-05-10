#include <stdio.h>
#include <string.h>

#define nMAXSIZE 256

char nstack[nMAXSIZE][nMAXSIZE / 2];     
int ntop = 0;            
int np = 0;

int nisempty() {
    if (ntop == 0) return 1;
    else return 0;
}
   
int nisfull() {
   if (ntop == nMAXSIZE) return 1;
   else return 0;
}

char *npop() {
    char *ndata;
    if(!nisempty()) {
	ndata = nstack[ntop - 1];
	//printf("stA %s\n", ndata);
	ntop--;   
	return ndata;
    } else {
	printf("Could not retrieve data, Stack is empty.\n");
    }
}

void npush(char *ndata) {
    if(!nisfull()) {
	//strcat(nstack[ntop], "");
	*nstack[ntop] = '\0';
	strcat(nstack[ntop], ndata);
	//printf("stack %s\n", nstack[top]);
	ntop++;
    } else {
	printf("Could not insert data, Stack is full.\n");
    }
}

void ndisplay() {
    if(!nisempty()) {
	for (np = 0; np <= ntop; np++)
	    printf("display %s\n", nstack[np]);
    }
}

int ncount() {
    if(!nisempty()) return(ntop);
    else return 0;
}
