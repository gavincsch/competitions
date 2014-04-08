set :domain, "glowtech"

set :user, "root"
server domain, :app, :web
role :db, domain, :primary => true

set :scm, :git
set :repository, "git@github.com:GavinCS/lead-gen.git"
set :branch, "master"