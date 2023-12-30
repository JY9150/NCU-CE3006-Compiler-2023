name=hw
test_file=test.txt
output_file=hw_run


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