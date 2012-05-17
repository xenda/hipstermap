REDIS = if ENV['REDISTOGO_URL']
          uri = URI.parse(ENV['REDISTOGO_URL'])
          Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
        else
          Object.new
        end

