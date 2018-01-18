#############################################################################
#
# Modified version of jekyllrb Rakefile
# https://github.com/jekyll/jekyll/blob/master/Rakefile
#
#############################################################################

require 'rake'
require 'date'

REPO_SLUG = ENV["TRAVIS_REPO_SLUG"]
SOURCE_BRANCH = ENV["TRAVIS_BRANCH"]
DESTINATION_BRANCH = ENV["TRAVIS_BRANCH"]
DEST_DIR = "pages"

puts "Source Branch: #{SOURCE_BRANCH}"
puts "Destination Branch: #{DESTINATION_BRANCH}"
puts "Destination: #{DEST_DIR}"

def check_destination
  unless Dir.exist? DEST_DIR
    sh "git clone https://$GIT_NAME:$GH_TOKEN@github.com/#{REPO_SLUG}.git #{DEST_DIR}"
  end
end

namespace :site do
  desc "Generate the site and push changes to remote origin"
  task :deploy do
    # Detect pull request
    if ENV['TRAVIS_PULL_REQUEST'].to_s.to_i > 0
      puts 'Pull request detected. Not proceeding with deploy.'
      exit
    end

    # Configure git if this is run in Travis CI
    if ENV["TRAVIS"]
      sh "git config --global user.name $GIT_NAME"
      sh "git config --global user.email $GIT_EMAIL"
      sh "git config --global push.default simple"
    end

    # Make sure destination folder exists as git repo
    check_destination

    sh "git checkout #{SOURCE_BRANCH}"
    Dir.chdir(DEST_DIR) { sh "git checkout #{DESTINATION_BRANCH}" }

    # Generate the site
    sh "bundle exec jekyll build"

    # Commit and push to github
    sha = `git log`.match(/[a-z0-9]{40}/)[0]
    Dir.chdir(DEST_DIR) do
      # check if there is anything to add and commit, and pushes it
      sh "if [ -n '$(git status)' ]; then
            git add --all -f _site;
            git commit -m 'Updating to #{REPO_SLUG}@#{sha}.';
            git push origin #{DESTINATION_BRANCH};
         fi"
      puts "Pushed updated branch #{DESTINATION_BRANCH} to GitHub Pages"
    end
  end
end