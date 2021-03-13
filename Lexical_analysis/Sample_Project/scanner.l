%{
#include <stdlib.h>
#include <string.h>

#define INTEGER 100
#define STRING 101
%}

%%

[ \t\n]+	;

"/"		;


[1-9][0-9]*|0	{
	printf("Found integer : %d\n", atoi(yytext));
	return INTEGER;
}

\"[^"]*\"	{
	char* string = (char*) malloc(strlen(yytext - 1));
	strcpy(string, yytext + 1);
	string[strlen(string) - 1] = 0;
	printf("Found string : %s\n", string);
	return STRING;
}

[^ \t\n\/]+		{
	printf("Error on : %s\n", yytext);
}

%%

int yywrap(){
	return 1;
}

int main(){
	yyin = fopen("input.txt", "r");
	while(yylex());
	return 0;
}