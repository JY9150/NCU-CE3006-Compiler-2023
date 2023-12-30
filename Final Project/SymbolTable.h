#ifndef SYMBOL_H
#define SYMBOL_H

#include <string>
#include <map>
#include "ASTNode.h"

using namespace std;


class SymbolTable {
    public:
        SymbolTable();
        SymbolTable(SymbolTable* parent);
        ~SymbolTable();
        bool addSymbol(string symbol_name, ASTNode* symbol_node);
        int getSymbolValue(string symbol_name);
        ASTNode* getSymbolNode(string symbol_name);
        void printTable();
    private:
        map<string, ASTNode*> table;
};

#endif