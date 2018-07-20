class profile::puppet::master::metrics_collector {

  $nodes_query = 'inventory[certname] {
    trusted.extensions.pp_role = "puppet::master"
    or
    trusted.extensions.pp_role = "puppet::master::mom"
    or
    trusted.extensions.pp_role = "puppet::master::cm"
  }'

  $nodes = puppetdb_query($nodes_query).map |$value| { $value["certname"] }

  class { '::puppet_metrics_collector':
    puppetserver_hosts => $nodes,
  }
}