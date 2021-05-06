%{
	

#include <stdio.h>	
#include "semantique.c"
 			
int yyerror(char const *msg);	
int yylex(void);
extern int yylineno;
char nom[256];

%}

%token PROGRAM_KEYWORD 
%token PTVIRGULE
%token ID
%token par_ouvrante
%token par_fermante
%token VIRGULE
%token OPENCURLYBRACKET
%token CLOSECURLYBRACKET
%token OPENBRACKET
%token CLOSEBRACKET
%token METHODTYPE
%token ASSIGN
%token IFkeyword
%token ELSEkeyword
%token THENkeyword
%token DOkeyword
%token WHILEkeyword
%token READ
%token WRITE
%token MULOP
%token ADDOP
%token literal_entier
%token SEMICOLON
%token COLON
%token BEGIN_KEYWORD
%token END_KEYWORD
%token VAR 
%token NUMBER_KEYWORD
%token OPPAFFECT
%token FOR_KEYWORD
%token INTEGER
%token REAL
%token CHAR
%token OF 
%token ARRAY
%token TWOPT
 

%start programmes

%%
                                                           
programmes:		      PROGRAM_KEYWORD ID SEMICOLON liste_declarations declaration_methodes instruction_composee
					  |PROGRAM_KEYWORD ID SEMICOLON declaration_methodes instruction_composee 
					  |PROGRAM_KEYWORD ID SEMICOLON liste_declarations instruction_composee
					  |PROGRAM_KEYWORD ID SEMICOLON instruction_composee
					  |PROGRAM_KEYWORD ID error                  {yyerror (" point virgule attendu on line : ");YYABORT }
                      |error ID SEMICOLON            {yyerror (" program attendu on line : ");YYABORT}
                      |PROGRAM_KEYWORD error SEMICOLON       {yyerror (" nom du programme invalide on line : ");YYABORT};


liste_identificateurs:  ID {
							checkIdentifier(nom,yylineno);
						}
					   |ID VIRGULE liste_identificateurs
					   |ID {
							checkIdentifier(nom,yylineno);
						} error liste_identificateurs{yyerror("une virgule attendue après l'identificateur");YYABORT}
					   |error VIRGULE liste_identificateurs{yyerror("on ne peut pas commencer par une virgule");YYABORT}
					   |ID VIRGULE error{yyerror("id attendue après la virgule");YYABORT};

standard_type:		    INTEGER { g_type = tInt; }
 				       |REAL { g_type = tFloat; }
 				       |CHAR { g_type = tChar; }

type:				   standard_type 
					   |ARRAY OPENBRACKET literal_entier TWOPT literal_entier CLOSEBRACKET OF standard_type;				       

declaration_corps:     liste_identificateurs COLON type{
								while( g_index > 0 ) {
								g_index-- ;
								g_ListIdentifiers[g_index]->type = g_type;
							}
							g_index = 0 ;
					  }
					  |liste_identificateurs COLON error  {yyerror("erreur au niveau du type ");YYABORT}
					  |error COLON type  {yyerror("liste_identificateurs erroné");YYABORT};

declaration:          VAR declaration_corps SEMICOLON

liste_declarations:    declaration 
					  |declaration liste_declarations;


declaration_methode :  entete_methode instruction_composee
					  |entete_methode liste_declarations instruction_composee;

declaration_methodes:  declaration_methode
					  |declaration_methode SEMICOLON declaration_methodes;


entete_methode:       METHODTYPE { g_IfProc = 1; } 
					  ID
					  {
							if( chercherNoeud(nom, table) ){
								yyerror("Procedure already defined");
							}else{
								g_noeudProc = creerNoeud(nom, NODE_TYPE_UNKNOWN, procedure, NULL);
								table = insererNoeud(g_noeudProc, table);
							}
							g_IfProcParameters = 1;
			          } 
					   arguments
					  {
						    g_noeudProc->nbParam = g_nbParam;
							g_nbParam = 0;
				      }
					  |METHODTYPE error {yyerror (" ID attendu on line : ");YYABORT };


arguments:            par_ouvrante liste_parametres 
					 {
							 g_IfProcParameters = 0;
					 } par_fermante
					 |par_ouvrante error par_fermante {yyerror (" liste_parametres attendu on line : ");YYABORT }
					 |par_ouvrante liste_parametres error {yyerror (" parenthese fermante attendu on line : ");YYABORT };

liste_parametres:      declaration_corps 
					  |declaration_corps SEMICOLON liste_parametres
					  |declaration_corps SEMICOLON error{yyerror (" liste_parametres colon attendu on line : ");YYABORT };

liste_instructions:    instruction SEMICOLON
					  |instruction error {yyerror (" semi colon attendu on line : ");YYABORT }
					  |instruction SEMICOLON liste_instructions
					  |instruction error liste_instructions{yyerror (" semi colon attendu on line : ");YYABORT }
					  |instruction SEMICOLON error{yyerror (" liste_instructions attendu on line : ");YYABORT };


instruction_composee:  BEGIN_KEYWORD liste_instructions END_KEYWORD {endProc(yylineno);}
					  |BEGIN_KEYWORD error END_KEYWORD{yyerror (" liste_instructions attendu on line : ");YYABORT };

instruction:           lvalue ASSIGN expression
	       			  |appel_methode
	       			  |instruction_composee
	       			  |IFkeyword expression THENkeyword instruction ELSEkeyword instruction
	       			  |IFkeyword expression error instruction ELSEkeyword instruction{yyerror ("then keyword attendu on line : ");YYABORT }
	       			  |IFkeyword error THENkeyword instruction ELSEkeyword instruction{yyerror ("expression attendu on line : ");YYABORT }
	       			  |IFkeyword expression THENkeyword error ELSEkeyword instruction{yyerror ("instruction attendu on line : ");YYABORT }
	       			  |IFkeyword expression THENkeyword instruction ELSEkeyword error{yyerror ("instruction attendu on line : ");YYABORT }
	       			  |IFkeyword expression THENkeyword instruction error instruction{yyerror ("else keyword attendu on line : ");YYABORT }
	       			  |WHILEkeyword expression DOkeyword instruction
	       			  |WRITE  par_ouvrante liste_expressions par_fermante 
	       			  {
							g_nbParam = 0;
					  }
	       			  |WRITE par_ouvrante par_fermante
	       			  |READ par_ouvrante liste_identificateurs par_fermante {
							g_nbParam = 0;
						} ;
	       			 

lvalue:				 ID 
					 {
							if(checkIdentifierDeclared(nom,yylineno)) {
								varInitialized (nom); 
							}
					 }
					 |ID 
					 {
							if(checkIdentifierDeclared(nom,yylineno)) {
								varInitialized (nom); 
							}
					 }
					 OPENBRACKET expression CLOSEBRACKET;

appel_methode :		 ID 
					 {
					 		if (!chercherNoeud(nom, table)){
					 			yyerror ("Procedure not declared on line : ");YYABORT;
					 		}
							g_noeud = chercherNoeud(nom,table);
					 }
					 par_ouvrante liste_expressions par_fermante
					 {
							if ( g_noeud->nbParam != g_nbParam)
								yyerror("invalid number of parameters ");
							g_nbParam = 0;
					 }
					 |ID error{yyerror (" parenthèses attendu line : ");YYABORT }
					 ;	

liste_expressions:	 expression
					 {
							g_nbParam ++;
					 }
					 |expression 
					 {
							g_nbParam ++;
					 }
					 VIRGULE liste_expressions
					 |expression error liste_expressions{yyerror ("Virgule attendu on line : ");YYABORT };		

expression:	          facteur  
					 |facteur MULOP facteur
					 |facteur MULOP error{yyerror (" facteur attendu on line : ");YYABORT }
					 |error MULOP facteur{yyerror (" facteur attendu on line : ");YYABORT }
					 |facteur ADDOP facteur
					 |facteur ADDOP error{yyerror (" facteur attendu on line : ");YYABORT }
					 |error ADDOP facteur{yyerror (" facteur attendu on line : ");YYABORT }
					 |facteur OPPAFFECT facteur
					 |facteur OPPAFFECT error{yyerror (" facteur attendu on line : ");YYABORT }
					 |error OPPAFFECT facteur{yyerror (" facteur attendu on line : ");YYABORT };


facteur:		  	ID 
					{
							if(checkIdentifierDeclared(nom,yylineno)) {
								checkVarInit(nom, yylineno);
							}
					}
					|ID 
					OPENBRACKET expression CLOSEBRACKET
					|ID OPENBRACKET expression error{yyerror (" ] attendu on line : ");YYABORT }
					|ID OPENBRACKET error CLOSEBRACKET{yyerror (" expression attendu on line : ");YYABORT }
					|literal_entier 
					|par_ouvrante expression par_fermante
					|par_ouvrante expression error{yyerror (" ) attendu on line : ");YYABORT };


%% 

int yyerror(char const *msg) {
       
	
	fprintf(stderr, "%s %d\n", msg,yylineno);
	return 0;
	
	
}

extern FILE *yyin;

void Begin()
{
	//initialisations
	table = NULL;
	tableLocale = NULL;

	g_type = NODE_TYPE_UNKNOWN;

	g_index = 0;
	g_nbParam = 0;

	g_IfProc = 0 ;
    g_IfProcParameters = 0 ;
}

void End()
{
	destructSymbolsTable(table);
}

main()
{
	Begin();
	yyparse();
	End();
}
yywrap()
{
	return(1);
}
  
                   
