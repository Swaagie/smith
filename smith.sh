#!/bin/bash

function gitName {
  DIRECTORY='/.git'
  CURRENT=`pwd`

  until [ $CURRENT = '/' ]
  do
    if [ -d "$CURRENT$DIRECTORY" ]; then
      NAME=$(basename $(git remote show -n origin | grep Fetch | cut -d: -f2-))
      echo -ne "\033]0; $NAME\007"
      break
    fi

    CURRENT=$(dirname $CURRENT)
  done
}

function cd {
  builtin cd "$@"

  gitName
}

export PROMPT_COMMAND=gitName
