# To use foreman, configure a .env file as follows:
#
# CLIENT_PATH=/path/to/client
task :start do
  exec 'foreman start -p 3000'
end
