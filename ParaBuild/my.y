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

%nterm equals
%nterm eqlist

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

program: scope               { std::cout << "We start" << std::endl;}
;

scope:  statement scope  { std::cout << "We pars next equal" << std::endl;}
      | statement          { std::cout << "We pars last equal" << std::endl;}
;

statement:    lvalue ASSIGN_ expr_sum SCOL             { std::cout << "We have var = expr" << std::endl; }
            | IF_ expr_sum RB FLB scope FRB            { std::cout << "if" << std::endl; }
;

operand:      VAR                   { std::cout << "VAR - " << *$1 << std::endl; }
            | NUM                   { std::cout << "NUM - " << $1 << std::endl; }
;

lvalue:       VAR                   { std::cout << "VAR - " << *$1 << std::endl; }
;

expr_sum:   expr_mul expr_sum_              { /*std::cout << "expr sum" << std::endl; */}
;
expr_sum_:  OP_SUM expr_mul expr_sum_       { std::cout << "sum" << std::endl; }
            | %empty                        {}
;

expr_mul:   expr_brack expr_mul_               { /*std::cout << "expr mul" << std::endl; */}
;
expr_mul_:  OP_MUL expr_brack expr_mul_        { std::cout << "mul" << std::endl; }
            | %empty                        {}
;

expr_brack:   LB expr_sum RB                    { std::cout << "brackets expr" << std::endl; }
            | operand


%%

namespace yy {
// 1 - bracket expr in hierarchy
    parser::token_type yylex(parser::semantic_type* yylval,                         
                                ParaDriver* driver)
    {
        return driver->yylex(yylval);
    }

    void parser::error(const std::string&){}    

/*
program: statement_list

statement_list:   statement SCOL statement      { std::cout << "statement average" << std::endl; }
                | statement SCOL                { std::cout << "statement last" << std::endl; }
;

statement: VAR ASSIGN_ expr                     { std::cout << "assign" << std::endl; }
;

expr:     NUM                                   { std::cout << "NUM - " << $1 << std::endl; }               
        | VAR                                   { std::cout << "VAR - " << $1 << std::endl; }
        | expr OP_SUM NUM                       { std::cout << "sum num" << std::endl; }
        | expr OP_SUM VAR                       { std::cout << "sum var" << std::endl; }
        | expr OP_MUL NUM                       { std::cout << "mul num" << std::endl; }
        | expr OP_MUL VAR                       { std::cout << "mul var" << std::endl; }
;    
*/

/*
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
*/

/*

program: eqlist               { std::cout << "We start" << std::endl;}
;

eqlist: statement SCOL eqlist  { std::cout << "We pars next equal" << std::endl;}
      | statement SCOL         { std::cout << "We pars last equal" << std::endl;}
;

statement:    lvalue ASSIGN_ expr_sum      { std::cout << "We have var = expr" << std::endl; }
            | if                           { std::cout << "if statement" << std::endl; }
;

operand:      VAR                   { std::cout << "VAR - " << *$1 << std::endl; }
            | NUM                   { std::cout << "NUM - " << $1 << std::endl; }
;

lvalue:       VAR                   { std::cout << "VAR - " << *$1 << std::endl; }
;

if: IF_ expr_sum RB FLB eqlist FRB           { std::cout << "if" << std::endl; }
;

expr_sum:   expr_mul expr_sum_              { /*std::cout << "expr sum" << std::endl; }
;
expr_sum_:  OP_SUM expr_mul expr_sum_       { std::cout << "sum" << std::endl; }
            | %empty                        {}
;

expr_mul:   expr_brack expr_mul_               { /*std::cout << "expr mul" << std::endl; }
;
expr_mul_:  OP_MUL expr_brack expr_mul_        { std::cout << "mul" << std::endl; }
            | %empty                        {}
;

expr_brack:   LB expr_sum RB                    { std::cout << "brackets expr" << std::endl; }
            | operand

*/
}
