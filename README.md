#MolySite

MolySite is a Ruby on Rails Application using RVM for Ruby Version Managment, and Bundler for Gem Dependency Management. For more indepth information about the development and philosophy of MolySite please reference the [github wiki page](https://github.com/MolyJamCollective/MolySite/wiki)

---
## Development Guidelines
Please take the utmost care when following these guidelines, as these act as a foundation for the projects development.

### Branching
MolySite uses the branching system as described by Vincent Driessen called ['A successful Git branching model'](http://nvie.com/posts/a-successful-git-branching-model/).

Please be careful as you take this branching policy in as habit, as once a commit is pushed to origin(github) its not fun to edit the history.

### Commits
Commit messages should avoid the use of past-tense. A commit does not Added files, a commit Adds a file. Commits should reflect actions as they happen, and not history.

---
## Quick Start Guide
Setup directions vary per platform, this following guide should walk through Unix based installs.

**Note:** While it is considered by to possible to do Rails development on Windows, its really not. What you can do is install a linux virtual machine and work out of that rather seamlessly.

### Install Git
```shell
# Make sure your system is up-to-date
sudo apt-get update
sudo apt-get upgrade

sudo apt-get install git
```

### Install RVM
```shell
sudo apt-get install curl
\curl https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer | bash -s stable
```
**Warning:** RVM may give you addition install instructions like modifing your ~/.bash_profile . Make sure you pay attention and do it. Then restart your terminal prompt to allow the newly install scripts to take effect.


The following command will give you a list of apt-get commands that you need to run inorder to install all the rvm dependencies.
```shell
rvm requirments
```

### Clone The Repo
Once the git repo is pulled, simply navigate to the repo. RVM should ask you if you want to accept the .rvmrc file, which will then trigger bundle install. Then make sure to switch the the develop branch and setup your default push behavior.
```shell
git clone https://github.com/MolyJamCollective/MolySite.git
cd MolySite
# > Yes to use rvmrc

git checkout develop
git push -u origin develop
# > Enter username
# > Enter password
```

### Setup Database
Now you must config and setup your database settings. Copy over the example configuration, edit it if necessary and allow rails to setup the database.
```shell
cp config/database.yml.example config/database.yml
# Edit config/database.yml if needed
rake db:setup
```

### Test Application
Everything should be up and working at this point, to start the rails app server run `rails s` and navigate to [http://localhost:3000/](http://localhost:3000/)
