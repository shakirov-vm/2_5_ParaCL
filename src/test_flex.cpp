#include <iostream>

#include <FlexLexer.h>
ted
int yyFlexLexer::yywrap() {
  return 1;
}

int main(){
  
  FlexLexer* lexer = new yyFlexLexer;
  while(lexer->yylex() != 0) {
    
  }
  
  delete lexer;
}