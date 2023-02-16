grammar cobol;

// keywords
ACCEPT: 'ACCEPT';
ADD: 'ADD';
ALTER:'ALTER';
CALL:'CALL';
COPY:'COPY';
DATA_DIVISION:'DATA DIVISION';
DISPLAY:'DISPLAY';
DIVIDE:'DIVIDE';
DIVISION:'DIVISION';
EVALUATE:'EVALUATE';
GO_TO:'GO TO';
IDENTIFICATION_DIVISION: 'IDENTIFICATION DIVISION';
IF:'IF';
LOOP:'LOOP';
MOVE:'MOVE';
MULTIPLY:'MULTIPLY';
NEXT_SENTENCE:'NEXT SENTENCE';
SIGNAL:'SIGNAL';
STOP: 'STOP';
SUBTRACT: 'SUBTRACT';


Keywords: ACCEPT|ADD|ALTER|CALL|COPY|DATA_DIVISION|DISPLAY|DIVIDE|DIVISION|EVALUATE|
GO_TO|IDENTIFICATION_DIVISION|IF|LOOP|MOVE|MULTIPLY|NEXT_SENTENCE|SIGNAL|STOP|SUBTRACT;
// A valid COBOL word cannot start or end with a dash or underscore and must have at least one letter
COBOL_WORD: (DIGIT (DIGIT | [-_])*)? LETTER ([-_]* ALPHANUMERIC)*;

// A non-numeric literal can be delimited by a pair of apostrophes or quotes. Doubling a quote or apostrophe can escape it,
// and a non-numeric literal must have at least one character inside.
NONNUMERIC: '\'' (SPECIAL | LETTER | DIGIT | QUOTE | (APOST APOST))+ '\''
          | '"' (SPECIAL | LETTER | DIGIT | APOST | (QUOTE QUOTE))+ '"';

NUMERIC: FIXEDPOINT | FLOATINGPOINT;
FIXEDPOINT: SIGN? DIGIT+ ('.' DIGIT+)?;
FLOATINGPOINT: SIGN? DIGIT+ ('.' DIGIT+)? 'E' SIGN? DIGIT+;

// All valid characters in COBOL.
CHARACTER: SPECIAL | LETTER | DIGIT | APOST | QUOTE;
ALPHANUMERIC: LETTER | DIGIT;
LETTER: LOWERCASE | UPPERCASE;

SPECIAL: [ +\-*/=$,;.()><:_];
APOST: '\'';
QUOTE: '"';
SIGN: [+-];
DIGIT: [0-9];
LOWERCASE: [a-z];
UPPERCASE: [A-Z];
