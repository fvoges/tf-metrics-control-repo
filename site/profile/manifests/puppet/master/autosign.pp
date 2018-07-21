class profile::puppet::master::autosign (
  String $shared_secret,
  String $loglevel       = 'info',
) {
  class { '::autosign':
    ensure => 'latest',
    config => {
      'general'       => {
        'loglevel' => $loglevel,
      },
      'password_list' => {
        'password' => $shared_secret,
      }
    },
    before => Ini_setting['policy-based autosigning'],
  }

  ini_setting { 'policy-based autosigning':
    setting => 'autosign',
    path    => $::settings::config,
    section => 'master',
    value   => '/opt/puppetlabs/puppet/bin/autosign-validator',
  }

}
