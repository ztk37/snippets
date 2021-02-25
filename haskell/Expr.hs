data Expr
  = Literal Int
  | Plus Expr Expr
  | Mult Expr Expr
  | Div Expr Expr
  deriving (Show, Eq, Ord)

eval :: Expr -> Int
eval (Literal n) = n
eval (Plus x y) = eval x + eval y
eval (Mult x y) = eval x * eval y
eval (Div x y) = eval x - eval y

plus e1 e2 = Plus (eval e1) (eval e2)

anExpr :: Expr
anExpr = (Div
          (Plus
            ((Mult
              (Literal 5)
              (Li
