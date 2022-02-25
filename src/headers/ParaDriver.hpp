#pragma once

#include "numgrammar.tab.hh"
#include <FlexLexer.h>

namespace yy {

class ParaDriver {
  FlexLexer *plex_;

public:
  ParaDriver(FlexLexer *plex) : plex_(plex) {}

  parser::token_type yylex(parser::semantic_type *yylval) {
    parser::token_type tt = static_cast<parser::token_type>(plex_->yylex());

    return tt;
  }

  bool parse() {
    parser parser{this};
    bool res = parser.parse();
    return !res;
  }
};

}