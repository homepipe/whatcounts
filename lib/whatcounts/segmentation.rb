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
  class Segmentation
    class << self
      def create(fields)
        fields[:c] = "createtemplate"
        constraints = WhatCounts::Constraint.new(fields[:c],[:segmentation_name, :segmentation_type, :list_id, :rules, :description, :operator_type], [:segmentation_name, :segmentation_type, :list_id, :rules])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end
      
      def show_all(fields = {})
        fields[:c] = "show_seg"
        constraints = WhatCounts::Constraint.new(fields[:c],[:output_format,:headers],[])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end

      def update(fields)
        fields[:c]="updateseg"
        constraints = WhatCounts::Constraint.new(fields[:c],[:segmentation_type,:segmentation_id,:segmentation_name,:operator_type,:rules,:description],[:segmentation_type,:segmentation_id,:segmentation_name,:operator_type,:rules])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end
      
      def delete(fields)
        fields[:c] = "deleteseg"
        constraints = WhatCounts::Constraint.new(fields[:c],[:list_id,:segmentation_id],[:list_id,:segmentation_id])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end
      
      def test(fields)
        fields[:c] = "testseg"
        constraints = WhatCounts::Constraint.new(fields[:c],[:list_id,:segmentation_id],[:list_id,:segmentation_id])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end

    end
  end
end
