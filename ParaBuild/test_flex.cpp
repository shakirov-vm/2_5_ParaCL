#include <iostream>

#include "ParaDriver.hpp"
#include <FlexLexer.h>

int yyFlexLexer::yywrap() {
  std::cout << "Error" << std::endl;
  return 1;
}

int main() {

  std::cout << "We start" << std::endl;
  
  FlexLexer* lexer = new yyFlexLexer;

  yy::ParaDriver driver(lexer);
  driver.parse();
  //delete lexer; ??
}