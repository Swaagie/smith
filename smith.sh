#!/bin/bash

function gitName {
  DIRECTORY='/.git'
  CURRENT=`pwd -P`

  #
  # Recursively run down directories until we find .git or are at `/`
  #
  unset TITLE
  until [ "$CURRENT" = '/' ]
  do
    if [ -d "$CURRENT$DIRECTORY" ]
    then
      NAME=$(basename $(git remote show -n origin | grep Push | cut -d: -f2-))
      BRANCH=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
      TOP=$(git rev-parse --show-toplevel)

      #
      # Submodules will have a different toplevel.
      #
      if [ -z "$TOP" ] || [ $TOP = $CURRENT ]
      then
        TITLE="\033]0; ${NAME%.git} ($BRANCH)\007"
      else
        TITLE="\033]0; $(basename "$CURRENT") (submodule: ${NAME%.git}) \007"
      fi

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
