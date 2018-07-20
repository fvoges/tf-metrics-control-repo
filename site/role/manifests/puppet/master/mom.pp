class role::puppet::master::mom {

  include ::profile::puppet::master::autosign
  include ::profile::puppet::master::metrics_collector
  include ::profile::puppet::master::metrics_dashboard
}
