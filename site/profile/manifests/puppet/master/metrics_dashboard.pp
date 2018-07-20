class profile::puppet::master::metrics_dashboard {
  $nodes_query = 'inventory[certname] {
    trusted.extensions.pp_role = "puppet::master"
    or
    trusted.extensions.pp_role = "puppet::master::mom"
    or
    trusted.extensions.pp_role = "puppet::master::cm"
  }'

  $nodes = puppetdb_query($nodes_query).map |$value| { $value["certname"] }

  class { '::puppet_metrics_dashboard':
    #use_dashboard_ssl      => true,
    add_dashboard_examples => true,
    master_list            => $nodes,
  }
}
