Bash completion rocks. Ubuntu does a great job of populating
/etc/bash\_completion.d/ with tons of glue to bash complete lots of
commands.

Here is how you can write your own for your own programs!:

### Example

    wa() { cd /some/dir/webapp/$1 ; }
    _webapp() {
        local cur
        cur=${COMP_WORDS[COMP_CWORD]}
        COMPREPLY=( $( compgen -S/ -d /some/dir/webapp/$cur | cut -b 18- ) )
    }
    complete -o nospace -F _webapp wa

### Explaination

You need: \* A bash function that will define a COMPREPLY variable.
Usually called \_\$PROGRAMNAME \* Logic inside that function to figure
out what to return for possible completions (using the compgen command,
usually) \* Use the "complete" command to register your tab completions
( complete -F \_mycommand mycommand ) \* Put this in a file in
/etc/bash\_completion.d/ \* source /etc/bash\_completion or re-login to
take effect.

### Compgen Details

    compgen: compgen [-abcdefgjksuv] [-o option]  [-A action] [-G globpat] [-W wordlist]  [-F function] [-C command] [-X filterpat] [-P prefix] [-S suffix] [word]
        Display possible completions depending on the options.
        
        Intended to be used from within a shell function generating possible
        completions.  If the optional WORD argument is supplied, matches against
        WORD are generated.
        
        Exit Status:
        Returns success unless an invalid option is supplied or an error occurs.

Not super helpful. Here is more more info at the manual:

-   <https://www.gnu.org/software/bash/manual/bash.html#Programmable-Completion-Builtins>

### References

-   <http://sixohthree.com/867/bash-completion>

<Category:Bash>
