#!/bin/bash
VERSION="0.2.1"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

#============================================================
#= snapshot.sh v0.2 created by mrgr
#= edited by bioly
#= Please consider voting for delegate mrgr and bioly ;)
#============================================================
echo " "

if [ ! -f ../shift/app.js ]; then
  echo "Error: No shift installation detected. Exiting."
  exit 1
fi

if [ "\$USER" == "root" ]; then
  echo "Error: SHIFT should not be run be as root. Exiting."
  exit 1
fi

SHIFT_CONFIG=~/shift/config.json
DB_NAME="$(grep "database" $SHIFT_CONFIG | cut -f 4 -d '"')"
SNAPSHOT_LOG=snapshot.log
SNAPSHOT_DIRECTORY=snapshot/
if [ ! -f $SNAPSHOT_DIRECTORY ]; then
 mkdir -p $SNAPSHOT_DIRECTORY
fi


NOW=$(date +"%d-%m-%Y - %T")
################################################################################

create_snapshot() {
  echo " + Creating snapshot"
  echo "--------------------------------------------------"
  echo "..."
  blockHeight="$(curl -k -X GET http://localhost:9305/api/blocks/getHeight | jq '.height')"
  fullPath="${SNAPSHOT_DIRECTORY}blockchain.db_${blockHeight}.gz"
  fullPathLast="${SNAPSHOT_DIRECTORY}blockchain.db.gz"
  sudo -u postgres pg_dump -O "$DB_NAME" | gzip > "$fullPath"
  if [ $? != 0 ]; then
    echo "X Failed to create snapshot." | tee -a $SNAPSHOT_LOG
    exit 1
  else
    echo "$NOW -- OK snapshot $fullPath created successfully" | tee -a $SNAPSHOT_LOG
    sudo cp $fullPath $fullPathLast
  fi

}


show_log(){
  echo " + Snapshot Log"
  echo "--------------------------------------------------"
  cat snapshot/snapshot.log
  echo "--------------------------------------------------END"
}

################################################################################

case $1 in
"create")
  create_snapshot
  ;;
"log")
  show_log
  ;;
"hello")
  echo "Hello my friend - $NOW"
  ;;
"help")
  echo "Available commands are: "
  echo "  create   - Create new snapshot"
  echo "  log      - Display log"
  ;;
*)
  echo "Error: Unrecognized command."
  echo ""
  echo "Available commands are: create, log, help"
  echo "Try: bash shift-snapshot.sh help"
  ;;
esac
