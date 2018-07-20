class profile::puppet::master::metrics_dashboard {
  class { '::puppet_metrics_dashboard':
    add_dashboard_examples => true,
  }
}
