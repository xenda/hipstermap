ENV['REDISTOGO_URL'] = "redis://yaraher:66788abaf8019a891bdee0c2a697a0b8@lab.redistogo.com:9130/"
REDIS = if ENV['REDISTOGO_URL']
          uri = URI.parse(ENV['REDISTOGO_URL'])
          Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
        else
          Object.new
        end

