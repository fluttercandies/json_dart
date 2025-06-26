// Generated from JSON5.g4 by ANTLR 4.12.0
// ignore_for_file: unused_import, unused_local_variable, prefer_single_quotes
import 'package:antlr4/antlr4.dart';

import 'JSON5Visitor.dart';
import 'JSON5BaseVisitor.dart';
const int RULE_json5 = 0, RULE_object = 1, RULE_pair = 2, RULE_key = 3, 
          RULE_value = 4, RULE_array = 5, RULE_string = 6, RULE_bool = 7, 
          RULE_null = 8, RULE_number = 9;
class JSON5Parser extends Parser {
  static final checkVersion = () => RuntimeMetaData.checkVersion('4.12.0', RuntimeMetaData.VERSION);
  static const int TOKEN_EOF = IntStream.EOF;

  static final List<DFA> _decisionToDFA = List.generate(
      _ATN.numberOfDecisions, (i) => DFA(_ATN.getDecisionState(i), i));
  static final PredictionContextCache _sharedContextCache = PredictionContextCache();
  static const int TOKEN_T__0 = 1, TOKEN_T__1 = 2, TOKEN_T__2 = 3, TOKEN_T__3 = 4, 
                   TOKEN_T__4 = 5, TOKEN_T__5 = 6, TOKEN_T__6 = 7, TOKEN_T__7 = 8, 
                   TOKEN_T__8 = 9, TOKEN_T__9 = 10, TOKEN_SINGLE_LINE_COMMENT = 11, 
                   TOKEN_MULTI_LINE_COMMENT = 12, TOKEN_LITERAL = 13, TOKEN_STRING = 14, 
                   TOKEN_NUMBER = 15, TOKEN_NUMERIC_LITERAL = 16, TOKEN_SYMBOL = 17, 
                   TOKEN_IDENTIFIER = 18, TOKEN_WS = 19;

  @override
  final List<String> ruleNames = [
    'json5', 'object', 'pair', 'key', 'value', 'array', 'string', 'bool', 
    'null', 'number'
  ];

  static final List<String?> _LITERAL_NAMES = [
      null, "'{'", "','", "'}'", "'\\uFF0C'", "':'", "'['", "']'", "'true'", 
      "'false'", "'null'"
  ];
  static final List<String?> _SYMBOLIC_NAMES = [
      null, null, null, null, null, null, null, null, null, null, null, 
      "SINGLE_LINE_COMMENT", "MULTI_LINE_COMMENT", "LITERAL", "STRING", 
      "NUMBER", "NUMERIC_LITERAL", "SYMBOL", "IDENTIFIER", "WS"
  ];
  static final Vocabulary VOCABULARY = VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

  @override
  Vocabulary get vocabulary {
    return VOCABULARY;
  }

  @override
  String get grammarFileName => 'JSON5.g4';

  @override
  List<int> get serializedATN => _serializedATN;

  @override
  ATN getATN() {
   return _ATN;
  }

  JSON5Parser(TokenStream input) : super(input) {
    interpreter = ParserATNSimulator(this, _ATN, _decisionToDFA, _sharedContextCache);
  }

  Json5Context json5() {
    dynamic _localctx = Json5Context(context, state);
    enterRule(_localctx, 0, RULE_json5);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 21;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if ((((_la) & ~0x3f) == 0 && ((1 << _la) & 247618) != 0)) {
        state = 20;
        value();
      }

      state = 23;
      match(TOKEN_EOF);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ObjectContext object() {
    dynamic _localctx = ObjectContext(context, state);
    enterRule(_localctx, 2, RULE_object);
    int _la;
    try {
      int _alt;
      state = 83;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 9, context)) {
      case 1:
        enterOuterAlt(_localctx, 1);
        state = 25;
        match(TOKEN_T__0);
        state = 26;
        pair();
        state = 31;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 1, context);
        while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
          if (_alt == 1) {
            state = 27;
            match(TOKEN_T__1);
            state = 28;
            pair(); 
          }
          state = 33;
          errorHandler.sync(this);
          _alt = interpreter!.adaptivePredict(tokenStream, 1, context);
        }
        state = 35;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_T__1) {
          state = 34;
          match(TOKEN_T__1);
        }

        state = 37;
        match(TOKEN_T__2);
        break;
      case 2:
        enterOuterAlt(_localctx, 2);
        state = 39;
        match(TOKEN_T__0);
        state = 40;
        pair();
        state = 45;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 3, context);
        while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
          if (_alt == 1) {
            state = 41;
            match(TOKEN_T__3);
            state = 42;
            pair(); 
          }
          state = 47;
          errorHandler.sync(this);
          _alt = interpreter!.adaptivePredict(tokenStream, 3, context);
        }
        state = 49;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_T__3) {
          state = 48;
          match(TOKEN_T__3);
        }

        state = 51;
        match(TOKEN_T__2);
        break;
      case 3:
        enterOuterAlt(_localctx, 3);
        state = 53;
        match(TOKEN_T__0);
        state = 54;
        pair();
        state = 59;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        while (_la == TOKEN_T__3) {
          state = 55;
          match(TOKEN_T__3);
          state = 56;
          pair();
          state = 61;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
        }
        state = 63;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_T__1) {
          state = 62;
          match(TOKEN_T__1);
        }

        state = 65;
        match(TOKEN_T__2);
        break;
      case 4:
        enterOuterAlt(_localctx, 4);
        state = 67;
        match(TOKEN_T__0);
        state = 68;
        pair();
        state = 73;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        while (_la == TOKEN_T__1) {
          state = 69;
          match(TOKEN_T__1);
          state = 70;
          pair();
          state = 75;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
        }
        state = 77;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_T__3) {
          state = 76;
          match(TOKEN_T__3);
        }

        state = 79;
        match(TOKEN_T__2);
        break;
      case 5:
        enterOuterAlt(_localctx, 5);
        state = 81;
        match(TOKEN_T__0);
        state = 82;
        match(TOKEN_T__2);
        break;
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  PairContext pair() {
    dynamic _localctx = PairContext(context, state);
    enterRule(_localctx, 4, RULE_pair);
    try {
      enterOuterAlt(_localctx, 1);
      state = 85;
      key();
      state = 86;
      match(TOKEN_T__4);
      state = 87;
      value();
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  KeyContext key() {
    dynamic _localctx = KeyContext(context, state);
    enterRule(_localctx, 6, RULE_key);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 89;
      _la = tokenStream.LA(1)!;
      if (!((((_la) & ~0x3f) == 0 && ((1 << _la) & 352256) != 0))) {
      errorHandler.recoverInline(this);
      } else {
        if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
        errorHandler.reportMatch(this);
        consume();
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ValueContext value() {
    dynamic _localctx = ValueContext(context, state);
    enterRule(_localctx, 8, RULE_value);
    try {
      state = 97;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_STRING:
        enterOuterAlt(_localctx, 1);
        state = 91;
        string();
        break;
      case TOKEN_NUMBER:
      case TOKEN_NUMERIC_LITERAL:
      case TOKEN_SYMBOL:
        enterOuterAlt(_localctx, 2);
        state = 92;
        number();
        break;
      case TOKEN_T__0:
        enterOuterAlt(_localctx, 3);
        state = 93;
        object();
        break;
      case TOKEN_T__5:
        enterOuterAlt(_localctx, 4);
        state = 94;
        array();
        break;
      case TOKEN_T__7:
      case TOKEN_T__8:
        enterOuterAlt(_localctx, 5);
        state = 95;
        bool();
        break;
      case TOKEN_T__9:
        enterOuterAlt(_localctx, 6);
        state = 96;
        null_();
        break;
      default:
        throw NoViableAltException(this);
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ArrayContext array() {
    dynamic _localctx = ArrayContext(context, state);
    enterRule(_localctx, 10, RULE_array);
    int _la;
    try {
      int _alt;
      state = 157;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 19, context)) {
      case 1:
        enterOuterAlt(_localctx, 1);
        state = 99;
        match(TOKEN_T__5);
        state = 100;
        value();
        state = 105;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 11, context);
        while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
          if (_alt == 1) {
            state = 101;
            match(TOKEN_T__1);
            state = 102;
            value(); 
          }
          state = 107;
          errorHandler.sync(this);
          _alt = interpreter!.adaptivePredict(tokenStream, 11, context);
        }
        state = 109;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_T__1) {
          state = 108;
          match(TOKEN_T__1);
        }

        state = 111;
        match(TOKEN_T__6);
        break;
      case 2:
        enterOuterAlt(_localctx, 2);
        state = 113;
        match(TOKEN_T__5);
        state = 114;
        value();
        state = 119;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        while (_la == TOKEN_T__3) {
          state = 115;
          match(TOKEN_T__3);
          state = 116;
          value();
          state = 121;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
        }
        state = 123;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_T__1) {
          state = 122;
          match(TOKEN_T__1);
        }

        state = 125;
        match(TOKEN_T__6);
        break;
      case 3:
        enterOuterAlt(_localctx, 3);
        state = 127;
        match(TOKEN_T__5);
        state = 128;
        value();
        state = 133;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 15, context);
        while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
          if (_alt == 1) {
            state = 129;
            match(TOKEN_T__3);
            state = 130;
            value(); 
          }
          state = 135;
          errorHandler.sync(this);
          _alt = interpreter!.adaptivePredict(tokenStream, 15, context);
        }
        state = 137;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_T__3) {
          state = 136;
          match(TOKEN_T__3);
        }

        state = 139;
        match(TOKEN_T__6);
        break;
      case 4:
        enterOuterAlt(_localctx, 4);
        state = 141;
        match(TOKEN_T__5);
        state = 142;
        value();
        state = 147;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        while (_la == TOKEN_T__1) {
          state = 143;
          match(TOKEN_T__1);
          state = 144;
          value();
          state = 149;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
        }
        state = 151;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_T__3) {
          state = 150;
          match(TOKEN_T__3);
        }

        state = 153;
        match(TOKEN_T__6);
        break;
      case 5:
        enterOuterAlt(_localctx, 5);
        state = 155;
        match(TOKEN_T__5);
        state = 156;
        match(TOKEN_T__6);
        break;
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  StringContext string() {
    dynamic _localctx = StringContext(context, state);
    enterRule(_localctx, 12, RULE_string);
    try {
      enterOuterAlt(_localctx, 1);
      state = 159;
      match(TOKEN_STRING);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  BoolContext bool() {
    dynamic _localctx = BoolContext(context, state);
    enterRule(_localctx, 14, RULE_bool);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 161;
      _la = tokenStream.LA(1)!;
      if (!(_la == TOKEN_T__7 || _la == TOKEN_T__8)) {
      errorHandler.recoverInline(this);
      } else {
        if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
        errorHandler.reportMatch(this);
        consume();
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  NullContext null_() {
    dynamic _localctx = NullContext(context, state);
    enterRule(_localctx, 16, RULE_null);
    try {
      enterOuterAlt(_localctx, 1);
      state = 163;
      match(TOKEN_T__9);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  NumberContext number() {
    dynamic _localctx = NumberContext(context, state);
    enterRule(_localctx, 18, RULE_number);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 166;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_SYMBOL) {
        state = 165;
        match(TOKEN_SYMBOL);
      }

      state = 168;
      _la = tokenStream.LA(1)!;
      if (!(_la == TOKEN_NUMBER || _la == TOKEN_NUMERIC_LITERAL)) {
      errorHandler.recoverInline(this);
      } else {
        if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
        errorHandler.reportMatch(this);
        consume();
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  static const List<int> _serializedATN = [
      4,1,19,171,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,6,7,6,
      2,7,7,7,2,8,7,8,2,9,7,9,1,0,3,0,22,8,0,1,0,1,0,1,1,1,1,1,1,1,1,5,1,
      30,8,1,10,1,12,1,33,9,1,1,1,3,1,36,8,1,1,1,1,1,1,1,1,1,1,1,1,1,5,1,
      44,8,1,10,1,12,1,47,9,1,1,1,3,1,50,8,1,1,1,1,1,1,1,1,1,1,1,1,1,5,1,
      58,8,1,10,1,12,1,61,9,1,1,1,3,1,64,8,1,1,1,1,1,1,1,1,1,1,1,1,1,5,1,
      72,8,1,10,1,12,1,75,9,1,1,1,3,1,78,8,1,1,1,1,1,1,1,1,1,3,1,84,8,1,
      1,2,1,2,1,2,1,2,1,3,1,3,1,4,1,4,1,4,1,4,1,4,1,4,3,4,98,8,4,1,5,1,5,
      1,5,1,5,5,5,104,8,5,10,5,12,5,107,9,5,1,5,3,5,110,8,5,1,5,1,5,1,5,
      1,5,1,5,1,5,5,5,118,8,5,10,5,12,5,121,9,5,1,5,3,5,124,8,5,1,5,1,5,
      1,5,1,5,1,5,1,5,5,5,132,8,5,10,5,12,5,135,9,5,1,5,3,5,138,8,5,1,5,
      1,5,1,5,1,5,1,5,1,5,5,5,146,8,5,10,5,12,5,149,9,5,1,5,3,5,152,8,5,
      1,5,1,5,1,5,1,5,3,5,158,8,5,1,6,1,6,1,7,1,7,1,8,1,8,1,9,3,9,167,8,
      9,1,9,1,9,1,9,0,0,10,0,2,4,6,8,10,12,14,16,18,0,3,3,0,13,14,16,16,
      18,18,1,0,8,9,1,0,15,16,191,0,21,1,0,0,0,2,83,1,0,0,0,4,85,1,0,0,0,
      6,89,1,0,0,0,8,97,1,0,0,0,10,157,1,0,0,0,12,159,1,0,0,0,14,161,1,0,
      0,0,16,163,1,0,0,0,18,166,1,0,0,0,20,22,3,8,4,0,21,20,1,0,0,0,21,22,
      1,0,0,0,22,23,1,0,0,0,23,24,5,0,0,1,24,1,1,0,0,0,25,26,5,1,0,0,26,
      31,3,4,2,0,27,28,5,2,0,0,28,30,3,4,2,0,29,27,1,0,0,0,30,33,1,0,0,0,
      31,29,1,0,0,0,31,32,1,0,0,0,32,35,1,0,0,0,33,31,1,0,0,0,34,36,5,2,
      0,0,35,34,1,0,0,0,35,36,1,0,0,0,36,37,1,0,0,0,37,38,5,3,0,0,38,84,
      1,0,0,0,39,40,5,1,0,0,40,45,3,4,2,0,41,42,5,4,0,0,42,44,3,4,2,0,43,
      41,1,0,0,0,44,47,1,0,0,0,45,43,1,0,0,0,45,46,1,0,0,0,46,49,1,0,0,0,
      47,45,1,0,0,0,48,50,5,4,0,0,49,48,1,0,0,0,49,50,1,0,0,0,50,51,1,0,
      0,0,51,52,5,3,0,0,52,84,1,0,0,0,53,54,5,1,0,0,54,59,3,4,2,0,55,56,
      5,4,0,0,56,58,3,4,2,0,57,55,1,0,0,0,58,61,1,0,0,0,59,57,1,0,0,0,59,
      60,1,0,0,0,60,63,1,0,0,0,61,59,1,0,0,0,62,64,5,2,0,0,63,62,1,0,0,0,
      63,64,1,0,0,0,64,65,1,0,0,0,65,66,5,3,0,0,66,84,1,0,0,0,67,68,5,1,
      0,0,68,73,3,4,2,0,69,70,5,2,0,0,70,72,3,4,2,0,71,69,1,0,0,0,72,75,
      1,0,0,0,73,71,1,0,0,0,73,74,1,0,0,0,74,77,1,0,0,0,75,73,1,0,0,0,76,
      78,5,4,0,0,77,76,1,0,0,0,77,78,1,0,0,0,78,79,1,0,0,0,79,80,5,3,0,0,
      80,84,1,0,0,0,81,82,5,1,0,0,82,84,5,3,0,0,83,25,1,0,0,0,83,39,1,0,
      0,0,83,53,1,0,0,0,83,67,1,0,0,0,83,81,1,0,0,0,84,3,1,0,0,0,85,86,3,
      6,3,0,86,87,5,5,0,0,87,88,3,8,4,0,88,5,1,0,0,0,89,90,7,0,0,0,90,7,
      1,0,0,0,91,98,3,12,6,0,92,98,3,18,9,0,93,98,3,2,1,0,94,98,3,10,5,0,
      95,98,3,14,7,0,96,98,3,16,8,0,97,91,1,0,0,0,97,92,1,0,0,0,97,93,1,
      0,0,0,97,94,1,0,0,0,97,95,1,0,0,0,97,96,1,0,0,0,98,9,1,0,0,0,99,100,
      5,6,0,0,100,105,3,8,4,0,101,102,5,2,0,0,102,104,3,8,4,0,103,101,1,
      0,0,0,104,107,1,0,0,0,105,103,1,0,0,0,105,106,1,0,0,0,106,109,1,0,
      0,0,107,105,1,0,0,0,108,110,5,2,0,0,109,108,1,0,0,0,109,110,1,0,0,
      0,110,111,1,0,0,0,111,112,5,7,0,0,112,158,1,0,0,0,113,114,5,6,0,0,
      114,119,3,8,4,0,115,116,5,4,0,0,116,118,3,8,4,0,117,115,1,0,0,0,118,
      121,1,0,0,0,119,117,1,0,0,0,119,120,1,0,0,0,120,123,1,0,0,0,121,119,
      1,0,0,0,122,124,5,2,0,0,123,122,1,0,0,0,123,124,1,0,0,0,124,125,1,
      0,0,0,125,126,5,7,0,0,126,158,1,0,0,0,127,128,5,6,0,0,128,133,3,8,
      4,0,129,130,5,4,0,0,130,132,3,8,4,0,131,129,1,0,0,0,132,135,1,0,0,
      0,133,131,1,0,0,0,133,134,1,0,0,0,134,137,1,0,0,0,135,133,1,0,0,0,
      136,138,5,4,0,0,137,136,1,0,0,0,137,138,1,0,0,0,138,139,1,0,0,0,139,
      140,5,7,0,0,140,158,1,0,0,0,141,142,5,6,0,0,142,147,3,8,4,0,143,144,
      5,2,0,0,144,146,3,8,4,0,145,143,1,0,0,0,146,149,1,0,0,0,147,145,1,
      0,0,0,147,148,1,0,0,0,148,151,1,0,0,0,149,147,1,0,0,0,150,152,5,4,
      0,0,151,150,1,0,0,0,151,152,1,0,0,0,152,153,1,0,0,0,153,154,5,7,0,
      0,154,158,1,0,0,0,155,156,5,6,0,0,156,158,5,7,0,0,157,99,1,0,0,0,157,
      113,1,0,0,0,157,127,1,0,0,0,157,141,1,0,0,0,157,155,1,0,0,0,158,11,
      1,0,0,0,159,160,5,14,0,0,160,13,1,0,0,0,161,162,7,1,0,0,162,15,1,0,
      0,0,163,164,5,10,0,0,164,17,1,0,0,0,165,167,5,17,0,0,166,165,1,0,0,
      0,166,167,1,0,0,0,167,168,1,0,0,0,168,169,7,2,0,0,169,19,1,0,0,0,21,
      21,31,35,45,49,59,63,73,77,83,97,105,109,119,123,133,137,147,151,157,
      166
  ];

  static final ATN _ATN =
      ATNDeserializer().deserialize(_serializedATN);
}
class Json5Context extends ParserRuleContext {
  TerminalNode? EOF() => getToken(JSON5Parser.TOKEN_EOF, 0);
  ValueContext? value() => getRuleContext<ValueContext>(0);
  Json5Context([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_json5;
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is JSON5Visitor<T>) {
     return visitor.visitJson5(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ObjectContext extends ParserRuleContext {
  List<PairContext> pairs() => getRuleContexts<PairContext>();
  PairContext? pair(int i) => getRuleContext<PairContext>(i);
  ObjectContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_object;
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is JSON5Visitor<T>) {
     return visitor.visitObject(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class PairContext extends ParserRuleContext {
  KeyContext? key() => getRuleContext<KeyContext>(0);
  ValueContext? value() => getRuleContext<ValueContext>(0);
  PairContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_pair;
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is JSON5Visitor<T>) {
     return visitor.visitPair(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class KeyContext extends ParserRuleContext {
  TerminalNode? STRING() => getToken(JSON5Parser.TOKEN_STRING, 0);
  TerminalNode? IDENTIFIER() => getToken(JSON5Parser.TOKEN_IDENTIFIER, 0);
  TerminalNode? LITERAL() => getToken(JSON5Parser.TOKEN_LITERAL, 0);
  TerminalNode? NUMERIC_LITERAL() => getToken(JSON5Parser.TOKEN_NUMERIC_LITERAL, 0);
  KeyContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_key;
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is JSON5Visitor<T>) {
     return visitor.visitKey(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ValueContext extends ParserRuleContext {
  StringContext? string() => getRuleContext<StringContext>(0);
  NumberContext? number() => getRuleContext<NumberContext>(0);
  ObjectContext? object() => getRuleContext<ObjectContext>(0);
  ArrayContext? array() => getRuleContext<ArrayContext>(0);
  BoolContext? bool() => getRuleContext<BoolContext>(0);
  NullContext? null_() => getRuleContext<NullContext>(0);
  ValueContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_value;
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is JSON5Visitor<T>) {
     return visitor.visitValue(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ArrayContext extends ParserRuleContext {
  List<ValueContext> values() => getRuleContexts<ValueContext>();
  ValueContext? value(int i) => getRuleContext<ValueContext>(i);
  ArrayContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_array;
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is JSON5Visitor<T>) {
     return visitor.visitArray(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class StringContext extends ParserRuleContext {
  TerminalNode? STRING() => getToken(JSON5Parser.TOKEN_STRING, 0);
  StringContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_string;
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is JSON5Visitor<T>) {
     return visitor.visitString(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class BoolContext extends ParserRuleContext {
  BoolContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_bool;
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is JSON5Visitor<T>) {
     return visitor.visitBool(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class NullContext extends ParserRuleContext {
  NullContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_null;
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is JSON5Visitor<T>) {
     return visitor.visitNull(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class NumberContext extends ParserRuleContext {
  TerminalNode? NUMERIC_LITERAL() => getToken(JSON5Parser.TOKEN_NUMERIC_LITERAL, 0);
  TerminalNode? NUMBER() => getToken(JSON5Parser.TOKEN_NUMBER, 0);
  TerminalNode? SYMBOL() => getToken(JSON5Parser.TOKEN_SYMBOL, 0);
  NumberContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_number;
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is JSON5Visitor<T>) {
     return visitor.visitNumber(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

