#!/bin/bash
NOW=$(date +"%Y-%m-%d_%H-%M-%S_%z")
Y=$(date +"%Y")
M=$(date +"%m")
D=$(date +"%d")
BASENAME=$1
MONGODB_HOST=$2
MONGODB_PORT=$3
MONGODB_USER=$4
MONGODB_PASS=$5
STASH_DIR=$6
WORK_DIR=$7
STASH_DIR=$STASH_DIR/$BASENAME/$Y/$M/$D
 
FILENAME="$BASENAME-$NOW"
echo "******************************************************************************"
echo "BEGIN: $NOW"
echo "------------------------------------------------------------------------------"
cd $WORK_DIR
echo "ENTERING WORK DIR $WORK_DIR"
mkdir -p $STASH_DIR
echo "CREATED STASH DIR $STASH_DIR"
echo "CREATING MONGO DUMP DIR $FILENAME"
mkdir -p $FILENAME
cd $FILENAME
echo "CREATING MONGO DUMP... `date`"
mongodump -h $MONGODB_HOST:$MONGODB_PORT -u $MONGODB_USER -p $MONGODB_PASS
echo "MONGO DUMP CREATED `date`"
cd ..
echo "CREATING FILE..."
tar zcf $FILENAME.tar.gz $FILENAME
echo "FILE CREATED $FILENAME.tar.gz"
mv $FILENAME.tar.gz $STASH_DIR/
echo "FILE MOVED TO $STASH_DIR"
echo "CLEANING $FILENAME..."
rm -rf $FILENAME
echo "$FILENAME CLEANED"
echo "------------------------------------------------------------------------------"
END=$(date +"%Y-%m-%d_%H-%M-%S_%z")
echo "BEGIN: $NOW"
echo "  END: $END"
echo "******************************************************************************"