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

# AlaveteliPro
# We enable alaveteli pro generally based on the ENABLE_ALAVETELI_PRO config
# setting, further features *of* alaveteli pro can then be enabled directly
# in this initializer.
if AlaveteliConfiguration.enable_alaveteli_pro
  AlaveteliFeatures.backend.enable(:alaveteli_pro)
else
  AlaveteliFeatures.backend.disable(:alaveteli_pro)
end

# e.g.
# if AlaveteliFeatures.backend.enabled?(:alaveteli_pro)
#   # Define a group of users that we can use to scope features to
#   # We might want more specific groups too, or groups based on other
#   # resources (such as requests made by pro users)
#   begin
#     AlaveteliFeatures.backend.group(:pro_users)
#   rescue Flipper::GroupNotRegistered
#     Flipper.register :pro_users do |actor|
#       actor.respond_to?(:pro?) && actor.pro?
#     end
#   end
#
#   # New pro signup/account features
#   AlaveteliFeatures.backend.enable(:pro_accounts)
#   # Pro marketing pages/upsells
#   AlaveteliFeatures.backend.enable(:pro_marketing)
#   # Embargoing requests
#   AlaveteliFeatures.backend.enable_group(:embargoed_requests, :pro_users)
#   # Bulk requesting
#   AlaveteliFeatures.backend.enable_group(:bulk_requesting, :pro_users)
#   # Repeat requests
#   AlaveteliFeatures.backend.enable_group(:repeat_requests, :pro_users)
#   # Automatic response classification
#   AlaveteliFeatures.backend.enable_group(:response_classification, :pro_users)
# end