import os
from AutotoolsBuilder import AutotoolsBuilder

class GlibBuilder(AutotoolsBuilder):
    def init(self, config_dir=None, source_dir=None):
        super(GlibBuilder, self).init(config_dir, source_dir)
        pkg_config_path = os.path.join(self.getConfiguredInstallDir(),
                                      "lib",
                                      "pkgconfig")
        self._add_extra_env({"PKG_CONFIG_PATH": pkg_config_path})

def get_builder():
    extra_env = {"NOCONFIGURE" : "1"}
    return GlibBuilder(get_default_config_opts(), extra_env=extra_env)

def get_default_config_opts():
    try:
        import configure_opts
    except ImportError:
        return None
    else:
        return configure_opts.default_opts
