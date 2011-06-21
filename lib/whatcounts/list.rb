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

require 'csv'

module WhatCounts
  class List
    class << self      
      def create(fields)
        fields[:c]="excreatelist"
        constraints = WhatCounts::Constraint.new(fields[:c],[:list_name, :description, :template_id,:from, :reply_to, :errors_to, :track_clicks, :track_opens], [:list_name, :from, :reply_to])
        constraints.check(fields)
        if fields[:track_clicks].nil?
          fields[:track_clicks] = 1
        end
        if fields[:track_opens].nil?
          fields[:track_opens] = 1
        end
        WhatCounts::Helper.response_id(WhatCounts::HttpApi.execute(fields))
      end
      
      def show_all(fields = {})
        fields[:c]="show_lists"
        constraints = WhatCounts::Constraint.new(fields[:c],[:output_format, :headers], [])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end
      
      def show_subscribers(fields)
        fields[:c]="rpt_subscribers_in_list"
        constraints = WhatCounts::Constraint.new(fields[:c],[:list_id,:offset,:output_format, :headers], [:list_id, :offset])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end
      
      def find_subscribers(fields)
        fields[:c]="findinlist"
        constraints = WhatCounts::Constraint.new(fields[:c],[:list_id,:email,:last, :limit,:exact,:output_format, :headers], [:list_id])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end
      
      def subscribe(fields,data)
        fields[:c]="sub"
        fields[:data] = WhatCounts::Helper.parseData(data)
        constraints = WhatCounts::Constraint.new(fields[:c],[:list_id,:force_sub,:format,:data], [:list_id, :data])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end

      def subscribe_many(fields, data, data_fields=[:email])
        fields[:c]="sub"
        constraints = WhatCounts::Constraint.new(fields[:c],[:list_id,:force_sub,:format,:data], [:list_id])
        temp1 = data_fields.join(",")
        count = 0 
        temp2 = []
        data.each do |d|
          count += 1
          temp3 = []
          data_fields.each do |df|
            temp3 << d[df]
          end
          temp2 << temp3.join(",")
          if count % 2000 == 0
            fields[:data] = temp1 + "^" + temp2.join("^")
            WhatCounts::HttpApi.execute(fields)
            temp2 = []
          end
        end
        fields[:data] = temp1 + "^" + temp2.join("^")
        WhatCounts::HttpApi.execute(fields)
      end

      def subscribe_many_csv(fields, csv_file, headers=0)
        people = File.read(csv_file).split(/\r|\n/)
        start = 0
        data = []
        if headers
          data_fields = WhatCounts::Helper.symbolize(people[0].split(/,/))
          start = 1
        else
          data_fields = [:email]
        end
        for i in (start..people.length - 1)
          temp = CSV.parse(people[i])[0]
          data_row = {}
          for j in (0..data_fields.length - 1)
            data_row[data_fields[j]] = temp[j] 
          end
          data << data_row
        end
        subscribe_many(fields, data, data_fields)
      end
      
      def unsubscribe(fields,data={})
        fields[:c]="unsub"
        fields[:data] = WhatCounts::Helper.parseData(data)
        constraints = WhatCounts::Constraint.new(fields[:c],[:list_id,:optout,:data], [:list_id, :data])
        constraints.check(fields)
        WhatCounts::HttpApi.execute(fields)
      end
    end
  end
end
