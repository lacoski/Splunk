readonly base_file=`readlink -f "$0"` # Lay toan duong link file
readonly base_path=`dirname $base_file` # get path link
list_files=($base_path/lib $base_path/install.sh $base_path/uninstall.sh)
echo "Checking file and directory"
for i in ${list_files[*]}
do
  echo -n "Checking $i file"
  if [ -d "$i" -o -f "$i" ]
  then
    echo " ..Done!"
  else
    echo " ..Wrong!!"
    echo "Checking false!!"
    echo "You can not run this script!"
    exit 1
  fi
done
echo "Checking all done, you can run this script!"
