#### Convert to a Bare Repository

`git config --bool core.bare true`\
`# Then remove all but the .git folder`\
`cd yourrepo && rm -rf`

#### Prune all merged branches

`git branch --merged | grep -v "\*" | xargs -n 1 git branch -d`

<Category:Git>
