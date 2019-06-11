%{
%}

%%

"+" { printf("add\n"); }
"-" { printf("subtract\n"); }
"*" { printf("multiply\n"); }
"/" { printf("divide\n"); }
[0-9]+  { printf("number %s\n", yytext); }
\n  { printf("newline\n"); }
[ \t]   { }
.   { printf("unrecognized token %s\n", yytext); }

%%
