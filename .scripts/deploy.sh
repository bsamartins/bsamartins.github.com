bundle exec jekyll build

git add --all -f _site/
git commit -m 'Updating.'

git push "https://${GH_TOKEN}@github.com/${TRAVIS_REPO_SLUG}"

echo "Pushed updated branch to GitHub Pages"
