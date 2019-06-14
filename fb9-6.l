%option noyywrap
%{
#include <cstdlib>

#include "fb9-6.ctx.hpp"
#include "fb9-6.tab.hh"

#define YY_DECL int yylex(yy::cppcalc::semantic_type* yylval, yy::cppcalc::location_type* yylloc, cppcalc_ctx& ctx)

#define YY_USER_ACTION yylloc->columns(yyleng);

typedef yy::cppcalc::token token;
extern int myatoi(int radix, char* s);
%}

%%

%{
    yylloc->step();
%}

"+"  { return token::ADD; }
"-" { return token::SUB; }
"*" { return token::MUL; }
"/" { return token::DIV; }
"|" { return token::ABS; }
"(" { return token::LP; }
")" { return token::RP; }
[0-9]+  { yylval->ival = myatoi(ctx.getradix(), yytext); return token::NUMBER; }
\n  { yylloc->lines(1); return token::EOL; }
"//".*  |
[ \t]   { yylloc->step(); }
.   { printf("unrecognized token %c\n", *yytext); }

%%
