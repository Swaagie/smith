#!/bin/bash

function gitName {
  DIRECTORY='/.git'
  CURRENT=`pwd`

  #
  # Recursively run down directories until we find .git or are at `/`
  #
  unset TITLE
  until [ "$CURRENT" = '/' ]
  do
    if [ -d "$CURRENT$DIRECTORY" ]
    then
      NAME=$(basename $(git remote show -n origin | grep Fetch | cut -d: -f2-))
      BRANCH=$(basename $(git symbolic-ref HEAD))
      TITLE="\033]0; ${NAME%.git} ($BRANCH)\007"

      echo -ne $TITLE
      break
    fi

    CURRENT=$(dirname "$CURRENT")
  done

  # 
  # Restore to a default Terminal title.
  #
  if [ -z "$TITLE" ] 
  then
    echo -ne "\033]0; Terminal \007"
  fi
}

function cd {
  builtin cd "$@"
  gitName
}

export PROMPT_COMMAND=gitName
