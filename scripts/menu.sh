./greet.sh

echo "What would you like to do?"
echo ""
echo "  1) Install Gaia Integration Test in JavaScript (GIJ)"
echo ""
echo -n "Please select [ENTER]:"

read CHOICE

case $CHOICE in 
1) ./gij.sh
  ;;
*) echo "Not a valid option, try again."
  ;;
esac

./menu.sh

