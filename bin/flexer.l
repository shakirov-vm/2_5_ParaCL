
%option c++

%{

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


OP      [\+\-\*\\]

EQUAL   "=="
GRETEQ  ">="
LESSEQ  "<="
LOGIC   {EQUAL}|{GRETEQ}|{LESSEQ}|[\<\>]

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
{OP}                { cout << "operator <" << yytext[0] << ">" << endl; return 1; }
{NUM}               { cout << " number  <" << yytext    << ">" << endl; return 1; }
{LOGIC}             { cout << " logic   <" << yytext    << ">" << endl; return 1; }
{ASSIGN}            { cout << " assign   " <<           endl; return 1; }
{IF}                { cout << " if       " <<           endl; return 1; }
{WHILE}             { cout << " while    " <<           endl; return 1; }
{VAR}               { cout << " var name<" << yytext    << ">" << endl; return 1; }
{PRINT}             { cout << " print    " <<           endl; return 1; }
{INPUT}             { cout << " INPUT    " <<           endl; return 1; }
{SCOLON}            { cout << " SCOLON   " <<           endl; return 1; }
{FLB}               { cout << " bracket <" << yytext[0] << ">" << endl; return 1; }
{FRB}               { cout << " bracket <" << yytext[0] << ">" << endl; return 1; }
{LB}                { cout << " bracket <" << yytext[0] << ">" << endl; return 1; }
{RB}                { cout << " bracket <" << yytext[0] << ">" << endl; return 1; }
.                   { cout << " UNKNOWN <" << yytext[0] << ">" << endl; return 1; }

%%