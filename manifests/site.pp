## site.pp ##

node default {
}

node 'proton' {
  include proton_server
}
