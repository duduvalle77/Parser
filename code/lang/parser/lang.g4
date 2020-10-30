grammar lang;

@parser::header
{
    package lang.parser;
}

@lexer::header
{
    package lang.parser;
}

/*Regras da Gramatica*/

prog : ( data )* ( func )*;
data : DATA IDtype LBRACE ( decl )* RBRACE;
decl : (ID|IDtype) COLONCOLON type SEMI;
func : (ID|IDtype) LPAREN (params)? RPAREN (COLON type (COMMA type)*)? LBRACE ( cmd )* RBRACE;
params : (ID|IDtype) COLONCOLON type (COMMA (ID|IDtype) COLONCOLON type)*;
type : type LBRACK RBRACK
    | btype
    ;
btype : INT
    | CHAR
    | BOOL
    | FLOAT
    | IDtype
    ;
cmd : LBRACE ( cmd )* RBRACE
    | IF LPAREN exp RPAREN cmd
    | IF LPAREN exp RPAREN cmd ELSE cmd
    | ITERATE LPAREN exp RPAREN cmd
    | READ lvalue SEMI
    | PRINT exp SEMI
    | RETURN exp (COMMA exp)* SEMI
    | lvalue ASSIGN exp SEMI
    | (ID|IDtype) LPAREN (exps)? RPAREN (LT lvalue (COMMA lvalue)* CRETURN)? SEMI
    ;
exp : exp AND exp
    | rexp
    ;
rexp : aexp LT aexp
    | rexp EQUAL aexp
    | rexp NOTEQUAL aexp
    | aexp
    ;
aexp : aexp ADD mexp
    | aexp SUB mexp
    | mexp
    ;
mexp : mexp MUL sexp
    | mexp DIV sexp
    | mexp MOD sexp
    | sexp
    ;
sexp : BANG sexp
    | SUB sexp
    | TRUE
    | FALSE
    | NULL_LITERAL
    | INT_LITERAL
    | FLOAT_LITERAL
    | CHAR_LITERAL
    | pexp
    ;
pexp : lvalue
    | LPAREN exp RPAREN
    | NEW type (LBRACK exp RBRACK)?
    | (ID|IDtype) LPAREN (exps)? RPAREN LBRACK exp RBRACK
    ;
lvalue : (ID|IDtype)
    | lvalue LBRACK exp RBRACK
    | lvalue DOT (ID|IDtype)
    ;
exps : exp ( COMMA exp )*;

/*Regras lexicas*/

// Keywords

BOOL:               'Bool';
DATA:               'data';
CHAR:               'Char';
ELSE:               'else';
FLOAT:              'Float';
IF:                 'if';
INT:                'Int';
NEW:                'new';
RETURN:             'return';
ITERATE:            'iterate';
PRINT:              'print';
READ:               'read';

// Literals

INT_LITERAL : ('0'..'9')+ ;
FLOAT_LITERAL : ('0'..'9')* '.' ('0'..'9')+ ;
CHAR_LITERAL : '\'' (~['\\\r\n] | EscapeSequence) '\'';
NULL_LITERAL : 'null';
TRUE : 'true';
FALSE : 'false';

// Separators

LPAREN:             '(';
RPAREN:             ')';
LBRACE:             '{';
RBRACE:             '}';
LBRACK:             '[';
RBRACK:             ']';
SEMI:               ';';
COMMA:              ',';
DOT:                '.';
COLONCOLON:         '::';
COLON:              ':';
CRETURN:            '>';

// Operators

ASSIGN:             '=';
LT:                 '<';
BANG:               '!';
QUESTION:           '¿';
EQUAL:              '==';
NOTEQUAL:           '!=';
AND:                '&&';
ADD:                '+';
SUB:                '-';
MUL:                '*';
DIV:                '/';
MOD:                '%';

// Whitespace and comments

WS:                 [ \t\r\n\u000C]+ -> channel(HIDDEN);
COMMENT:            '{-' .*? '-}'    -> channel(HIDDEN);
LINE_COMMENT:       '--' ~[\r\n]*    -> channel(HIDDEN);

// Identifiers

ID : [a-z] [a-zA-Z0-9_]* ;
IDtype : [A-Z] [a-zA-Z0-9_]* ;


fragment EscapeSequence
    : '\\' [btnfr"'\\]
    | '\\' ([0-3]? [0-7])? [0-7]
    | '\\' 'u'+ HexDigit HexDigit HexDigit HexDigit
    ;

fragment HexDigit
    : [0-9a-fA-F]
    ;
