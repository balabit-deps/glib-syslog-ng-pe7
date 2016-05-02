from AutotoolsBuilder import AutotoolsBuilder

def get_builder():
    extra_env = {"NOCONFIGURE" : "1"}
    return AutotoolsBuilder(get_default_config_opts(), extra_env=extra_env)

def get_default_config_opts():
    try:
        import configure_opts
    except ImportError:
        return None
    else:
        return configure_opts.default_opts
