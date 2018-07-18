class profile::puppet::master::metrics_collector {

  $nodes_query = 'inventory[certname] {
    trusted.extensions.pp_role = "puppet::master"
    or
    trusted.extensions.pp_role = "puppet::cm"
  }'

  class { '::puppet_metrics_collector':
    puppetserver_hosts => puppetdb_query($nodes_query),
  }
}