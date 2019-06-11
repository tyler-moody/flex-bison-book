%{
#include "fb1-5.tab.h"
%}

%%

"+" { return ADD; }
"-" { return SUB; }
"*" { return MUL; }
"/" { return DIV; }
"|" { return ABS; }
"(" { return LP; }
")" { return RP; }
"//".* { /* ignore comments */ }
[0-9]+  { yylval = atoi(yytext); return NUMBER; }
\n  { return EOL; }
[ \t]   { /* ignore whitespace */ }
.   { printf("unrecognized token %s\n", yytext); }

%%
