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

module WhatCounts
  class Helper
    class << self
      def parseData(data)
        temp1 = []
        temp2 = []
        data.each do |k,v|
          temp1 << k
          temp2 << v
        end
        return temp1.join(",") << "^" << temp2.join(",")
      end

      def symbolize(fields)
        data_keys = []
        fields.each do |data_type|
          data_keys << data_type.downcase.gsub(/\s+/,"_").to_sym
        end
        return data_keys
      end

      def strip_bom(contents)
        return contents.gsub(/^\357\273\277/,"")
      end

      def response_id(text)
        if text.match(/^SUCCESS/).nil?
          return -1
        else
          return text.split(' ')[1].to_i
        end
      end
    end
  end
end
