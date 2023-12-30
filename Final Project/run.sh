name=final
cpp_file="ASTTree.cpp SymbolTable.cpp ASTNode.cpp"
test_file=test.txt
output_file=final_run


lex_file=${name}.l
yacc_file=${name}.y


# Define Colors
Green='\033[0;32m' # Green
RED='\033[0;31m'
Purple='\033[0;35m'
NC='\033[0m' # No Color


# run
clear
echo -e "${Purple}compiling...${NC}"
echo ""

bison -d -o ${name}.tab.c ${yacc_file}
flex -o ${name}.yy.c ${lex_file}
g++ -g -o ${output_file} ${name}.tab.c ${name}.yy.c ${cpp_file}

echo ""
echo -e "${Purple}start testing...${NC}"
echo ""

# "./${output_file}" < "./${test_file}"

echo ""
echo -e "${Purple}end testing...${NC}"

rm *.tab.*
rm *.yy.*