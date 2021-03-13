%{
	#include <stdio.h>
	
	extern FILE *yyin;
	extern int yylineno;
	extern char* yytext;
	
	int yylex(void);
	FILE *fout;

	void yyerror(const char *s);
	
%}

%token	MAIN_KW	PROGRAM_KW WHILE_KW IF_KW SWITCH_KW CASE_KW FOR_KW DEFAULT_KW RETURN_KW	BREAK_KW CONTINUE_KW READ_KW WRITE_KW	
%token ELSE_KW	THEN_KW	INT_KW	CHAR_KW BOOL_KW VOID_KW CALLOUT_KW TRUE FALSE REAL STRING OR_ELSE
%token  Real Integer String Character   LT LE GT GE EQ NE AND OR AND_THEN PLUS MINUS MULT DIV REM SHR SHL NOT ID
 

%%

program : PROGRAM_KW ID '{' field_decl_list  method_decl_list '}'
	{fprintf(fout,"rule 1\t\t program ->PROGRAM_KW ID field_decl_list method_decl_list\n");}
	|  PROGRAM_KW ID '{' field_decl_list '}'
	{fprintf(fout,"rule 1\t\t program ->PROGRAM_KW ID field_decl_list \n");}
	| PROGRAM_KW ID '{'   method_decl_list '}'
	{fprintf(fout,"rule 1\t\t program ->PROGRAM_KW ID  method_decl_list\n");}

field_decl_list: field_decl field_decl_list
	{fprintf(fout,"rule 2\t\t field _decl_list-> field_decl field_decl_list\n");}
		| field_decl	
	{fprintf(fout,"rule 3\t\t field_decl_list -> field_decl\n");}

field_decl : type field_name_list ';'	
	{fprintf(fout,"rule 4\t\t field_decl -> type field_name_list ';' \n");}

field_name_list : field_name ',' field_name_list
	{fprintf(fout,"rule 5\t\t  field_name_list -> field_name ',' field_name_list  \n");}
		| field_name	
		{fprintf(fout,"rule 6\t\t  field_name_list -> field_name \n");}

field_name : ID '['Integer ']'	{fprintf(fout,"rule 7\t\t  field_name -> ID '['Integer ']'  \n");}
		|ID	{fprintf(fout,"rule 8\t\t  field_name -> ID  \n");}

method_decl_list : method_decl method_decl_list	
			{fprintf(fout,"rule 9\t\t method_decl_list -> method_decl method_decl_list	\n");}
		| method_decl	{fprintf(fout,"rule 10\t\t  method_decl_list -> method_decl  \n");}

method_decl : type ID '(' formal_parameter_list ')' block	
		{fprintf(fout,"rule 11\t\t  method_decl -> return_type ID '(' formal_parameter_list ')' block  \n");}
		|VOID_KW ID '(' formal_parameter_list ')' block	
		{fprintf(fout,"rule 11\t\t  method_decl -> return_type ID '(' formal_parameter_list ')' block  \n");}

method_call : ID '(' actual_parameters ')'	{fprintf(fout,"rule 12\t\t  method call -> ID '(' actual_parameters ')'  \n");}
		| CALLOUT_KW '(' String callout_parameters ')'	
			{fprintf(fout,"rule 13\t\t  method call ->CALLOUT_KW '(' String callout_parameters ')'\n");}

actual_parameters : actual_parameters_list
	{fprintf(fout,"rule 14\t\t  actual_parameters -> actual_parameters_list  \n");}
		   | 	{fprintf(fout,"rule 15\t\t  actual_parameters -> lamda  \n");}

actual_parameters_list : expr actual_parameters_list	
	{fprintf(fout,"rule 16\t\t  actual_parameters_list -> expr actual_parameters_list  \n");}
			| expr	{fprintf(fout,"rule 17\t\t  actual_parameters_list -> expr   \n");}
	
callout_parameters : '.' callout_parameters_list	{fprintf(fout,"rule 18\t\t callout_parameters -> '.' callout_parameters_list  \n");}
			|	{fprintf(fout,"rule 19\t\t  callout_parameters : lambda  \n");}

callout_parameters_list : expr callout_parameters_list	{fprintf(fout,"rule 20\t\t callout_parameters_list -> expr callout_parameters_list \n");}
			| expr	{fprintf(fout,"rule 21\t\t callout_parameters_list -> expr  \n");}

formal_parameter_list : argument_list	{fprintf(fout,"rule 22\t\t formal_parameter_list -> argument_list  \n");}
			|	{fprintf(fout,"rule 23\t\t formal_parameter_list -> lambda  \n");}

argument_list : type ID ','argument_list	{fprintf(fout,"rule 24\t\t argument_list -> type ID ','argument_list  \n");}
		| type ID	{fprintf(fout,"rule 25\t\t argument_list -> type ID   \n");}

type :   INT_KW {fprintf(fout,"rule 26\t\t type -> INT_KW \n");}
	| REAL {fprintf(fout,"rule 27\t\t type -> REAL \n");}
	|CHAR_KW	{fprintf(fout,"rule 28\t\t type -> CHAR_KW  \n");}
	|BOOL_KW	{fprintf(fout,"rule 29\t\t type -> BOOL_KW  \n");}


constant : Integer {fprintf(fout,"rule 30\t\t  constant -> Integer \n");}
	| Character {fprintf(fout,"rule 31\t\t constant -> Character  \n");}
	| Real {fprintf(fout,"rule 32\t\t  constant -> Real \n");}
	|TRUE {fprintf(fout,"rule 33\t\t constant -> TRUE  \n");}
	|FALSE {fprintf(fout,"rule 34\t\t constant -> FALSE  \n");}



return_expr : expr {fprintf(fout,"rule 37\t\t  return_expr -> expr \n");}
		|	{fprintf(fout,"rule 38\t\t return_expr -> lambda  \n");}

block : '{' var_decl_list statement_list '}' {fprintf(fout,"rule 39\t\t  block -> '{' var_decl_list statement_list '}'  \n");}

var_decl_list : var_decl var_decl_list {fprintf(fout,"rule 40\t\t  var_decl_list -> var_decl var_decl_list \n");}
		|	{fprintf(fout,"rule 41\t\t var_decl_list -> lambda  \n");}

var_decl : type id_list ';'	{fprintf(fout,"rule 42\t\t var_decl -> type id_list ';'  \n");}

id_list : ID ',' id_list	{fprintf(fout,"rule 43\t\t  id_list -> ID ',' id_list \n");}
	| ID	{fprintf(fout,"rule 44\t\t  id_list -> ID  \n");}


statement_list :  statement statement_list	{fprintf(fout,"rule 45\t\t  statement_list ->  statement statement_list \n");}
		|	{fprintf(fout,"rule 46\t\t statement_list -> lambda  \n");}


statement : assignment ';'	{fprintf(fout,"rule 47\t\t statement -> assignment ';'  \n");}
	|method_call ';'	{fprintf(fout,"rule 48\t\t statement -> method_call ';'  \n");}
	
	|IF_KW '(' expr ')'	THEN_KW block ';'	{fprintf(fout,"rule 49\t\t statement -> IF_KW '(' expr ')'	THEN_KW block ';'  \n");}
	
	|IF_KW '(' expr ')'	THEN_KW block	ELSE_KW block  ';'	{fprintf(fout,"rule 50\t\t statement -> IF_KW '(' expr ')'	THEN_KW block	ELSE_KW block  ';' \n");}
	
	|WHILE_KW '(' expr ')' THEN_KW ';'	{fprintf(fout,"rule 51\t\t  statement -> WHILE_KW '(' expr ')' THEN_KW ';' \n");}
	
	|FOR_KW '(' for_initialize ';'expr ';' assignment ')' block ';'		{fprintf(fout,"rule 52\t\t statement -> FOR_KW '(' for_initialize ';'expr ';' assignment ')' block ';' \n");}
	
	|SWITCH_KW '(' ID ')' '{' case_statement '}' ';'	 {fprintf(fout,"rule 53\t\t statement -> SWITCH_KW '(' ID ')' '{' case_statement '}' ';' \n");}
	
	|RETURN_KW return_expr ';'	{fprintf(fout,"rule 54\t\t statement -> RETURN_KW return_expr ';'  \n");}
	
	|BREAK_KW ';'	{fprintf(fout,"rule 55\t\t statement -> BREAK_KW ';'   \n");}
	
	| CONTINUE_KW ';'	{fprintf(fout,"rule 56\t\t statement -> CONTINUE_KW ';' \n");}
	| block 	{fprintf(fout,"rule 57\t\t statement ->  block  \n");}
	|READ_KW '(' ID ')' ';'		{fprintf(fout,"rule 58\t\t statement -> READ_KW '(' ID ')' ';'	  \n");}
	|WRITE_KW '(' write_parameter ')' ';'	{fprintf(fout,"rule 59\t\t statement ->WRITE_KW '(' write_parameter ')' ';'  \n");}
	| ';'	{fprintf(fout,"rule 60\t\t  statement -> ';'\n");}


case_statement : CASE_KW constant ':' statement case_statement	{fprintf(fout,"rule 61\t\t case_statement -> CASE_KW constant ':' statement case_statements \n");}
		| DEFAULT_KW ':' statement	{fprintf(fout,"rule 62\t\t case_statement -> DEFAULT_KW ':' statement  \n");}
		|	{fprintf(fout,"rule 63\t\t  case_statement ->lambda   \n");}


write_parameter : exp	{fprintf(fout,"rule 64\t\t write_parameter -> expr  \n");}
		|String	{fprintf(fout,"rule 65\t\t write_parameter -> String \n");}

assignment : location '=' exp	{fprintf(fout,"rule 66\t\t assignment -> location '=' expr \n");}
	   | location	{fprintf(fout,"rule 67\t\t assignment -> location \n");}


for_initialize : assignment	{fprintf(fout,"rule 68\t\t for_initialize -> assignment   \n");}
		|	{fprintf(fout,"rule 69\t\t for_initialize -> lambda  \n");}


location : ID	{fprintf(fout,"rule 70\t\t  location -> ID   \n");}
	 | ID '[' exp ']'	{fprintf(fout,"rule 71\t\t location -> ID '[' expr ']'  \n");}


exp : location	{fprintf(fout,"rule 72\t\t expr -> location   \n");}
	|constant	{fprintf(fout,"rule 73\t\t expr -> constant   \n");}

expr :  '(' expr ')'	{fprintf(fout,"rule 74\t\t expr -> '(' expr ')'   \n");}
	| method_call	{fprintf(fout,"rule 75\t\t expr -> method_call   \n");}
	| operational_expr	{fprintf(fout,"rule 76\t\t expr ->operational_expr\n");}

	

operational_expr : exp LT exp	{fprintf(fout,"rule 77\t\t operational_expr -> expr '<' expr  \n");}
		 | exp LE exp {fprintf(fout,"rule 78\t\t  operational_expr -> expr '<=' expr  \n");}
		 | exp GE exp {fprintf(fout,"rule 79\t\t operational_expr -> expr '>' expr   \n");}
		 | exp GT exp {fprintf(fout,"rule 80\t\t operational_expr -> expr '>=' expr \n");}
		 | exp EQ exp {fprintf(fout,"rule 81\t\t operational_expr -> expr '=' expr \n");}
		 | exp NE exp {fprintf(fout,"rule 82\t\t operational_expr -> expr '!=' expr \n");}
		 | exp AND exp {fprintf(fout,"rule 83\t\t operational_expr -> expr '&'expr \n");}
		 | exp OR exp {fprintf(fout,"rule 84\t\t operational_expr -> expr '|' expr \n");}
		 | exp AND_THEN exp {fprintf(fout,"rule 85\t\t operational_expr -> expr '&&' expr \n");}
		 | exp OR_ELSE exp {fprintf(fout,"rule 86\t\t operational_expr -> expr '||' expr \n");}
		 | exp PLUS exp {fprintf(fout,"rule 87\t\t operational_expr -> expr '+' expr \n");}
		 | exp MINUS exp {fprintf(fout,"rule 88\t\t operational_expr -> expr '-' expr \n");}
		 | exp MULT exp {fprintf(fout,"rule 89\t\t operational_expr -> expr '*' expr \n");}
		 | exp DIV exp {fprintf(fout,"rule 90\t\t operational_expr -> expr '/' expr \n");}
		 | exp REM exp {fprintf(fout,"rule 91\t\t operational_expr ->'<<'expr \n");}
		 | SHR exp {fprintf(fout,"rule 92\t\t operational_expr -> '>>'expr \n");}
		 | MINUS exp {fprintf(fout,"rule 93\t\t operational_expr -> '-'expr \n");}
		 | NOT exp {fprintf(fout,"rule 94\t\t operational_expr -> '!' expr \n");}




%%

int main() {
	
	yyin = fopen("input.txt", "r");
	
	fout = fopen("output-parser.txt", "w");
	fprintf(fout, "\n \t \t \t PARSER \n");
	
	
		yyparse();
		return 0;
}

void yyerror(const char *s) {
	fprintf(fout, "**Error: Line %d near token '%s' --> Message: %s **\n", yylineno,yytext ,s);
	printf("**Error: Line %d near token '%s' --> Message: %s **\n", yylineno,yytext, s);
	
}

