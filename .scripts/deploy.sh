set -e

bundle exec jekyll build

git add --all -f _site/
git commit -m 'Updating.'

git remote add origin-pages "https://${GH_TOKEN}@github.com/${TRAVIS_REPO_SLUG}"
git push

echo "Pushed updated branch to GitHub Pages"
