function ec2ip
    if test (count $argv) -ne 1
        echo "Usage: ec2ip <instance-name>"
        return 1
    end

    set -l INSTANCE_NAME $argv[1]
    set -l EC2_IP (aws ec2 describe-instances --filters "Name=tag:Name,Values=$INSTANCE_NAME" --query "Reservations[0].Instances[0].PublicIpAddress" --output text)

    if test -n "$EC2_IP" -a "$EC2_IP" != "None"
        echo $EC2_IP
    else
        echo "No running instance found with name '$INSTANCE_NAME'"
        return 1
    end
end
