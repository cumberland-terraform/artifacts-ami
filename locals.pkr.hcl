locals {
    # PLATFORM DEFAULTS
    ##   Configuration properties that are enforced
    platform_defaults               = {
        accounts                    = {
            canonical               = "099720109477"
        }
        associate_public_ip_address = true
        encrypt_boot                = true
        temporary_key_pair_type     = "ed25519"
        tags                        = {
            Platform                = "cumberland-cloud"
        }
    }

    # CONDITIONS
    ##  Conditions that change based on the input parameters
    conditions                      = {
        is_linux                    = strcontains(var.ami.name, "ubuntu")
    }

    # CALCULATED PROPERTIES
    ## Properties whose values changed based on input paramters
    name                            = join("-", [
                                        var.platform.client,
                                        var.platform.environment,
                                        "ubuntu", # TODO: parameterize
                                        "{{ timestamp }}"
                                    ])

    scripts                         = {
        linux                       = "${path.root}/scripts/linux/provisioner.sh"
        windows                     = "${path.root}/scripts/windows/provisioner.ps1"
    
    }

    usernames                       = {
        ubuntu                      = "ubuntu"
        windows                     = "windowssucks"
    }

    tags                            = merge({
        # TODO: parameterize OS, Version and Architecture somehow
        Architecture                = "AMD64"
        Base                        = "{{ .SourceAMIName }}"
        Created                     = "{{ .SourceAMICreationDate }}"
        Client                      = var.platform.client
        Environment                 = var.platform.environment
        OS                          = "Ubuntu"
        Version                     = "20.04"
    }, local.platform_defaults.tags)
}