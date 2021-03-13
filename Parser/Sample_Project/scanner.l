%{
#include "parser.tab.h"
#include <stdlib.h>
#include <string.h>

char* tempString;
%}

%%

[ \t\n]+	;

"/"		{return SLASH;}


[1-9][0-9]*|0	{return INT;}

\"[^"]*\"	{
	free(tempString);
	tempString = (char*) malloc(strlen(yytext - 1));
	strcpy(tempString, yytext + 1);
	tempString[strlen(tempString) - 1] = 0;
	return STRING;
}

[^ \t\n\/]+		{
	printf("Error on : %s\n", yytext);
	return 0;
}

%%

int yywrap(){
	return 1;
}