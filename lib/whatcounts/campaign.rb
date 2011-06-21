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
  class Campaign
    class << self
      def launch(fields,withcount=false)
        if withcount
          fields[:c]="launchwithcount"
        else
          fields[:c]="launch"
        end
        constraints = WhatCounts::Constraint.new(fields[:c],[:list_id,:template_id,:subject,:segmentation_id,:format,:campaign_alias,:target_rss,:vmta,:return_task_id,:notify_email], [:format, :list_id])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)    
      end
      
      def show(fields)
        fields[:c]="show_campaigns"
        constraints=WhatCounts::Constraint.new(fields[:c],[:count,:output_format,:headers],[:count])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end
      
      def report(fields)
        fields[:c]="rpt_campaign_list"
        constraints=WhatCounts::Constraint.new(fields[:c],[:from_date,:to_date,:show_hidden,:output_format,:headers],[:from_date,:to_date])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end
      
      def send_one(fields, from_file=true)
        fields[:c]="send"
        constraints = WhatCounts::Constraint.new(fields[:c],[:list_id,:to,:cc,:bcc,:from,:reply_to_address,:errors_to, :sender, :dup, :ignore_optout, :vmta, :body, :plain_text_body,:html_body,:charset, :data, :template_id,:subject,:format], [:format, :list_id])
        constraints.check(fields)
        if from_file
          WhatCounts::HttpApi.execute(fields,[:plain_text_body,:html_body])
        else
          WhatCounts::HttpApi.execute(fields)
        end
      end

    end
  end
end
