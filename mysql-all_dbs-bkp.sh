NOW=$(date +"%Y-%m-%d_%H-%M-%S_%z")
Y=$(date +"%Y")
M=$(date +"%m")
D=$(date +"%d")

BASENAME=$1
DB_HOST=$2
DB_USER=$3
DB_PASS=$4

STASH_DIR=$5
STASH_DIR=$STASH_DIR/$BASENAME/$Y/$M/$D
WORK_DIR=$6
FILENAME="$BASENAME-$NOW"

echo "******************************************************************************"
echo "BEGIN: $NOW"
echo "------------------------------------------------------------------------------"
echo "ENTERING $WORK_DIR"
cd $WORK_DIR
echo "CREATING FILE..."
mysqldump -h $DB_HOST --user=$DB_USER --password="${DB_PASS}" --all-databases --extended-insert=FALSE > mysqldump.sql
head -n -1 mysqldump.sql > mysqldump-no_last_line.sql
mv mysqldump-no_last_line.sql mysqldump.sql
diff mysqldump.sql last_mysqldump.sql > diff.txt
if [ -s diff.txt ] || [ ! -e last_mysqldump.sql ]
  then
    echo "NEW FILE DIFFERENT FROM THE LAST ONE."
    mkdir -p $STASH_DIR
    echo "CREATED STASH DIR"
    tar zcf $FILENAME.tar.gz mysqldump.sql
    echo "FILE CREATED $FILENAME.tar.gz"
    mv $FILENAME.tar.gz $STASH_DIR/
    echo "FILE $FILENAME MOVED TO $STASH_DIR"
  else
    echo "NO CHANGES."
fi
mv mysqldump.sql last_mysqldump.sql
rm -rf diff.txt
echo "------------------------------------------------------------------------------"
END=$(date +"%Y-%m-%d_%H-%M-%S_%z")
echo "BEGIN: $NOW"
echo "  END: $END"
echo "******************************************************************************"