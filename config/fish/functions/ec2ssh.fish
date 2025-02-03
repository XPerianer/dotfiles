function ec2ssh
    if test (count $argv) -ne 1
        echo "Usage: ec2ssh <instance-name>"
        return 1
    end

    set -l INSTANCE_NAME $argv[1]
    set -l EC2_IP (ec2ip $INSTANCE_NAME)

    if test -n "$EC2_IP" -a "$EC2_IP" != "None"
        echo "Connecting to $INSTANCE_NAME ($EC2_IP)..."
        ssh ec2-user@$EC2_IP
    else
        echo "Failed to retrieve IP for instance '$INSTANCE_NAME'"
        return 1
    end
end
