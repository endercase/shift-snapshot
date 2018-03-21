#shift-snapshot
A bash script to automate backups for SHIFT blockchain<br>
v0.2.1
For more information about SHIFT please visit - http://www.shiftnrg.org/

##Requisites
    - This script works with postgres and shift_db, configured with shift user
    - You need to have sudo privileges

##Installation
Execute the following commands
```
cd ~/
git clone https://github.com/biolypl/shift-snapshot
cd shift-snapshot/
bash shift-snapshot.sh help
```
##Available commands

    - create
    - log
###Create
Command _create_ is for create new snapshot, example of usage:<br>
`bash shift-snapshot.sh create`<br>
Automaticly will create a snapshot file in new folder called snapshot/.<br>
Don't require to stop you node app.js instance.<br>
Also will create a line in the log, there you can see your snapshot at what block height was created.<br>
###log
Display all the snapshots created. <br>
Example of usage:<br>
`bash shift-snapshot.sh log`<br>
<br>
Example of output:<br>
```
   + Snapshot Log                                                                  
  --------------------------------------------------                               
  20-10-2016 - 20:59:06 -- Snapshot created successfully at block  48967 ( 43 MB)  
  20-10-2016 - 21:36:07 -- Snapshot created successfully at block  49037 ( 43 MB)  
  --------------------------------------------------END                            
