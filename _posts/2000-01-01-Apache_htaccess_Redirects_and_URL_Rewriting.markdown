### Redirect to a subdomain

`Options +FollowSymLinks`\
`RewriteEngine on`\
`rewritecond %{HTTP_HOST} ^(www\.)?xkyle\.com`\
`rewritecond %{REQUEST_URI} !/folder/`\
`RewriteRule (.*) /folder/$1 [R=301,L]`

### Rewrite http to https

`RewriteEngine On`\
`RewriteCond %{HTTPS} off`\
`RewriteRule (.*) `[`https://`](https://)`%{HTTP_HOST}%{REQUEST_URI} [R,L]`

### 301 Redirect to a Canonical Name (adding www)

`RewriteEngine On`\
`RewriteCond %{HTTP_HOST} ^domain\.com`\
`RewriteRule ^(.*)$ `[`http://www.domain.com/$1`](http://www.domain.com/$1)` [R=301,L] `

### 301 Redirect to a Canonical Name (stripping www)

`RewriteEngine On`\
`RewriteCond %{HTTP_HOST} ^www\.domain\.com`\
`RewriteRule ^(.*)$ `[`http://domain.com/$1`](http://domain.com/$1)` [R=301,L]`

### Simple Redirects with no "RewriteEngine" required

The redirect command works based off of prefixes:
<http://httpd.apache.org/docs/current/mod/mod_alias.html#redirect>
redirect 301 /old/old.htm <http://www.you.com/new.htm> Redirect
everything: redirect 301 / <http://newpage.com> For regex, you need to
use RedirectMatch. See this example that redirects only the home page:
RedirectMatch 301 \^/\$ <https://wiki.xkyle.com/Personal_Kickstart>

External Links
--------------

-   Official Apache [URL Rewriting
    Guide](http://httpd.apache.org/docs/2.0/misc/rewriteguide.html)

<Category:Apache>
