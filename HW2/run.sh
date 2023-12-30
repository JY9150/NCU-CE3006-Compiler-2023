echo "comiling..."
echo ""

flex -o practice.yy.c hw2-1.l
gcc -c -g -I.. practice.yy.c
gcc -o hw2-1 practice.yy.o

echo ""
echo "start testing..."
echo ""

./hw2-1 < ./test.txt

echo ""
echo "end testing..."

# bison -d  -o practice.tab.c practice.y
# gcc -c -g -I.. practice.tab.c
# flex -o practice.yy.c practice.l
# gcc -c -g -I.. practice.yy.c
# gcc -o practice practice.tab.o practice.yy.o
# ./practice < testcase/1.in
# ./practice < testcase/2.in
# ./practice < testcase/3.in
# ./practice < testcase/4.in
# ./practice < testcase/5.in
# ./practice < testcase/6.in
# rm *.tab.*
# rm *.yy.*
# sleep 0.05m 