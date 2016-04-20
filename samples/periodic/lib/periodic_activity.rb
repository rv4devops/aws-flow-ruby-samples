# Copyright 2014-2016 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You
# may not use this file except in compliance with the License. A copy of
# the License is located at
#
#     http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is
# distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
# ANY KIND, either express or implied. See the License for the specific
# language governing permissions and limitations under the License.

require_relative '../periodic_utils'

# PeriodicActivity class defines a set of activities for the Periodic sample.
class PeriodicActivity
  extend AWS::Flow::Activities

  # The activity method is used to define activities. It accepts a list of names
  # of activities and a block specifying registration options for those
  # activities
  activity :do_some_work do
    {
      version: PeriodicUtils::ACTIVITY_VERSION,
      default_task_list: PeriodicUtils::ACTIVITY_TASKLIST,
      default_task_schedule_to_start_timeout: 30,
      default_task_start_to_close_timeout: 30
    }
  end

  def do_some_work
    # We can use the activity_execution_context method which is available to all
    # classes that extend AWS::Flow::Activities to get the workflow_execution.
    runid = activity_execution_context.workflow_execution.run_id
    puts "Run Id:#{runid}"
    puts "Running a periodic task here for #{sleep Random.rand(3)} second(s)"
  end
end

# Start an ActivityWorker to work on the PeriodicActivity tasks
PeriodicUtils.new.periodic_activity_worker.start if $0 == __FILE__
