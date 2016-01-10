clear; 
 
NOW=$(date +"%Y-%m-%d_%H-%M-%S_%z")
STASH_DIR=$1
UPLOADED_DIR=$2
BUCKET=$3
echo "******************************************************************************"
echo "BEGIN: $NOW"
echo "------------------------------------------------------------------------------"
cd $STASH_DIR
for file in $(find . -name '*.tar.gz')
do
  resource="/${BUCKET}/${file}"
  echo ${resource} > resource.path;
  sed "s/\/.\//\//g" resource.path > resource.path.new;
  resource=`cat resource.path.new`;
  echo " ORIGIN FILE: ${file}"
  echo "DESTINY FILE: ${resource}"
  echo "* * * * *";
  contentType="application/x-compressed-tar"
  dateValue=`date -R`
  stringToSign="PUT\n\n${contentType}\n${dateValue}\n${resource}"
  s3Key=XXXXXXXXXXXXXXXXXXXX # correct length
  s3Secret=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX # correct length
  signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64`
  curl -X PUT -T "${file}" \
       -H "Host: ${BUCKET}.s3.amazonaws.com" \
       -H "Date: ${dateValue}" \
       -H "Content-Type: ${contentType}" \
       -H "Authorization: AWS ${s3Key}:${signature}" \
       https://${BUCKET}.s3.amazonaws.com/${file}
 
#  mv $file $UPLOADED_DIR/$file
  rm resource.path;
  rm resource.path.new;
done
echo "------------------------------------------------------------------------------"
END=$(date +"%Y-%m-%d_%H-%M-%S_%z")
echo "BEGIN: $NOW"
echo "  END: $END"
echo "******************************************************************************"
