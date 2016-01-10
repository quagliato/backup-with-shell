NOW=$(date +"%Y-%m-%d_%H-%M-%S_%z")
Y=$(date +"%Y")
M=$(date +"%m")
BASENAME=$1
SOURCE_DIR=$2
STASH_DIR=$3
WORK_DIR=$4
STASH_DIR=$STASH_DIR/$BASENAME/$Y/$M
 
FILENAME="$BASENAME-$NOW"
echo "******************************************************************************"
echo "BEGIN: $NOW"
echo "------------------------------------------------------------------------------"
cd $WORK_DIR
echo "ENTERING WORK DIR $WORK_DIR"
mkdir -p $STASH_DIR
echo "CREATED STASH DIR $STASH_DIR"
echo "CREATING FILE..."
tar zcf $FILENAME.tar.gz $SOURCE_DIR
echo "FILE CREATED $FILENAME.tar.gz"
mv $FILENAME.tar.gz $STASH_DIR/
echo "FILE MOVED TO $STASH_DIR"
echo "------------------------------------------------------------------------------"
END=$(date +"%Y-%m-%d_%H-%M-%S_%z")
echo "BEGIN: $NOW"
echo "  END: $END"
echo "******************************************************************************"
