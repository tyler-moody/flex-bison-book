%language "C++"
%defines
%locations

%define parser_class_name { cppcalc }

%{
#include <iostream>
using namespace std;
#include "fb9-6.ctx.hpp"
%}

%parse-param { cppcalc_ctx& ctx }
%lex-param { cppcalc_ctx& ctx }

%union {
    int ival;
};

%token <ival> NUMBER
%token ADD SUB MUL DIV ABS
%token LP RP
%token EOL

%type <ival> exp factor term

%{
extern int yylex(yy::cppcalc::semantic_type* yylval, yy::cppcalc::location_type* yylloc, cppcalc_ctx& ctx);

void myout(int val, int radix);
%}

%initial-action {
    // filename for locations
    @$.begin.filename = @$.end.filename = new std::string("stdin");
}

%%

calclist: /* nothing */
        | calclist exp EOL { cout << "= "; myout(ctx.getradix(), $2); cout << "\n> "; }
        | calclist EOL { cout << "> "; }
        ;

exp: factor
   | exp ADD factor { $$ = $1 + $3; }
   | exp SUB factor { $$ = $1 - $3; }
   | exp ABS factor { $$ = $1 | $3; }
   ;

factor: term
      | factor MUL term { $$ = $1 * $3; }
      | factor DIV term { if ($3 == 0) {
                            error(@3, "divide by zero");
                            YYABORT;
                          }
                          $$ = $1 / $3; 
                        }
      ;

term: NUMBER
    | ABS term { $$ = $2 >= 0 ? $2 : -$2; }
    | LP exp RP { $$ = $2; }
    ;

%%

int main() {
   cppcalc_ctx ctx(8); // radix 8, octal 
   cout << "> ";
   yy::cppcalc parser(ctx);
   int v = parser.parse();
   return v;
}

void myout(int radix, int val)
{
    if (val < 0){
        cout << "-";
        val = -val;
    }
    if (val > radix){
        myout(radix, val/radix);
        val %= radix;
    }
    cout << val;
}

int myatoi(int radix, char* s){
    int v = 0;
    while(*s){
        v = v*radix + *s++ - '0';
    }
    return v;
}

namespace yy {
    void cppcalc::error(location const & loc, const std::string& s){
        std::cerr << "error at " << loc << ": " << s << std::endl;
    }
}
