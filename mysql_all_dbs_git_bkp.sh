NOW=$(date +"%Y-%m-%d_%H-%M-%S_%z")
Y=$(date +"%Y")
M=$(date +"%m")
D=$(date +"%d")
BASENAME=$1
DB_HOST=$2
DB_USER=$3
DB_PASS=$4
GIT_DIR=$5
echo "******************************************************************************"
echo "BEGIN: $NOW"
echo "------------------------------------------------------------------------------"
echo "CREATING FILE..."
mysqldump -h $DB_HOST --user=$DB_USER --password="${DB_PASS}" --all-databases > mysqldump.sql
head -n -1 mysqldump.sql > mysqldump-no_last_line.sql
mv mysqldump-no_last_line.sql mysqldump.sql
diff mysqldump.sql last_mysqldump.sql > diff.txt
if [ -s diff.txt ] || [ ! -e last_mysqldump.sql ]
  then
    echo "NEW FILE DIFFERENT FROM THE LAST ONE."
    rm diff.txt
    cp mysqldump.sql "$GIT_DIR/$BASENAME.sql"
    mv mysqldump.sql last_mysqldump.sql
    echo "ENTERING GIT DIR..."
    cd $GIT_DIR
    git add .
    git commit -m "$NOW"
    echo "COMMIT DONE."
    git push origin master
  else
    echo "NO CHANGES."
    rm diff.txt
    mv mysqldump.sql last_mysqldump.sql
fi
echo "------------------------------------------------------------------------------"
END=$(date +"%Y-%m-%d_%H-%M-%S_%z")
echo "BEGIN: $NOW"
echo "  END: $END"
echo "******************************************************************************"
