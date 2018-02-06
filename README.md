# backup-with-shell

This repository have some examples of shell scripts that create compressed
backups of directories, MySQL and MongoDB databases.

It also contains scripts to send this backup files to AWS S3.

These are the scripts:

* `dir_bkp.sh`: copy from an specific directory
* `mongo_bkp.sh`: backup from an MongoDB databases
* `mysql-all_dbs-bkp.sh`: backup from MySQL databases
* `mysql-all_dbs-bkp-git.sh`: backup from MySQL databases and stores it in a 
  git repo
* `send_s3.sh`: send the files to an AWS S3 bucket

All scripts receive almost all settings by parameters. I'll list some examples.

## Execution

### dir_bkp.sh

```
./dir_bkp.sh <BASENAME> <SOURCE_DIR> <STASH_DIR> <WORK_DIR>
```

* BASENAME: the basename of the file which will be used in the final filename
* SOURCE_DIR: the directory from which the backup will be created
* STASH_DIR: the directory where the backup will be placed
* WORK_DIR: the directory where the process will be executed

### mongo_bkp.sh

```
./mongo_bkp.sh <BASENAME> <MONGODB_HOST> <MONGODB_PORT> <MONGODB_USER> <MONGODB_PASS> <STASH_DIR> <WORK_DIR>
```

* BASENAME: the basename of the file which will be used in the final filename
* MONGODB_HOST: the address of the MongoDB Server
* MONGODB_PORT: the port of the MongoDB Server
* MONGODB_USER: the user to access MongoDB Server
* MONGODB_PASS: the password to acess MongoDB Server
* STASH_DIR: the directory where the backup will be placed
* WORK_DIR: the directory where the process will be executed

### mysql-all_dbs-bkp.sh

```
./mysql-all_dbs-bkp.sh <BASENAME> <DB_HOST> <DB_USER> <DB_PASS> <STASH_DIR> <WORK_DIR>
```

* BASENAME: the basename of the file which will be used in the final filename
* DB_HOST: the address of the MySQL Server
* DB_USER: the user to access MySQL Server
* DB_PASS: the password to acess MySQL Server
* STASH_DIR: the directory where the backup will be placed
* WORK_DIR: the directory where the process will be executed

### mysql-all_dbs-bkp-git.sh

```
./mysql-all_dbs-bkp.sh <BASENAME> <DB_HOST> <DB_USER> <DB_PASS> <GIT_DIR>
```

* BASENAME: the basename of the file which will be used in the final filename
* DB_HOST: the address of the MySQL Server
* DB_USER: the user to access MySQL Server
* DB_PASS: the password to acess MySQL Server
* GIT_DIR: the git directory where the backup will be placed

### send_s3.sh

```
./send_s3.sh <STASH_DIR> <UPLOADED_DIR> <BUCKET> <AWS_REGION> <S3KEY> <S3SECRET>
```

* STASH_DIR: the directory where the stash files are
* UPLOADED_DIR: the directory where the files will be moved after upload
* AWS_BUCKET: the AWS S3 bucket name
* AWS_REGION: the AWS Region where the AWS S3 Bucket is located
* AWS\_S3\_KEY: the AWS S3 Key
* AWS\_S3\_SECRET: the AWS S3 Secret
