# To use foreman, create a Procfile
# in the project root with the following contents:
#
# web: cd <waldo-frontend-dir> && npm start
# api: bundle exec rails s -p 3001

task :start do
  exec 'foreman start -p 3000'
end
