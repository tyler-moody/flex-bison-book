%option noyywrap nodefault yylineno
%{
#include "fb3-1.h"
#include "fb3-1.tab.h"
%}

/* float exponent */
EXP ([Ee][-+]?[0-9]+)

%%

"+" |
"-" |
"*" |
"/" |
"|" |
"(" |
")"     { return yytext[0]; }

[0-9]+"."[0-9]*{EXP}? |
"."?[0-9]+{EXP}?    { yylval.d = atof(yytext); return NUMBER; }

\n  { return EOL; }

"//".*
[ \t]   { /* ignore whitespace */ }
.   { yyerror("unrecognized token %c\n", *yytext); }

%%
