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
  class Template
    class << self 
      def create(fields, from_file=true)
        fields[:c] = "createtemplate"
        constraints = WhatCounts::Constraint.new(fields[:c],[:template_name, :template_subject, :template_body_plain, :template_body_html, :charset, :encoding], [:template_name, :template_subject])
        constraints.check(fields)
        if from_file
          WhatCounts::Helper.response_id(WhatCounts::HttpApi.execute(fields,[:template_body_html,:template_body_plain]))
        else
          WhatCounts::Helper.response_id(response = WhatCounts::HttpApi.execute(fields))
        end
      end
 
      def show_all(fields = {})
        fields[:c]="show_templates"
        constraints = WhatCounts::Constraint.new(fields[:c],[:output_format,:headers],[])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end

      def update(fields, from_file=true)
        fields[:c]="updatetemplate"
        constraints = WhatCounts::Constraint.new(fields[:c],[:template_name,:subject, :template_body_plain,:template_body_html],[:template_name])
        constraints.check(fields)
        if from_file
           WhatCounts::Helper.response_id(WhatCounts::HttpApi.execute(fields,[:template_body_html,:template_body_plain]))
        else
           WhatCounts::Helper.response_id(WhatCounts::HttpApi.execute(fields))
        end
      end

      def preview(fields)
        fields[:c]="templatepreview"
        constraints = WhatCounts::Constraint.new(fields[:c],[:template_name,:template_type],[:template_name, :template_type])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end

      def preview_url()
        
      end
    end
  end
end
