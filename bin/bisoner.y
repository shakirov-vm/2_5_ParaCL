%language "c++"

%skeleton "lalr1.cc"
%defines
%define api.value.type variant
%param {yy::ParaDriver* driver}

%code requires{

    #include <iostream>

    namespace yy{ class ParaDriver; }
}

%code{

    #include "../src/headers/ParaDriver.hpp"

    namespace yy{

        parser::token_type yylex(parser::semantic_type* yyval, ParaDriver* driver);
    }
}

%union{

    int val;
}

%token
    SCOL  ";" 
    FLB "{"
    FRB "}"
    LB  "("
    RB  ")"
;

%token <int> PRINT_
%token <int> INPUT
%token <int> NUM
%token <int> VAR
%token <int> OP_SUM
%token <int> OP_MUL
%token <int> LOGIC_
%token <int> ASSIGN_
%token <int> IF_
%token <int> WHILE_
%token <int> OR

%nterm 

%start program

%%

program: statement
;

statement:  if
            | while
            | assign
            | print
            | %empty
;

operand:    VAR
            | NUM
            | LB expr RB
;

if: IF_ expr RB LFB statement RFB
;

while:  WHILE_ expr RB LFB statement RFB
;

assign: VAR ASSIGN_ operand SCOL
;

print:  PRINT_ VAR SCOL
;

expr:   expr_and expr_
;
expr_:  OR expr_and expr_
        | %empty
;

expr_and:   expr_log expr_and_
;
expr_and_:  AND expr_log expr_and_
            | %empty
;

expr_log:   expr_sum expr_log_
;
expr_log_:  LOGIC_ expr_sum expr_log_
;

expr_sum:   expr_mul expr_sum_
;
expr_sum_:  OP_SUM expr_mul expr_sum_
;

expr_mul:   operand expr_mul_
;
expr_mul_:  OP_MUL operand expr_mul_
;

%%

namespace yy{

    parser::token_type yylex(parser::semantic_type* yylval,                         
                                NumDriver* driver)
    {
        return driver->yylex(yylval);
    }

    void parser::error(const std::string&){}    
}
