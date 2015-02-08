desc "Start the server in development mode"
task :start => :environment do
  `open /Applications/Postgres.app`
  exec "RAILS_ENV=development foreman start -f ./Procfile.development"
end
