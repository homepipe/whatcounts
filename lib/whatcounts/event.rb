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

module Whatcounts
  class Event
    class << self
      def user(fields)
        fields[:c] ="show_user_events"
        constraints = WhatCounts::Constraint.new(fields[:c],[:subscriber_id, :output_format,:headers],[:subscriber_id])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end

      def optouts(fields)
        fields[:c] ="show_opt"
        constraints = WhatCounts::Constraint.new(fields[:c],[:list_id, :days, :output_format,:headers],[:list_id, :days])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end

      def optouts_global(fields)
        fields[:c] ="show_optglobal"
        constraints = WhatCounts::Constraint.new(fields[:c],[:days, :output_format,:headers],[:days])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end

      def bounces_soft(fields)
        fields[:c] ="show_soft"
        constraints = WhatCounts::Constraint.new(fields[:c],[:list_id, :days, :output_format,:headers],[:list_id, :days])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end

      def bounces_hard(fields)
        fields[:c] ="show_hard"
        constraints = WhatCounts::Constraint.new(fields[:c],[:list_id, :days, :output_format,:headers],[:list_id, :days])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end

      def bounces_blocked(fields)
        fields[:c] ="show_block"
        constraints = WhatCounts::Constraint.new(fields[:c],[:list_id, :days, :output_format,:headers],[:list_id, :days])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end

      def bounces_complaint(fields)
        fields[:c] ="show_complaint"
        constraints = WhatCounts::Constraint.new(fields[:c],[:list_id, :days, :output_format,:headers],[:list_id, :days])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end

    end
  end
end
