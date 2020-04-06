export SNOWSQL_PATH="/Applications/SnowSQL.app/Contents/MacOS"
if [ -d "${SNOWSQL_PATH}" ]; then
  export PATH=${SNOWSQL_PATH}:$PATH
fi
