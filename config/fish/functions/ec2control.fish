function ec2control --description "Boot / stop an EC2 instance by Name tag"
    if test (count $argv) -ne 2
        echo "Usage: ec2_control {start|stop} instance_name"
        return 1
    end

    set action $argv[1]
    set instance_name $argv[2]

    set instance_id (aws ec2 describe-instances --filters "Name=tag:Name,Values=$instance_name" --query "Reservations[].Instances[].InstanceId" --output text)
    
    if test -z "$instance_id"
        echo "Error: No instance found with the name '$instance_name'."
        return 1
    end

    switch $action
        case start
            echo "Starting instance '$instance_name' (ID: $instance_id)..."
            aws ec2 start-instances --instance-ids $instance_id
            echo "Start command issued."
        case stop
            echo "Stopping instance '$instance_name' (ID: $instance_id)..."
            aws ec2 stop-instances --instance-ids $instance_id
            echo "Stop command issued."
        case '*'
            echo "Unknown action '$action'."
            echo "Valid actions: start or stop."
            return 1
    end
end
