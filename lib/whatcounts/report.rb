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
  class Report
    class << self
      def campaign_stats(fields)
        fields[:c]="show_campaign_stats"
        constraints = WhatCounts::Constraint.new(fields[:c],[:campaign_id,:version,:output_format, :headers], [:campaign_id])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end
      
      def many_campaign_stats(fields)
        fields[:c]="show_campaign_stats_multi"
        constraints = WhatCounts::Constraint.new(fields[:c],[:campaigns,:version,:output_format, :headers], [:campaigns])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end
    
      def campaign_clicks(fields)
        fields[:c]="rpt_click_overview"
        constraints = WhatCounts::Constraint.new(fields[:c],[:campaign_id,:version,:output_format, :headers], [:campaign_id])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end
      
      def url_clicks(fields)
        fields[:c]="rpt_clicked_on"
        constraints = WhatCounts::Constraint.new(fields[:c],[:campaign_id,:version,:output_format, :headers, :url, :exact, :unique], [:campaign_id, :url])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)        
      end
      
      def daily_stats(fields)
        fields[:c]="rpt_daily_stats"
        constraints = WhatCounts::Constraint.new(fields[:c],[:campaign_id,:version,:output_format, :headers, :from_date, :to_date], [:campaign_id, :from_date, :to_date])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end
      
      def bounces(fields)
        fields[:c]="rpt_bounce_stats"
        constraints = WhatCounts::Constraint.new(fields[:c],[:campaign_id,:version,:output_format, :headers, :from_date, :to_date], [:campaign_id, :from_date, :to_date])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end
      
      def tracked_events(fields)
        fields[:c]="rpt_tracked_events"
        constraints = WhatCounts::Constraint.new(fields[:c],[:version,:output_format, :headers, :start_datetime, :end_datetime, :event_type, :offset], [:start_datetime, :end_datetime, :event_type, :offset])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end
      
      def campaign_tracked_events(fields)
        fields[:c]="rpt_tracked_events_by_campaign"
        constraints = WhatCounts::Constraint.new(fields[:c],[:campaign_id,:version,:output_format, :headers, :start_datetime, :end_datetime, :event_type, :offset], [:campaign_id, :start_datetime, :end_datetime, :event_type, :offset])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end   
    end
  end
end
