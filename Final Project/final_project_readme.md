# Final Project

This is the final project implementation of Mini Lisp

## About

### Enviroment

I wrote this project using C++ inside a Virtual Machine (VM), but you may also use WSL or write under Windows system. And I didn't do the bonus features, you will need to make them yourself.

- VM OS: Ubuntu Mint
- Language: C++
- Dependency:
  - lex
  - bison
  - dos2unix
    - optional
    - If u are running on linux system, the **auto_test.sh** may view `\r\n` and `\n` as different and thought your answer to be wrong.
    - dos2unix will convert them to the same

### Structure

- Final Project Descriptions
  - The Mini LISP problem description provided by the TAs
- 2022_hidden_test_data
  - The hidden test data of 2022
- final-auto
  - The auto test program that TA used in 2023 to test my code
  - It also contains 2023 hidden test data
- public_test_ans
  - The answer of each public test data
  - I wrote this myself base on the problem description
- public_test_data
  - The public test data of .lsp
- **auto_test.sh**
  - auto-compile and auto-test for all the public test data
  - type `./auto_test.sh` and run.
- final.l
  - lex file for this project
- final.y
  - yacc file for this project
- **run.sh**
  - auto-compile and auto-testing shell script
- test.txt
  - put your test data inside here and type `./run.sh` in command line
- ASTNode.cpp, ASTNode.h, ASTTree.cpp, ASTNode.h, SymbolTable.cpp, SymbolTable.h
  - Definition and my implementation in C++

### Code Explaination

1. First use lex to tokenize input strings
2. Use yacc to evalute the grammar and make a ASTTree
3. traverse the ASTTree to perform the code action
