class wordpress::nginx(
  $cache = false,
) {
  package { "nginx": }
  service { "nginx":
    ensure     => "running",
    hasrestart => true,
    hasstatus  => true,
    require    => Package["nginx"]
  }
  file { "/etc/nginx/sites-available/default":
    content => template("wordpress/default-site.erb"),
    require => Package["nginx"],
    notify  => Service["nginx"]
  }
}
