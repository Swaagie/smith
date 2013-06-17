# Smith

Show the name of the current/working git repository + branch as terminal title.
If you like to work with terminal tabs, this repository is ment for you! It will
increase your workflow and provide an overview of the active repository. That's all!

## Features

- Loops parent directories until a suitable `.git` subdirectory is found
- No commands need to be executed, hooks in `PROMPT_COMMAND`
- Also overloads the `cd` command to change the title

## Installation

Simply add the following lines to your `.bashrc` or `.bash_profile` depending on
the defaults for your OS. Make sure to point to the executable bash script. For
example, `source $HOME/projects/smith/smith.sh`

```
source [path/to/project/smith.sh]
```

## License

MIT
