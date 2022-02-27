#pragma once

#include "numgrammar.tab.hh"
#include <FlexLexer.h>
#include <typeinfo>

namespace yy {

class ParaDriver {
  FlexLexer *plex_;

public:
  ParaDriver(FlexLexer *plex) : plex_(plex) { std::cout << "Create lexer" << std::endl; }

  parser::token_type yylex(parser::semantic_type *yylval) {
    parser::token_type tt = static_cast<parser::token_type>(plex_->yylex());

 // std::cout << "yylex" << std::endl;

    if (tt == yy::parser::token_type::NUM) {

      yylval->as<int>() = std::stoi(plex_->YYText());
      //std::cout << "Take num " << plex_->YYText() << std::endl;
    }

    if (tt == yy::parser::token_type::VAR) {

      std::string* tmp = new std::string(plex_->YYText()); 
      yylval->as<std::string*>() = tmp;
     // std::cout << "Take var " << plex_->YYText() << std::endl;
    }

  //std::cout << "correct" << std::endl;

    return tt;
  }

  bool parse() {
    std::cout << "Start parse" << std::endl;
    parser parser{this};
    std::cout << "Before parse\n=--------------------\n\n" << std::endl;
    bool res = parser.parse();
    std::cout << "\n\n=--------------------\nAfter parse" << std::endl;
    return !res;
  }
};

}
/*
  parser::token_type yylex(parser::semantic_type *yylval) {
    parser::token_type tt = static_cast<parser::token_type>(plex_->yylex());
    if (tt == yy::parser::token_type::NUMBER)
      yylval->as<int>() = std::stoi(plex_->YYText());
    return tt;
  }*/