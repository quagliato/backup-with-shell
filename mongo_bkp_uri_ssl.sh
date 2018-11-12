NOW=$(date +"%Y-%m-%d_%H-%M-%S_%z")
Y=$(date +"%Y")
M=$(date +"%m")
D=$(date +"%d")
BASENAME=$1
MONGODB_URI=$2
STASH_DIR=$3
WORK_DIR=$4
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
echo "CREATING MONGO DUMP... `date`"
mongodump --uri="$MONGODB_URI" -o $FILENAME --ssl
echo "MONGO DUMP CREATED `date`"
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
