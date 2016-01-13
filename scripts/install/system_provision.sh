export LC_ALL="en_US.UTF-8";

ITP_REPO_URL=$1
MOZITP="/home/vagrant/MozITP"

${MOZITP}/util/onceaday.py "sudo apt-get update; sudo apt-get install -y git; sudo ssh-keyscan github.com >> ~/.ssh/known_hosts"
