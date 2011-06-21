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
  class Constraint
    def initialize(command,options,required)
      @command = command
      @options = options
      if !@options.include? :c
        @options << :c
      end
      @required = required
    end
    
    def check(options)
      options.each_key do |o| 
        raise UnknownOptionError, "Unknown option #{o}" unless @options.include? o
      end
      @required.each do |r|
        raise MissingRequiredOptionError, "Missing required option #{r}" unless options.has_key? r
      end
    end

  end
end
