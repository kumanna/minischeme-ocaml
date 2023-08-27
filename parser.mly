%token <int> INT
%token <float> FLOAT
%token PLUS
%token MULT
%token MINUS
%token LPAREN
%token RPAREN
%token EOF

%start <Ast.expr> prog

%%

prog:
  | e = expr; EOF { e }
  ;

expr:
  | i = INT { Int i }
  | f = FLOAT { Float f }
  | LPAREN; PLUS; el = expr* ; RPAREN { Multiop (Add, el) }
  | LPAREN; MULT; el = expr* ; RPAREN { Multiop (Multiply, el) }
  | LPAREN; MINUS; e1 = expr; e2 = expr; RPAREN { Binop (Subtract, e1, e2) }
  ;
