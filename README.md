# backup-with-shell

This repository have some examples of shell scripts that create compressed
backups of directories, MySQL and MongoDB databases.

It also contains scripts to send this backup files to AWS S3.

These are the scripts:

* `dir_bkp.sh`: copy from an specific directory
* `mongo_bkp.sh`: backup from an MongoDB databases
* `mongo_bkp_uri.sh`: same from above, but using the URI as a single parameter
* `mongo_bkp_uri_ssl.sh`: same from above, but with ssl
* `mysql-all_dbs-bkp.sh`: backup from MySQL databases
* `mysql-all_dbs-bkp-git.sh`: backup from MySQL databases and stores it in a 
  git repo
* `send_s3.sh`: send the files to an AWS S3 bucket

All scripts receive almost all settings by parameters. I'll list some examples.

## Execution

### dir\_bkp.sh

```
./dir_bkp.sh <BASENAME> <SOURCE_DIR> <STASH_DIR> <WORK_DIR>
```

* BASENAME: the basename of the file which will be used in the final filename
* SOURCE\_DIR: the directory from which the backup will be created
* STASH\_DIR: the directory where the backup will be placed
* WORK\_DIR: the directory where the process will be executed

### mongo\_bkp.sh

```
./mongo_bkp.sh <BASENAME> <MONGODB_HOST> <MONGODB_PORT> <MONGODB_USER> <MONGODB_PASS> <MONGODB_AUTH_DB> <STASH_DIR> <WORK_DIR>
```

* BASENAME: the basename of the file which will be used in the final filename
* MONGODB\_HOST: the address of the MongoDB Server
* MONGODB\_PORT: the port of the MongoDB Server
* MONGODB\_USER: the user to access MongoDB Server
* MONGODB\_PASS: the password to acess MongoDB Server
* MONGODB\_AUTH\_DB: the database which will be used to authenticate
* STASH\_DIR: the directory where the backup will be placed
* WORK\_DIR: the directory where the process will be executed

### mongo\_bkp\_uri.sh

```
./mongo_bkp_uri.sh <BASENAME> <MONGODB_URI> <STASH_DIR> <WORK_DIR>
```

* BASENAME: the basename of the file which will be used in the final filename
* MONGODB\_URI: the complete URI to connect to a MongoDB Server
* STASH\_DIR: the directory where the backup will be placed
* WORK\_DIR: the directory where the process will be executed

### mongo\_bkp\_uri\_ssl.sh

```
./mongo_bkp_uri_ssl.sh <BASENAME> <MONGODB_URI> <STASH_DIR> <WORK_DIR>
```

* BASENAME: the basename of the file which will be used in the final filename
* MONGODB\_URI: the complete URI to connect to a MongoDB Server
* STASH\_DIR: the directory where the backup will be placed
* WORK\_DIR: the directory where the process will be executed

### mysql-all\_dbs-bkp.sh

```
./mysql-all_dbs-bkp.sh <BASENAME> <DB_HOST> <DB_USER> <DB_PASS> <STASH_DIR> <WORK_DIR>
```

* BASENAME: the basename of the file which will be used in the final filename
* DB\_HOST: the address of the MySQL Server
* DB\_USER: the user to access MySQL Server
* DB\_PASS: the password to acess MySQL Server
* STASH\_DIR: the directory where the backup will be placed
* WORK\_DIR: the directory where the process will be executed

### mysql-all\_dbs-bkp-git.sh

```
./mysql-all_dbs-bkp.sh <BASENAME> <DB_HOST> <DB_USER> <DB_PASS> <GIT_DIR>
```

* BASENAME: the basename of the file which will be used in the final filename
* DB\_HOST: the address of the MySQL Server
* DB\_USER: the user to access MySQL Server
* DB\_PASS: the password to acess MySQL Server
* GIT\_DIR: the git directory where the backup will be placed

### send\_s3.sh

```
./send_s3.sh <STASH_DIR> <UPLOADED_DIR> <AWS_BUCKET> <AWS_REGION> <S3KEY> <S3SECRET>
```

* STASH\_DIR: the directory where the stash files are
* UPLOADED\_DIR: the directory where the files will be moved after upload
* AWS\_BUCKET: the AWS S3 bucket name
* AWS\_REGION: the AWS Region where the AWS S3 Bucket is located
* AWS\_S3\_KEY: the AWS S3 Key
* AWS\_S3\_SECRET: the AWS S3 Secret

## Get in touch

[eduardo@quagliato.me](mailto:eduardo@quagliato.me)
