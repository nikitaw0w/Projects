#include <stdio.h>
#include <string.h>

#define MAXSIZE 128

char stack[MAXSIZE][MAXSIZE / 2];     
int top = 0;            
int p = 0;

int isempty() {
    //return top;
    
    if(top == 0)
	return 1;
    else
	return 0;
}
   
int isfull() {

   if(top == MAXSIZE)
      return 1;
   else
      return 0;
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

/*void push(char data) {

   if(!isfull()) {
      top += 1;   
      stack[top] = data;
   } else {
      printf("Could not insert data, Stack is full.\n");
   }
   }*/

void push(char *data) {
    if(!isfull()) {
	strcat(stack[top], data);
	printf("stack %s\n", stack[top]);
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

/*int main() {
    push("<td>");
    push("<td>");

    push("<tr>");

    char *xyu = pop();
    
    printf("xyu %s\n", xyu);
    xyu = pop();
    printf("xyu %s\n", xyu);
    xyu = pop();
    printf("xyu %s\n", xyu);

    
    push("aishdsa");

    char da[10][10];

    strcat(da[3], "PWD");
    strcat(da[7], "ASD");
    push(da[3]);
    push(da[7]); 
    
    display();
    
   return 0;
   }

*/
