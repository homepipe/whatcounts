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

  class Subscriber
    class << self
      def change_email(old_email, new_email)
        fields = {:c=>"change",:email=>old_email, :email_new=>new_email}
        constraints = WhatCounts::Constraint.new(fields[:c],[:email,:email_new], [:email,:email_new])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end
      
      def optout_global(data)
        fields = {:c=>"unsub", :list=>0, :optout=>1, :data=> WhatCounts::Helper.parseData(data)}
        constraints = WhatCounts::Constraint.new(fields[:c],[:list_id,:optout,:data], [:list_id, :data])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end
      
      def delete(data)
        fields = {:c=>"delete", :data=> WhatCounts::Helper.parseData(data)}
        constraints = WhatCounts::Constraint.new(fields[:c],[:data], [:data])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end
      
      def find(fields = {})
        fields[:c]="find"
        constraints = WhatCounts::Constraint.new(fields[:c],[:email,:first, :last, :identity_field, :identity_value, :limit, :exact, :output_format, :headers], [])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end
      
      def details(fields)
        fields[:c]="detail"
        constraints = WhatCounts::Constraint.new(fields[:c],[:subscriber_id, :output_format, :headers], [:subscriber_id])
      end
      
    end
    
  end
end
