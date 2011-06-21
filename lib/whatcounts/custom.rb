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
  class Custom
    class << self
      def create(fields)
        fields[:c]="customfieldcreate"
        constraints = WhatCounts::Constraint.new(fields[:c],[:description,:fieldname,:fieldtype],[:description,:fieldname,:fieldtype])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end
      
      def delete(fields)
        fields[:c]="customfielddelete"
        constraints = WhatCounts::Constraint.new(fields[:c],[:fieldname],[:fieldname])
      end
    end
  end
end
