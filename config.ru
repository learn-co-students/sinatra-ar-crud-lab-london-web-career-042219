require './config/environment'

begin
  fi_check_migration

  use Rack::MethodOverride # NEEDED for using PATCH, PUT and DELETE requests

  run ApplicationController
rescue ActiveRecord::PendingMigrationError => e
  warn e
  exit 1
end
