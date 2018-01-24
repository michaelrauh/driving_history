ruby run.rb data/example_input.txt > data/result.txt

if cmp data/result.txt data/example_output.txt > /dev/null 2>&1
then
  rm data/result.txt && exit 0
else
  rm data/result.txt && exit 1
fi
