grammar ParserRules;

specification: definition | definition* ;

definition: type_decl ';' | module ';';

module: 'module' ID '{' definition definition* '}';

type_decl: struct_type | 'struct' ID;

struct_type: 'struct' ID '{' member_list '}';

member_list: ( type_spec declarators ';' )*;

type_spec: scoped_name | base_type_spec | struct_type;

scoped_name: ('::')? ID ('::' ID )*;

base_type_spec: floating_pt_type|integer_type|'char'|'string'|'boolean';

floating_pt_type: 'float' | 'double' | 'long double';

integer_type: signed_int | unsigned_int;

signed_int: ('short'|'int16')
|('long'|'int32')
|('long' 'long'|'int64')
|'int8';

unsigned_int: ('unsigned''short'| 'uint16')
   | ('unsigned''long'| 'uint32')
   | ('unsigned' 'long' 'long' | 'uint64')
   | 'uint8';

declarators: declarator (',' declarator )*;

declarator: simple_declarator | array_declarator;

simple_declarator: ID ('=' or_expr)?;

array_declarator: ID '['or_expr']' ('=' exp_list )?;

exp_list: '[' or_expr ( ','or_expr )* ']';

or_expr: xor_expr ('|' xor_expr )*;

xor_expr: and_expr ('^' and_expr )*;

and_expr: shift_expr ('&' shift_expr )*;

shift_expr: add_expr ( ('>>' | '<<') add_expr  )*;

add_expr: mult_expr ( ('+' | '-') mult_expr )*;

mult_expr: unary_expr ( ('*' |'/'|'%') unary_expr )*;

unary_expr: ('-'|'+'|'~')?literal;

literal:   INTEGER | CHAR | STRING | BOOLEAN | FLOATING_PT;

BOOLEAN : 'TRUE' | 'true' | 'FALSE' | 'false';

EXPONENT : ('e' | 'E') ('+' | '-')? DIGIT+;

fragment
DIGIT : [0-9]+;

INTEGER_TYPR_SUFFIX : 'l' | 'L';

INTEGER : DIGIT+ INTEGER_TYPR_SUFFIX?;

fragment
DOT : '.';

FLOAT_TYPE_SUFFIX : 'f' | 'F' | 'd' | 'D';

FLOATING_PT : DIGIT+ DOT DIGIT* EXPONENT? FLOAT_TYPE_SUFFIX?
              | DOT DIGIT+ EXPONENT? FLOAT_TYPE_SUFFIX?
              | DIGIT+ EXPONENT FLOAT_TYPE_SUFFIX?
              | DIGIT+ EXPONENT? FLOAT_TYPE_SUFFIX;

fragment
LETTER : [a-z]|[A-Z];

UNDERLINE : '_';

ID : LETTER (UNDERLINE? (LETTER | DIGIT))*;


ESCAPE_SEQUENCE : '\\b' | '\\t' | '\\n' | '\\f' | '\\r' | '\\"' | '\\\'' | '\\';

CHAR : '\'' (ESCAPE_SEQUENCE | ~[\\'] | ~[\\]) '\'';

STRING: '"' (ESCAPE_SEQUENCE | ~[\\"] | ~[\\])* '"';

//跳过换行，空格及制表符
WS : (' '| '\t' | '\n' | '\r')+ -> skip;

