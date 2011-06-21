#     Copyright (C) 2011 HomePipe Networks, Inc.
#     Author: Lucia Huntting <luciamkh@gmail.com>
#     This file is part of the HomePipe WhatCounts Gem.

#     The HomePipe WhatCounts Gem is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.

#     The HomePipe WhatCounts Gem is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.

#     You should have received a copy of the GNU General Public License
#     along with the HomePipe WhatCounts Gem.  If not, see <http://www.gnu.org/licenses/>.

require 'curb'

module WhatCounts
  class HttpApi
    class Unconfigured < StandardError; end

    class << self
      def setup(realm,pass)
        @config = Config.new(realm,pass)
      end
    
      def execute(fields, file_fields = [])
        raise WhatCountsError, "WhatCounts has not been configured" unless @config
        fields[:r] = @config.realm
        fields[:p] = @config.pass
        post_data = fields.map {|k, v| Curl::PostField.content(k.to_s,v.to_s) unless file_fields.include? k}
        file_fields.each do |f|
          if !fields[f].nil?
            post_data << Curl::PostField.content(f,File.read(fields[f])) unless !File.exists? fields[f]
          end
        end
        c=Curl::Easy.http_post(@config.base_url, post_data)
        c.body_str
      end
      
    end
    
    private
    class Config
      attr_accessor :base_url, :realm, :pass
      def initialize(realm, pass)
        @base_url = "http://api.whatcounts.com/bin/api_web?"
        @realm = realm
        @pass = pass
      end
    end

  end
end
