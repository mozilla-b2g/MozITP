export LC_ALL="en_US.UTF-8";

ITP_REPO_URL=$1
MOZITP=$(dirname $(dirname $(dirname $0)))

${MOZITP}/util/onceaday.py "sudo apt-get update; sudo apt-get install -y git; sudo ssh-keyscan github.com >> ~/.ssh/known_hosts"

# libgtk-3-0: for running Firefox (Mulet)
# clang: for building sockit-to-me
# pcregrep: for parsing the xunit test report
${MOZITP}/util/onceaday.py "sudo apt-get install -y build-essential libssl-dev \
  libgtk-3-0 \
  libasound2 \
  libgtk2.0-0 \
  clang \
  pcregrep \
  libfontconfig1 \
  libgtk2.0-0"

# Xvfb
${MOZITP}/util/onceaday.py "sudo apt-get install -y xvfb"
