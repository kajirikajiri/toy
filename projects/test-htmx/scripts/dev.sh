fswatch --event Updated _posts public | while read file; do
  scripts/build.sh "$file"
done
