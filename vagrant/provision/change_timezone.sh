echo "------------------------------------------------------"
echo "-------> Starting 'change_timezone.sh' script <-------"
echo "------------------------------------------------------"

timedatectl set-timezone Europe/Madrid

echo "--> Time in Spain is:" $(date +"%Y/%m/%d at %T")
