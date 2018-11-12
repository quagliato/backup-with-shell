#!/bin/bash
clear;
NOW=$(date +"%Y-%m-%d_%H-%M-%S_%z")
STASH_DIR=$1
UPLOADED_DIR=$2
SPACE_NAME=$3
DIGITAL_OCEAN_REGION=$4
AUTH_KEY=$5
AUTH_SECRET=$6
echo "******************************************************************************"
echo "BEGIN: $NOW"
echo "------------------------------------------------------------------------------"
cd $STASH_DIR
for file in $(find . -name '*.tar.gz')
do
  resource="/${SPACE_NAME}/${file}"
  echo ${resource} > resource.path;
  sed "s/\/.\//\//g" resource.path > resource.path.new;
  resource=`cat resource.path.new`;
  echo " ORIGIN FILE: ${file}"
  echo "DESTINY FILE: ${resource}"
  contentType="application/x-compressed-tar"
  dateValue=`date -R`
  stringToSign="PUT\n\n${contentType}\n${dateValue}\n${resource}"
  s3Key="$AUTH_KEY"
  s3Secret="$AUTH_SECRET"
  signature=`echo -en "${stringToSign}" | openssl sha1 -hmac ${s3Secret} -binary | base64`

  curl -X PUT -T "${file}" \
       -H "Host: ${SPACE_NAME}.${DIGITAL_OCEAN_REGION}.digitaloceanspaces.com" \
       -H "Date: ${dateValue}" \
       -H "Content-Type: ${contentType}" \
       -H "Authorization: AWS ${s3Key}:${signature}" \
       https://${SPACE_NAME}.${DIGITAL_OCEAN_REGION}.digitaloceanspaces.com/${file}

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
