#ifndef ASTTREE_H
#define ASTTREE_H

#include <iostream>
#include <string>
#include "SymbolTable.h"

using namespace std;

class ASTTree {
    public:
        ASTTree();
        ASTTree(ASTNode* root);
        ASTNode* root;
        void run();
};

void traverse(ASTNode* root, SymbolTable* symbol_table);
int run_fun(ASTNode* fun_exp_node, ASTNode* value_nodes, SymbolTable* partent_symbol_table);
int deep_add(ASTNode* root, SymbolTable* symbol_table);
int deep_mul(ASTNode* root, SymbolTable* symbol_table);
int deep_and(ASTNode* root, SymbolTable* symbol_table);
int deep_or(ASTNode* root, SymbolTable* symbol_table);
void bind_value(ASTNode* fun_id_ptr, ASTNode* value_ptr, SymbolTable* symbol_table);


#endif