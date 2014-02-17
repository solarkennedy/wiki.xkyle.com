---
categories:
 - Gitorious
 - Git
---
At the time of this writing, <Gitorious> doesn't have any web-based user
management systems.

All advanced user managmement is done by the console:

`cd /var/www/gitorious`\
`env RAILS_ENV=production ruby1.8 script/console`

### Make A User An Admin

`user = User.find_by_login "Username"  `\
`user.is_admin = true`\
`user.save!`

### Delete a user

`user = User.find_by_login "Username"  `\
`user.destroy`

