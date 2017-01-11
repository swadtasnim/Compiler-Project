%{
    #include <stdio.h>
	#include <math.h>
	#include <stdlib.h>
	#include <string.h>
	#define PI 3.141593
    
    int num[125],m,g=0,d;

   	

%}


%start program
%token FUN TYPES IF SWITCH ELSE LOOP CASE BREAK RET PRINT THEN SIN COS TAN LOG
%token COMMA SEMI LP RP NUMBER DOUBLE ID 
%token PLUS MINUS DIVISION MULTIPLICTION MOD POW ASSIGN EQUAL GRT LST AND OR NOT

%nonassoc IF ELSE
%nonassoc GRT LST EQUAL OR AND  NOT
 

%left ASSIGN 
%left PLUS MINUS 
%left MULTIPLICATION DIVISION
%left MOD
%right POW
%left SIN COS TAN LOG

%%

program: FUN statement ret;

statement: 
          |statement stmt
          ;

stmt: TYPES var SEMI                    {printf("Declaration done!");}

      |ID ASSIGN expr SEMI              {    num[$1] = $3; printf("Assignation Done!"); }

      |PRINT expr SEMI                  {printf("The Value is = : %d\n",$2);}

      |PRINT expr2 SEMI

      |IF LP expr RP stmt BREAK SEMI                         %prec IF  {if($3)
                                                         {printf("We are in Jokhon condition");}
                                                     }

      |IF LP expr RP stmt  ELSE stmt  BREAK SEMI         {

                                                  if($3)
                                                  printf("We are in Jokhon condition");
								                  
								                 else
								                   printf("We are in Nahole condition");
								                 
                                                 }
                                             
    |LOOP LP expr COMMA expr RP  expr SEMI  {int i;for(i=$3;i<=$5;i++){printf("In loop! %d\n",i);}}
    | cases ELSE expr SEMI {if(g==0){printf("We are in default nahole case ");}}  
	;
 
 cases:SWITCH LP expr RP  { m=$3; }
 |cases CASE expr THEN expr SEMI  { if($3==m) 
                                        {printf("We are in Jeimatro case: %d ",m);

                                       g=1;

                                        }

                               

                                         }

      

   	;
	




var: ID            
     | var COMMA ID  
     ;               

ret:   RET
     | RET ID
     ;


expr2:SIN LP expr RP 				{ printf("Result = %f",sin($3*PI/180.0));}

    | COS LP expr RP 				{ printf("Result = %f",cos($3*PI/180.0));}

    | TAN LP expr RP				{ printf("Result = %f",tan($3*PI/180.0));}

    | LOG LP expr RP 				{ printf("Result = %f",log10($3*PI/180.0));}
    ;


expr: NUMBER                {$$=$1;}
    | DOUBLE                {$$=$1;}
    | ID                {$$ = num[$1] ;}
	| expr PLUS expr		{$$ = $1 + $3; }
    | expr MINUS expr		{$$ = $1 - $3;}
    | expr MULTIPLICATION expr	{$$ = $1 * $3;}
    | expr DIVISION expr		{if($3) $$ = $1 / $3; else printf("\nImpossible as Divisor is Zero\n"); }
    | expr POW expr		    {$$ = pow($1, $3);}
    | expr MOD expr  	    {$$ = $1 % $3;}
    | expr LST expr 	    {$$ = $1 > $3;}
    | expr GRT expr         {$$ = $1 < $3;}
    | LP expr RP 		    {$$ = $2;} 
    |expr EQUAL expr       { $$=($1 == $3);}
    | NOT expr              {$$=!($2);}
    |expr AND expr          {$$=($1 && $3);}
    |expr OR expr           {$$=($1 || $3);}

    ;





 

%%

yyerror (char *s)
{
	printf("%s\n",s);
	return(0);
}









