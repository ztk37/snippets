for file in ./*.hs; do
    hlint $file --refactor
done