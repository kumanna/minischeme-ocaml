%token <int> INT
%token PLUS
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
  | LPAREN; PLUS; el = expr* ; RPAREN { Multiop (Add, el) }
  ;
