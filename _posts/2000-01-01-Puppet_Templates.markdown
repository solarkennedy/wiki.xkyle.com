---
categories:
 - ERB
 - Puppet
---
Puppet templates are written in <ERB>.

#### Manifest Definition

    file { "yack-bla":
      content => template("bla/yack.erb"),
    }

Puppet will automatically look in your templates directory.

#### The Template

    <% if @myvar %>
    myvar has <%= @myvar %> value
    <% end %>

#### ERB Tags

See <ERB>

