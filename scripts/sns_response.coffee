# Description
#   SNS parsing for basic notifications
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Notes:
#   This bot is controled by the topic from the ARN set in SNS.
#
# Author:
#   @garndt

module.exports = (robot) ->
    robot.on "sns:notification", (msg) ->
        """
        Received notification:
            TopicArn:   #{msg.topicArn}
            Topic:      #{msg.topic}
            Message Id: #{msg.messageId}
            Subject:    #{msg.subject}
            Message:    #{msg.message}
        """

        # Format:
        # timestamp hostname program message
        # parse the date
        alert = JSON.parse(msg.message);
        alertTime = new Date(alert.time);
        robot.messageRoom "#taskcluster-notifications", "[taskcluster-alert] #{alertTime} - '#{alert.name}' triggered. #{alert.message}"

