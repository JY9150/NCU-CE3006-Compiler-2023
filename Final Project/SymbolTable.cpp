#include <iostream>
#include <string>

#include "ASTNode.h"
#include "SymbolTable.h"

using namespace std;

SymbolTable::SymbolTable() {
    // cout << "make symbol table" << endl;
};
SymbolTable::SymbolTable(SymbolTable* parent) {
    // cout << "make symbol table with parent" << endl;
    this->table.insert(parent->table.begin(), parent->table.end()); // copy parent
};
SymbolTable::~SymbolTable() {
    // cout << "delete symbol table" << endl;
};
bool SymbolTable::addSymbol(string symbol_name, ASTNode* symbol_node) {
    this->table[symbol_name] = symbol_node;
    return true;
};
int SymbolTable::getSymbolValue(string symbol_name) {
    return this->table[symbol_name]->value;
};
ASTNode* SymbolTable::getSymbolNode(string symbol_name) {
    return this->table[symbol_name];
};
void SymbolTable::printTable() {
    cout << "-------------------------" << endl;
    cout << "Symbol table" << endl;
    cout << "size: " << this->table.size() << endl;

    for (auto const& x : this->table) {
        cout << x.first << ": " << x.second->value << endl;
    }
    cout << "-------------------------" << endl;
};
