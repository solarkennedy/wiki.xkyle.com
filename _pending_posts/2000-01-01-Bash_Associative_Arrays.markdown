---
categories:
 - Bash
---
#### Declaring:

`declare -A MyCoolHash`\
`MyCoolHash[key1]=value1`\
`MyCoolHash[key2]=value2`\
`MyCoolHash[foo]=bar`

#### Fetching:

`variable=${MyCoolHash[key1]}`

`for sound in "${!animals[@]}"`\
`  do echo "$sound - ${animals["$sound"]}"`\
`done`

`for value in ${hashmap[@]}`\
`  do something`\
`done`

`echo hashmap has ${#hashmap[@]} elements`

#### Setting:

`MyCoolHash[key2]=value2`

#### References

-   <http://www.linuxjournal.com/content/bash-associative-arrays>

