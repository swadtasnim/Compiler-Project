%{  #include<stdio.h>
	#include<string.h>
	#include<stdlib.h>
     #include "y.tab.h"


%}



headerfile              "import<"[a-z]+[.]"file>"
function                "Typ_def "[A-Z][a-z]+[(][^\n]*[)][:]
punctuation             ","|";;"|"("|")"
Types                   Khali|Purno|Doshomic|Shobdo|Okkhor
keywords                "Jokhon"|"Jokhoni"|"Nahole"|"Jotokhon"|"Shesh"|"Berhoye"|"Jeimatro"|"Tokhon"|"Likho"

id                      [a-z][A-Z][a-zA-Z0-9]*

operators               "ADD"|"SUB"|"MULT"|"PART"|"MOD"|"PW"|"Shoman"|"sShomaan"|"Ebong"|"Othoba"|"Noy"|"theke_Boro"|"theke_Choto"|"sin"|"cos"|"tan"|"log"
digit                   [0-9]+
num                     {digit}*[.]{digit}+
singleLineComment		[*][*][*][a-zA-Z0-9!@#$%^&(){}_+-,.:\|?>< ]+
multipleLineComment		[&][&][&][a-zA-Z0-9!@#$*(){}_+-,.:\|?><%\n\t ]*[&][&][&]


%%
{headerfile}            {}
{function}              { return FUN;}

{Types}                 { return TYPES;}

{keywords}              {   if(strcmp(yytext,"Jokhon")==0)  return IF;
                            if(strcmp(yytext,"Jokhoni")==0) {
                             return SWITCH;}
						 	else if(strcmp(yytext,"Nahole")==0)  return ELSE;
						 	else if(strcmp(yytext,"Jotokhon")==0)  return LOOP;
						 	else if(strcmp(yytext,"Jeimatro")==0)  {
						 	return CASE;}
						 	else if(strcmp(yytext,"Shesh")==0)  return BREAK;
						 	else if(strcmp(yytext,"Berhoye")==0)  return RET;
						 	else if(strcmp(yytext,"Tokhon")==0)  {
						 	return THEN;}
						 	else if(strcmp(yytext,"Likho")==0)  return PRINT;
                            
						 }


{punctuation}            { if(strcmp(yytext,",")==0)  return COMMA;
						 	else if(strcmp(yytext,";;")==0)  return SEMI;
						 	else if(strcmp(yytext,"(")==0)  return LP;
						 	else if(strcmp(yytext,")")==0)  return RP;
                            
						 }


{digit}                  {  
	
                             yylval = atoi(yytext);

							return NUMBER; }

{num}                    {  sscanf(yytext, "%lf", &yylval);
							return DOUBLE;}							


{id}                      {  yylval = *yytext; return ID;}


{operators}               { if(strcmp(yytext,"ADD")==0)  return PLUS;
						 	else if(strcmp(yytext,"SUB")==0)  return MINUS;
						 	else if(strcmp(yytext,"PART")==0)  return DIVISION;
						 	else if(strcmp(yytext,"MULT")==0)  return MULTIPLICATION;
						 	else if(strcmp(yytext,"MOD")==0)  return MOD;
						 	else if(strcmp(yytext,"PW")==0)  return POW;
						 	else if(strcmp(yytext,"Shoman")==0)  return ASSIGN;
						 	else if(strcmp(yytext,"sShomaan")==0)  return EQUAL;
						 	else if(strcmp(yytext,"theke_Boro")==0)  return GRT;
						 	else if(strcmp(yytext,"theke_Choto")==0)  return LST;
						 	else if(strcmp(yytext,"Ebong")==0)  return AND;
						 	else if(strcmp(yytext,"Othoba")==0)  return OR;
						 	else if(strcmp(yytext,"Noy")==0)  return NOT;
						 	else if(strcmp(yytext,"sin")==0)  return SIN;
						 	else if(strcmp(yytext,"cos")==0)  return COS;
						 	else if(strcmp(yytext,"tan")==0)  return TAN;
						 	else if(strcmp(yytext,"log")==0)  return LOG;
						 	}





{singleLineComment}   {}
{multipleLineComment}  {}
.                  {}

%%

int yywrap()
{
	return 1;
}

int main()
{   yyin = freopen("in_file.txt", "r",stdin);
	freopen("out_file.txt","w",stdout);
	yyparse();
	return 0;
}
