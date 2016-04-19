class zaydeploy ( $module_path     = "/tmp/docker_app_odoo") {

    ##################################
    # Load modules base

    exec { 'puppet-vcsrepo':
       command => "puppet module install --modulepath=$module_path puppetlabs/vcsrepo",
       onlyif => "test ! -d $module_path/vcsrepo",
       path    => ["/bin", "/sbin", "/usr/bin", "/usr/sbin"]
    }

    exec { 'puppet-docker':
        command => "puppet module install --modulepath=$module_path garethr-docker",
        onlyif => "test ! -d $module_path/docker",
        path    => ["/bin", "/sbin", "/usr/bin", "/usr/sbin"]
    }


    ##################################
    # Config Docker and docker-compose

    include docker

    exec { 'docker-compose':
        command => "curl -L https://github.com/docker/compose/releases/download/1.7.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose ; chmod +x /usr/local/bin/docker-compose",
        onlyif => "test ! -f /usr/local/bin/docker-compose",
        path    => ["/bin", "/sbin", "/usr/bin", "/usr/sbin"]
    }    

}
