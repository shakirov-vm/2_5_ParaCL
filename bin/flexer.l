
%option c++

%{
    
#include "numgrammar.tab.hh"

using std::cout;
using std::endl;

%}

WS      [ \t\n\v]+
PRINT   "print"
INPUT   "?"
SCOLON  ";"


DIGIT   [0-9]
DIGIT1  [1-9]
NUM     ({DIGIT1}{DIGIT}*)|"0"

LETTER  [a-z]|[A-Z]
UNDERLI "_"
VAR     ({LETTER}|{UNDERLI})({UNDERLI}|{NUM}|{LETTER})*

OP_SUM  [\+\-]
OP_MUL  [\*\\]

EQUAL   "=="
GRETEQ  ">="
LESSEQ  "<="
LOGIC   {EQUAL}|{GRETEQ}|{LESSEQ}|[\<\>]

OR  "||"
AND "&&"

ASSIGN [\=]

FLB "{"
FRB "}"
LB  "("
RB  ")"
IF_ "if"
IF  {IF_}{WS}*{LB}

WHILE_ "while"
WHILE {WHILE_}{WS}*{LB}

%%

{WS}                /* skip blanks and tabs */
{OR}                { cout << " logic or<" << yytext    << ">" << endl; return yy::parser::token_type::OR; }
{AND}               { cout << " logic an<" << yytext    << ">" << endl; return yy::parser::token_type::AND; }
{OP_SUM}            { cout << "operator <" << yytext[0] << ">" << endl; return yy::parser::token_type::OP_SUM; }
{OP_MUL}            { cout << "operator <" << yytext[0] << ">" << endl; return yy::parser::token_type::OP_MUL; }
{NUM}               { cout << " number  <" << yytext    << ">" << endl; return yy::parser::token_type::NUM; }
{LOGIC}             { cout << " logic   <" << yytext    << ">" << endl; return yy::parser::token_type::LOGIC; }
{ASSIGN}            { cout << " assign   " <<           endl; return yy::parser::token_type::ASSIGN_; }
{IF}                { cout << " if       " <<           endl; return yy::parser::token_type::IF_; }
{WHILE}             { cout << " while    " <<           endl; return yy::parser::token_type::WHILE_; }
{VAR}               { cout << " var name<" << yytext    << ">" << endl; return yy::parser::token_type::VAR; }
{PRINT}             { cout << " print    " <<           endl; return yy::parser::token_type::PRINT_; }
{INPUT}             { cout << " INPUT    " <<           endl; return yy::parser::token_type::INPUT; }
{SCOLON}            { cout << " SCOLON   " <<           endl; return yy::parser::token_type::SCOL; }
{FLB}               { cout << " bracket <" << yytext[0] << ">" << endl; return yy::parser::token_type::FLB; }
{FRB}               { cout << " bracket <" << yytext[0] << ">" << endl; return yy::parser::token_type::FRB; }
{LB}                { cout << " bracket <" << yytext[0] << ">" << endl; return yy::parser::token_type::LB; }
{RB}                { cout << " bracket <" << yytext[0] << ">" << endl; return yy::parser::token_type::RB; }
.                   { cout << " UNKNOWN <" << yytext[0] << ">" << endl; return 1; }

%%