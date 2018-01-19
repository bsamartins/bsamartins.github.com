git config --global user.name $GIT_NAME
git config --global user.email $GIT_EMAIL
git config --global push.default simple

bundle exec jekyll build
ls -la

git add --all -f _site;
git commit -m 'Updating to ${TRAVIS_REPO_SLUG}@#{sha}.';

# Get the deploy key by using Travis's stored variables to decrypt deploy_key.enc
ENCRYPTED_KEY_VAR="encrypted_${ENCRYPTION_LABEL}_key"
ENCRYPTED_IV_VAR="encrypted_${ENCRYPTION_LABEL}_iv"
ENCRYPTED_KEY=${!ENCRYPTED_KEY_VAR}
ENCRYPTED_IV=${!ENCRYPTED_IV_VAR}
openssl aes-256-cbc -K $ENCRYPTED_KEY -iv $ENCRYPTED_IV -in deploy_key.enc -out deploy_key -d
chmod 600 deploy_key
eval `ssh-agent -s`
ssh-add deploy_key

git push origin ${TRAVIS_BRANCH};

echo "Pushed updated branch ${TRAVIS_BRANCH} to GitHub Pages"