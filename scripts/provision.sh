#ITP_REPO_URL="https://github.com/Mozilla-TWQA/MozITP"
ITP_REPO_URL=$1
sudo apt-get update
sudo apt-get install -y git
sudo ssh-keyscan github.com >> ~/.ssh/known_hosts
rm -rf MozITP # Cleanup old rep
git clone $ITP_REPO_URL #TODO: Do we need special folder

