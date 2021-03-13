%{
#include<stdio.h>

extern int yyin;
extern char* tempString;

int yylex();
void yyerror(char* error);
%}

%start entry
%token STRING
%token INT
%token SLASH

%%

entry :		entry newEntry
			| /* Lambda */

newEntry :		STRING {printf("Course name : %s\n", tempString);} INT INT SLASH INT	
			
%%

int main(){
	yyin = (int) fopen("input.txt", "r");
	yyparse();
	return 0;
}

void yyerror(char* error){
	printf("Error : %s\n", error);
}