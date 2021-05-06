%{
	/* we usually need these... */
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <math.h>

	#include "exemple.tab.h"
	/* Local stuff we need here... */
	#include <math.h>
	extern char nom[];

%}



%option yylineno
delim     [ \t]
bl        {delim}+
chiffre   [0-9]
literal_entier {chiffre}{chiffre}*
lettre    [a-zA-Z]
id        {lettre}({lettre}|{chiffre})*
nb        ("-")?{chiffre}+("."{chiffre}+)?(("E"|"e")"-"?{chiffre}+)?
iderrone  {chiffre}({lettre}|{chiffre})*
ouvrante  (\()
fermante  (\))
COMMENT_LINE        "//"(.*)
COMMENT_BLOCK	  "/*"([^*]|\*+[^*/])*\*+"/"
comment_errone		"/*"([^*]|\*+[^*/])*
method_type     "function"|"procedure"

mulop "*"|"/"
addop "+"|"-"



%%

{bl}                                                                                 /* pas d'actions */
"\n" 			                                                             		 {
																						//printf("ligne numero:%d \n",yylineo);
																						//++yylineno;
																					 };
"program"                                                                            return PROGRAM_KEYWORD;
"begin"                                                                              return BEGIN_KEYWORD;
"end"                                                                                return END_KEYWORD;
{ouvrante}                                                                           return par_ouvrante;
{fermante}                                                                           return par_fermante;
{literal_entier}																	 return literal_entier;	
{nb}                                                                                 return NUMBER_KEYWORD;
"="	                                                                            	 return OPPAFFECT;



"integer"																			 return INTEGER;	
"real"																			     return REAL;
"char"																				 return CHAR;
"of"																				 return OF;
"array"																				 return ARRAY;
".."																				 return TWOPT;



"var" 																				 return VAR;
";" 																				 return SEMICOLON;
":" 																				 return COLON;
{mulop}																				 return MULOP;
{addop} 																			 return ADDOP;
"," 																				 return VIRGULE;
"for"																  				 return FOR_KEYWORD;
{method_type}																		 return METHODTYPE;		
":="																				 return ASSIGN;
"if"																				 return IFkeyword;
"else"																				 return ELSEkeyword;
"then"																				 return THENkeyword;
"do"																				 return DOkeyword;	
"while"																				 return WHILEkeyword;
"["																					 return OPENBRACKET;	
"]"																					 return CLOSEBRACKET;
"{"																					 return OPENCURLYBRACKET;
"}"																					 return CLOSECURLYBRACKET;
"write"																				 return WRITE;
"read"																				 return READ;

{id}                                                                                 {   strcpy(nom, yytext); 
                    																     return ID; 
                    																 }
[*/+\-^,:.()\[\]]    															     return(yytext[0]);


{COMMENT_LINE}         								     							 {   };
{COMMENT_BLOCK}         								     						 {   };
{comment_errone}																	 {  exit(0);                        };
{iderrone}              {fprintf(stderr,"illegal identifier \'%s\' on line :%d\n",yytext,yylineno);}
%%
