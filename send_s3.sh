#!/bin/bash
NOW=$(date +"%Y-%m-%d_%H-%M-%S_%z")
STASH_DIR=$1
UPLOADED_DIR=$2
AWS_BUCKET=$3
AWS_REGION=$4
AWS_S3_KEY=$5
AWS_S3_SECRET=$6
echo "******************************************************************************"
echo "BEGIN: $NOW"
echo "------------------------------------------------------------------------------"
cd $STASH_DIR
for file in $(find . -name '*.tar.gz')
do
  resource="/${AWS_BUCKET}/${file}"
  echo ${resource} > resource.path;
  sed "s/\/.\//\//g" resource.path > resource.path.new;
  resource=`cat resource.path.new`;
  echo " ORIGIN FILE: ${file}"
  echo "DESTINY FILE: ${resource}"
  contentType="application/x-compressed-tar"
  dateValue=`date -R`
  stringToSign="PUT\n\n${contentType}\n${dateValue}\n${resource}"
  s3Key="$AWS_S3_KEY"
  s3Secret="$AWS_S3_SECRET"
  signature=`echo -en "${stringToSign}" | openssl sha1 -hmac ${s3Secret} -binary | base64`

  curl -X PUT -T "${file}" \
       -H "Host: ${AWS_BUCKET}.s3-$AWS_REGION.amazonaws.com" \
       -H "Date: ${dateValue}" \
       -H "Content-Type: ${contentType}" \
       -H "Authorization: AWS ${s3Key}:${signature}" \
       https://${AWS_BUCKET}.s3-$AWS_REGION.amazonaws.com/${file}

  file_new_path=`echo ${file} | cut -c 2-`;
  mkdir -p $UPLOADED_DIR
  mv -v $file $UPLOADED_DIR/;
  rm resource.path;
  rm resource.path.new;
  echo "* * * * *";
done
echo "------------------------------------------------------------------------------"
echo "BEGIN: $NOW"
END=$(date +"%Y-%m-%d_%H-%M-%S_%z")
echo "  END: $END"
echo "******************************************************************************"