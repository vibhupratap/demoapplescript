#! /usr/bin/osascript

set commands to {¬
	¬
		{tabname:"ZooKeeper", action:¬
			"cd ~/software/zk; clear; pwd;bin/zkServer.sh start conf/zoo.cfg"} ¬
			, ¬
	¬
		¬
			{tabname:"Kafka", action:¬
				"cd ~/software/kafka; clear; pwd;bin/kafka-server-start.sh config/server.properties"} ¬
				, ¬
	¬
		¬
			{tabname:"Topic", action:¬
				"cd ~/software/kafka; clear; pwd;bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic test"} ¬
				}


# Open up Iterm
tell application "iTerm"
	create window with default profile

	# Create three sessions so that we can bring up ZK/Kafka & Create a Topic.
	tell current session of current window
		repeat count of commands - 1 times
			split vertically with default profile
		end repeat
	end tell

	# Establish connections & execute actions.
	repeat with i from 1 to count of commands
		tell session i of current tab of current window
			set name to (tabname of item i of commands)
			write text (action of item i of commands)
			delay 5
		end tell
	end repeat
end tell
