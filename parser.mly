%token OPENPAREN
%token CLOSEPAREEN
%token <int> INT
%token PLUS
%token TIMES
%token EOF

%start <Ast.expr> prog

%%

prog:
  | e = expr; EOF { e }
  ;

expr:
  | i = INT { Int i }
  ;
