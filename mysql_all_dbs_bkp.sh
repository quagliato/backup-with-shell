NOW=$(date +"%Y-%m-%d_%H-%M-%S_%z")
Y=$(date +"%Y")
M=$(date +"%m")
D=$(date +"%d")
BASENAME=$1
STASH_DIR=$2
STASH_DIR=$STASH_DIR/$BASENAME/$Y/$M/$D
WORK_DIR=$3
FILENAME="$BASENAME-$NOW"
DB_HOST=$4
DB_USER=$5
DB_PASS=$6
echo "******************************************************************************"
echo "BEGIN: $NOW"
echo "------------------------------------------------------------------------------"
cd $WORK_DIR
echo "ENTERED WORK DIR"
mkdir -p $STASH_DIR
echo "CREATED STASH DIR"
echo "CREATING FILE..."
mysqldump -h $DB_HOST --user=$DB_USER --password="${DB_PASS}" --all-databases > $WORK_DIR/mysqldump.sql
tar zcf $FILENAME.tar.gz $WORK_DIR/mysqldump.sql
echo "FILE CREATED $FILENAME.tar.gz"
mv $FILENAME.tar.gz $STASH_DIR/
echo "FILE MOVED."
echo "------------------------------------------------------------------------------"
END=$(date +"%Y-%m-%d_%H-%M-%S_%z")
echo "BEGIN: $NOW"
echo "  END: $END"
echo "******************************************************************************"
rm -f $WORK_DIR/mysqldump.sql
