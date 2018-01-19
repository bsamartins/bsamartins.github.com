git config --global user.name $GIT_NAME
git config --global user.email $GIT_EMAIL
git config --global push.default simple

bundle exec jekyll build
ls -la

if [ -n '$(git status --ignored)' ]; then
  git add --all -f _site;
  git commit -m 'Updating to ${TRAVIS_REPO_SLUG}@#{sha}.';
  git push origin ${TRAVIS_BRANCH};
fi

echo "Pushed updated branch ${TRAVIS_BRANCH} to GitHub Pages"