---
categories:
 - ERB
---
A tag with an equals sign indicates that enclosed code is an expression,
and that the renderer should substitute the code element with the result
of the code (as a string) when it renders the template. Use an
expression to embed a line of code into the template, or to display the
contents of a variable:

`Hello, <%= @name %>.`\
`Today is <%= Time.now.strftime('%A') %>.`

Comment markers use a hash sign:

`<%# This is just a comment %>`

