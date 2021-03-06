class storm (
	$zookeeper_servers = [],
	$nimbus_host = undef,
    $supervisor_slots = [ 6700, 6701, 6702, 6703 ],
    $worker_mem = 1024
)
{
	
	class { 'storm::redhat': }

 	$config_dir	= '/opt/storm/conf'

 	file { "${config_dir}/storm.yaml" :
 		ensure	=> present,
 		owner	=> root,
 		content	=> template('storm/storm.yml.erb') ,
 		require => [Package['storm'], File['/var/cache/storm']],
 	}

    file { "/opt/storm/sysconfig/storm" :
     		ensure	=> present,
     		owner	=> root,
     		content	=> template('storm/sysconfig'),
     		require => [Package['storm']],
     	}

 	file { '/var/cache/storm':
 	    ensure  => directory,
 	    owner   => root,
 	    mode    => 770,
 	    require => Package['storm'],
     }
 }