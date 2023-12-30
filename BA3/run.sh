name=BA3-2
test_file=test.txt
output_file=BA3-2_run


lex_file=${name}.l
yacc_file=${name}.y


# Define Colors
Green='\033[0;32m'        # Green
RED='\033[0;31m'
Purple='\033[0;35m'
NC='\033[0m' # No Color


# run
echo -e "${Purple}compiling...${NC}"
echo ""

bison -d -o ${name}.tab.c ${yacc_file}
gcc -c -g -I.. ${name}.tab.c
flex -o ${name}.yy.c ${lex_file}
gcc -c -g -I.. ${name}.yy.c
gcc -o ${output_file} ${name}.tab.o ${name}.yy.o

echo ""
echo -e "${Purple}start testing...${NC}"
echo ""

"./${output_file}" < "./${test_file}"

echo ""
echo -e "${Purple}end testing...${NC}"

rm *.tab.*
rm *.yy.*

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