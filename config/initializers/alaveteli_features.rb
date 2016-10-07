# Set up our available features and (optionally) get some defaults for
# them from the config/general.yml configuration.

# See Flipper's documentation for further examples of how you can enable
# and disable features, noting that (depending on the adapter used) there
# might well be settings stored in other places (the db, caches, etc) that
# you need to respect.
# https://github.com/jnunemaker/flipper/blob/master/lib/flipper/dsl.rb

# Annotations
# We enable annotations globally based on the ENABLE_ANNOTATIONS config
if AlaveteliConfiguration.enable_annotations
  AlaveteliFeatures.backend.enable(:annotations)
else
  AlaveteliFeatures.backend.disable(:annotations)
end
