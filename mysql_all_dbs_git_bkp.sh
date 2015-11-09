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
echo "MOVING FILE..."
mv mysqldump.sql "$GIT_DIR/$BASENAME.sql"
echo "ENTERING GIT DIR..."
cd $GIT_DIR
git add .
git commit -m "$NOW"
echo "COMMIT DONE."
git push origin master
echo "------------------------------------------------------------------------------"
END=$(date +"%Y-%m-%d_%H-%M-%S_%z")
echo "BEGIN: $NOW"
echo "  END: $END"
echo "******************************************************************************"
