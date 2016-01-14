mkdir logs
vagrant scp default:~/gaia/*.raw.log ./logs
vagrant scp default:~/gaia/*.log.xml ./logs
echo "Logs are extracted to the 'logs' folder"
