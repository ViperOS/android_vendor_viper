#!/bin/sh
if [ "$1" ]
then
  file_path=$1
  datetime=$(date +%s)
  filename=$(basename "$file_path")
  if [ -f $file_path ]; then
    size=$(stat --printf="%s" "$file_path")
    id=$(cat "$file_path.md5sum" | cut -d' ' -f1)
    echo "{\n   \"datetime\":\"$datetime\",\n   \"filename\":\"$filename\",\n   \"size\":$size,\n   \"id\":\"$id\"\n}" > $file_path.json
  fi
fi
