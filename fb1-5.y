%{
#include <stdio.h>
%}

%token NUMBER
%token ADD SUB MUL DIV ABS
%token LP RP
%token EOL

%%

calclist:   /* nothing */
    | calclist exp EOL { printf("= %d\n", $2); }
    ; 

exp: factor { $$ = $1; }
   | exp ADD factor { $$ = $1 + $3; }
   | exp SUB factor { $$ = $1 - $3; }
   ;

factor: term { $$ = $1; }
      | factor MUL term { $$ = $1 * $3; }
      | factor DIV term { $$ = $1 / $3; }
      ;

term: NUMBER { $$ = $1; }
    | ABS term { $$ = $2 >= 0? $2 : -$2; }
    | LP exp RP { $$ = $2; }
    ; 

%% 

int main() {
    yyparse();
    return 0;
}
    
int yyerror(char* s){
    fprintf(stderr, "error: %s\n", s);
}
