#!/bin/sh

# exit script, if error
set -e

# defne colors
RED=`tput setaf 1`
GREEN=`tput setaf 2`
NOCOLOR=`tput sgr0`


echo "${GREEN}===============================================================${NOCOLOR}"
echo "${GREEN}====== Running N42 Bootstrap Specialized (2018-04-03) =========${NOCOLOR}"
echo "${GREEN}===============================================================${NOCOLOR}"



installDependencyWithGem(){
  echo  ""
  echo  "${GREEN} MAYBE INSTALL $1 (GEM) ${NOCOLOR}";
  echo  "${GREEN} ALREADY INSTALLED?: ${NOCOLOR}"
  gem list -i $1 || gem install $1 || echo "${RED} FAILED TO INSTALL $1 ${NOCOLOR}";
}

installDependencyWithNpmGlobally(){
  echo  ""
  echo  "${GREEN} MAYBE INSTALL $1 (npm -g) ${NOCOLOR}";
  echo  "${GREEN} INSTALLED AT: ${NOCOLOR}"
  npm ls $1 --parseable=true --global=true || npm install -g $1 || echo "${RED} FAILED TO INSTALL $1 ${NOCOLOR}";
}


# =========================================+
# ========= PROJECT DEPENDENCIES  =========+
# =========================================+


# =========================+
# ======== FOREMAN ========+
# =========================+
installDependencyWithGem foreman


# =========================+
# ======== NETLIFY ========+
# =========================+
installDependencyWithNpmGlobally netlify-cli
