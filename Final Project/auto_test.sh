name=final
cpp_files="ASTTree.cpp SymbolTable.cpp ASTNode.cpp"
test_dir="./public_test_data"
test_ans_dir="./public_test_ans"
output_file_name=final_run


lex_file=${name}.l
yacc_file=${name}.y


# Define Colors
Green='\033[0;32m' # Green
RED='\033[0;31m'
Purple='\033[0;35m'
NC='\033[0m' # No Color


# test
clear
echo -e "${Purple}compiling${NC}"
echo ""

bison -d -o ${name}.tab.c ${yacc_file}
flex -o ${name}.yy.c ${lex_file}
g++ -g -o ${output_file_name} ${name}.tab.c ${name}.yy.c ${cpp_files}

echo ""
echo -e "${Purple}start testing...${NC}"
echo ""

for test_file in "$test_dir"/*
do
    filename=$(basename "$test_file")
    filename="${filename%.*}"
    ans_file="$test_ans_dir/$filename.out"

    if [ -f "$test_file" ] && [ -f "$ans_file" ]; then
        echo -e "\n${Purple}Testing $test_file...${NC}"

        program_output="$(./$output_file_name < $test_file 2>&1)"
        correct_ans=$(cat $ans_file)
        program_output=$(echo "$program_output" | dos2unix)
        correct_ans=$(echo "$correct_ans" | dos2unix)

        if [ "$program_output" == "$correct_ans" ]; then
            echo -e "${Green}Success: $filename${NC}"
        else
            echo -e "${RED}Error: $filename${NC}"
            echo "-----"
            echo "$program_output"
            echo "-----"
            echo "$correct_ans"
            echo "-----"
        fi
    fi
done


echo ""
echo -e "${Purple}end testing...${NC}"

rm *.tab.*
rm *.yy.*