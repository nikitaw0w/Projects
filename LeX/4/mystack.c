#include <stdio.h>
#include <string.h>

#define MAXSIZE 128

char stack[MAXSIZE][MAXSIZE / 2];     
int top = 0;            
int p = 0;

int isempty() {
    if (top == 0) return 1;
    else return 0;
}
   
int isfull() {
   if(top == MAXSIZE) return 1;
   else return 0;
}

char *pop() {
    char *data;
    if(!isempty()) {
	data = stack[top - 1];
	//printf("stA %s\n", stack[top - 1]);
	top--;   
	return data;
    } else {
	printf("Could not retrieve data, Stack is empty.\n");
    }
}

void push(char *data) {
    if(!isfull()) {
	*stack[top] = '\0';
	strcat(stack[top], data);
	//printf("stack %s\n", stack[top]);
	top++;
    } else {
	printf("Could not insert data, Stack is full.\n");
    }
}

void display() {
    if(!isempty()) {
	for (p = 0; p < top; p++)
	    printf("display %s\n", stack[p]);
    }
}

int count() {
    if(!isempty()) return(top);
    else return 0;
}
