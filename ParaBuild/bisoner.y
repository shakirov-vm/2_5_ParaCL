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

    #include "ParaDriver.hpp"

    namespace yy{

        parser::token_type yylex(parser::semantic_type* yyval, ParaDriver* driver);
    }
}


%token
    SCOL    ";" 
    FLB     "{"
    FRB     "}"
    LB      "("
    RB      ")"
;

%token PRINT_
%token INPUT
%token <int> NUM
%token <std::string*> VAR
%token OP_SUM
%token OP_MUL
%token LOGIC
%token ASSIGN_
%token IF_
%token WHILE_
%token OR
%token AND

%nterm statement
%nterm if
%nterm while 
%nterm assign
%nterm print
%nterm expr
%nterm expr_
%nterm expr_and
%nterm expr_and_
%nterm expr_log 
%nterm expr_log_
%nterm expr_sum
%nterm expr_sum_
%nterm expr_mul
%nterm expr_mul_
%nterm scope

%start program

%%

program: statement_list
; 

statement_list: statement statement_list 
                | %empty
;

statement:    IF_ expr RB FLB statement FRB           { std::cout << "if" << std::endl; }
            | WHILE_ expr RB FLB statement FRB        { std::cout << "while" << std::endl; }
            | assign                                  { std::cout << "statement assign" << std::endl; }
            | print                                   { std::cout << "statement print" << std::endl; }
;

operand:    VAR                             { std::cout << "VAR - " << *$1 << std::endl; }
            | NUM                           { std::cout << "NUM - " << $1 << std::endl; }
            | LB expr RB
;

assign: VAR ASSIGN_ operand SCOL            { std::cout << "assign " << std::endl; }
        | VAR ASSIGN_ INPUT SCOL
;

print:  PRINT_ VAR SCOL                     { std::cout << "print" << std::endl; }
;

expr:   expr_and expr_                      { std::cout << "expr or" << std::endl; }
;
expr_:  OR expr_and expr_                   { std::cout << "or" << std::endl; }
        | %empty                            {}
;

expr_and:   expr_log expr_and_              { std::cout << "expr and" << std::endl; }
;
expr_and_:  AND expr_log expr_and_          { std::cout << "and" << std::endl; }
            | %empty                        {}
;

expr_log:   expr_sum expr_log_              { std::cout << "expr logic" << std::endl; }
;
expr_log_:  LOGIC expr_sum expr_log_        { std::cout << "logic" << std::endl; }
            | %empty                        {}
;

expr_sum:   expr_mul expr_sum_              { std::cout << "expr sum" << std::endl; }
;
expr_sum_:  OP_SUM expr_mul expr_sum_       { std::cout << "sum" << std::endl; }
            | %empty                        {}
;

expr_mul:   operand expr_mul_               { std::cout << "expr mul" << std::endl; }
;
expr_mul_:  OP_MUL operand expr_mul_        { std::cout << "mul" << std::endl; }
            | %empty                        {}
;


%%

namespace yy{

    parser::token_type yylex(parser::semantic_type* yylval,                         
                                ParaDriver* driver)
    {
        return driver->yylex(yylval);
    }

    void parser::error(const std::string&){}    
}
