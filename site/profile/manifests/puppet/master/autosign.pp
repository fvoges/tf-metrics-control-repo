class profile::puppet::master::autosign (
  Variant[String,Array] $password_list,
  String                $loglevel       = 'INFO',
) {
  class { '::autosign':
    ensure => 'latest',
    config => {
      'general'       => {
        'loglevel' => $loglevel,
      },
      'password_list' => $password_list,
    },
    before => Ini_setting['policy-based autosigning'],
  }

  ini_setting { 'policy-based autosigning':
    setting => 'autosign',
    path    => "${::confdir}/puppet.conf",
    section => 'master',
    value   => '/opt/puppetlabs/puppet/bin/autosign-validator',
    notify  => Service['pe-puppetserver'],
  }

}
