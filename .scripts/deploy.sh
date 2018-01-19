bundle exec jekyll build

git add --all -f _site
git commit -m 'Updating.'

git push origin master

echo "Pushed updated branch to GitHub Pages"
