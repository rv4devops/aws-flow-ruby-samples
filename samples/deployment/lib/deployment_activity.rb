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

require_relative '../deployment_utils'

# DeploymentActivity class defines a set of activities for the Deployment sample
class DeploymentActivity
  extend AWS::Flow::Activities

  # The activity method is used to define activities. It accepts a list of names
  # of activities and a block specifying registration options for those
  # activities
  activity :deploy_database, :deploy_app_server, :deploy_web_server,
    :deploy_load_balancer do
    {
      version: DeploymentUtils::ACTIVITY_VERSION,
      default_task_list: DeploymentUtils::ACTIVITY_TASKLIST,
      default_task_schedule_to_start_timeout: 30,
      default_task_start_to_close_timeout: 30,
    }
  end

  # This activity can be used to deploy a database
  def deploy_database
    puts "Deploying database\n"
    "jdbc:foo/bar"
  end

  # This activity can be used to deploy an application server
  def deploy_app_server(data_sources)
    puts "Deploying app server\n"
    "http://baz"
  end

  # This activity can be used to deploy a web server
  def deploy_web_server(data_sources, app_servers)
    puts "Deploying web server\n"
    "http://webserver"
  end

  # This activity can be used to deploy a load balancer
  def deploy_load_balancer(web_server_urls)
    puts "Deploying load balancer\n"
    "http://myweb.com"
  end

end

# Start an ActivityWorker to work on the DeploymentActivity tasks
DeploymentUtils.new.activity_worker.start if $0 == __FILE__
