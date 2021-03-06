class profile::puppet::master::metrics_dashboard (
  String $grafana_password = 'admin',
) {
  $nodes_query = 'inventory[certname] {
    trusted.extensions.pp_role = "puppet::master"
    or
    trusted.extensions.pp_role = "puppet::master::mom"
    or
    trusted.extensions.pp_role = "puppet::master::cm"
  }'

  $nodes = puppetdb_query($nodes_query).map |$value| { $value["certname"] }

  class { '::puppet_metrics_dashboard':
    grafana_password       => $grafana_password,
    use_dashboard_ssl      => true,
    add_dashboard_examples => true,
    overwrite_dashboards   => false,
    master_list            => $nodes,
    influxdb_database_name => ['puppet_metrics','telegraf','graphite'],
    consume_graphite       => true,
  }
}
