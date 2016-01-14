if [ $EUID -eq 0 ]; then
  echo "ROOT!!"
else
  echo "NOT ROOT!!"
fi
