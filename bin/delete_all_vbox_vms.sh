# If you forget to delete the VM in Jenkins runs, the vms will accumulate and 
# blow up your harddrive. Use this script to clean them up 

# use the following command to login as jenkins
# sudo su -s /bin/bash jenkins

#VBoxManage list vms
for vm in $(VBoxManage list vms | grep -o vm_default_[0-9]*_[0-9]*); 
do 
  echo "Removing "$vm; 
  VBoxManage unregistervm $vm --delete
done

