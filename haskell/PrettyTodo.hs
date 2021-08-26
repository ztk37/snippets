module Main (main) where

data TodoPageData = TodoPageData
 { todoPageTitle :: String
 , todoPageTodos :: [Todo]
 } deriving (Eq , Show)

data Todo = Todo
  { todoTitle :: String
  , todoDone :: Bool
  } deriving (Eq , Show)

todoPageData :: TodoPageData
todoPageData =
  TodoPageData
    { todoPageTitle = "My TODO list"
    , todoPageTodos =
      [ Todo "Task 1" False
      , Todo "Task 2" True
      , Todo "Task 3" True
      ]
    }

prettyTodo :: Todo -> String
prettyTodo (Todo title True) = "- [x] " ++ title
prettyTodo (Todo title False) =  "- [ ] " ++ title

prettyTodoPageData :: TodoPageData -> String
prettyTodoPageData tpd = unlines
  [ todoPageTitle tpd
  , ""
  , unlines $ map prettyTodo $ todoPageTodos tpd
  ]

main :: IO ()
main = do
  print todoPageData
  putStr $ prettyTodoPageData todoPageData
