#include <iostream>
#include <string>
#include <algorithm>

#include "ASTNode.h"
#include "SymbolTable.h"
#include "ASTTree.h"


using namespace std;

ASTTree::ASTTree() {
    this->root = new ASTNode(NULL_TYPE, nullptr, nullptr);
};
ASTTree::ASTTree(ASTNode* root) {
    this->root = root;
};
void ASTTree::run() {
    traverse(this->root, new SymbolTable());
};

void traverse(ASTNode* root, SymbolTable* symbol_table) {
    if (root == nullptr) {
        return;
    }

    // cout << "traversing node with nodetype: " << root->nodetype << endl;
    switch (root->nodetype)
    {
    // case nullptr_TYPE:
    //     cout << "nullptr_TYPE with value " << root->value << endl;
    //     break;
    case ADD_TYPE: 
        root->value = deep_add(root, symbol_table);
        break;
    case SUB_TYPE:
        traverse(root->left_node, symbol_table);
        traverse(root->right_node, symbol_table);
        root->value = root->left_node->value - root->right_node->value;
        break;
    case MUL_TYPE:
        traverse(root->left_node, symbol_table);
        traverse(root->right_node, symbol_table);
        root->value = deep_mul(root, symbol_table);
        break;
    case DIV_TYPE:
        traverse(root->left_node, symbol_table);
        traverse(root->right_node, symbol_table);
        root->value = root->left_node->value / root->right_node->value;
        break;
    case MOD_TYPE:
        traverse(root->left_node, symbol_table);
        traverse(root->right_node, symbol_table);
        root->value = root->left_node->value % root->right_node->value;
        break;
    case GREATER_TYPE:
        traverse(root->left_node, symbol_table);
        traverse(root->right_node, symbol_table);
        root->value = (root->left_node->value > root->right_node->value) ? 1 : 0;
        break;
    case SMALLER_TYPE:
        traverse(root->left_node, symbol_table);
        traverse(root->right_node, symbol_table);
        root->value = (root->left_node->value < root->right_node->value) ? 1 : 0;
        break;
    case EQUAL_TYPE:
        traverse(root->left_node, symbol_table);
        traverse(root->right_node, symbol_table);
        root->value = (root->left_node->value == root->right_node->value) ? 1 : 0;
        break;
    case AND_TYPE:
        root->value = deep_and(root, symbol_table);
        break;
    case OR_TYPE:
        root->value = deep_or(root, symbol_table);
        break;
    case NOT_TYPE:
        traverse(root->left_node, symbol_table);
        root->value = (root->left_node->value == 0) ? 1 : 0;
        break;
    case PRINT_BOOL_TYPE:
        traverse(root->left_node, symbol_table);
        if (root->left_node->value == 1) {
            cout << "#t" << endl;
        } else if (root->left_node->value == 0) {   
            cout << "#f" << endl;   
        } else {
            cout << "ERROR: PRINT_BOOL_TYPE with value:" << root->left_node->value << endl;
            exit(1);
        }
        break;
    case PRINT_NUM_TYPE:
        traverse(root->left_node, symbol_table);
        cout << root->left_node->value << endl;
        break;
    case IF_TYPE:
        traverse(root->left_node, symbol_table);
        if (root->left_node->value == 1) {
            traverse(root->right_node, symbol_table);
            root->value = root->right_node->value;
        } else if (root->left_node->value == 0) {
            traverse(root->right_node2, symbol_table);
            root->value = root->right_node2->value;
        } else {
            cout << "ERROR: IF_TYPE compare with value not 0 and 1:" << root->left_node->value << endl;
            exit(1);
        }
        break;
    case DEFINE_TYPE:
        if (root->left_node->nodetype != ID_TYPE) {
            cout << "ERROR: Defining with left_node nodetype not ID_TYPE" << endl;
            exit(1);
        }
        if (root->right_node->nodetype != FUN_EXP_TYPE) {
            traverse(root->right_node, symbol_table);
            symbol_table->addSymbol(root->left_node->variable_name, root->right_node);
        }else if (root->right_node->nodetype == FUN_EXP_TYPE) {
            symbol_table->addSymbol(root->left_node->variable_name, root->right_node);
        }else{
            cout << "ERROR: Defining with right_node nodetype not FUN_EXP_TYPE or a value" << endl;
            exit(1);
        }
        // symbol_table->printTable();
        break;
    case ID_TYPE:
        root->value = symbol_table->getSymbolValue(root->variable_name);
        break;
    case FUN_CALL_TYPE:
        if (root->left_node->nodetype == ID_TYPE){
            // cout << "\nfunction \"" << root->left_node->variable_name << "\" called" << endl;
            traverse(root->right_node, symbol_table);
            root->value = run_fun(symbol_table->getSymbolNode(root->left_node->variable_name), root->right_node, symbol_table);
        } else if (root->left_node->nodetype == FUN_EXP_TYPE){
            root->value = run_fun(root->left_node, root->right_node, symbol_table);
        }else{
            cout << "ERROR: FUN_CALL_TYPE with left_node nodetype not ID_TYPE or FUN_EXP_TYPE" << endl;
            exit(1);
        }
        break;
    default:
        traverse(root->left_node, symbol_table);
        traverse(root->right_node, symbol_table);
        break;
    }
}

int run_fun(ASTNode* fun_exp_node, ASTNode* value_nodes, SymbolTable* partent_symbol_table) {
    ASTNode* fun_tree = new ASTNode(fun_exp_node);
    SymbolTable* fun_symbol_table = new SymbolTable(partent_symbol_table);
    
    if (fun_tree->nodetype != FUN_EXP_TYPE) {
        cout << "ERROR: runnung function with nodetype not FUN_EXP_TYPE" << endl;
        exit(1);
    }
    bind_value(fun_tree->left_node, value_nodes, fun_symbol_table);
    traverse(fun_tree->right_node, fun_symbol_table);
    // fun_symbol_table->printTable();
    // delete fun_symbol_table;
    return fun_tree->right_node->value;
}

void bind_value(ASTNode* fun_id_ptr, ASTNode* value_ptr, SymbolTable* symbol_table) {
    if (fun_id_ptr == nullptr || value_ptr == nullptr) {
        return;
    }
    if (fun_id_ptr->nodetype == ID_TYPE){
        traverse(value_ptr, symbol_table);
        symbol_table->addSymbol(fun_id_ptr->variable_name, value_ptr);
    }

    bind_value(fun_id_ptr->left_node, value_ptr->left_node, symbol_table);
    bind_value(fun_id_ptr->right_node, value_ptr->right_node, symbol_table);
}

int deep_add(ASTNode* root, SymbolTable* symbol_table) {
    if (root == nullptr) {
        return 0;
    }
    switch (root->nodetype){
        case INUMBER_TYPE:
            return root->value;
            break;
        case ADD_TYPE:
        case NULL_TYPE:
            return 0 + deep_add(root->left_node, symbol_table) + deep_add(root->right_node, symbol_table);
            break;
        case ID_TYPE:
        case SUB_TYPE:
        case MUL_TYPE:
        case DIV_TYPE:
        case MOD_TYPE:
        case FUN_CALL_TYPE:
            traverse(root, symbol_table);
            return root->value;
        default:
            cout << "ERROR: deep_add with nodetype:" << root->nodetype << endl;
            exit(1);
            break;
    }
}

int deep_mul(ASTNode* root, SymbolTable* symbol_table) {
    if (root == nullptr) {
        return 1;
    }
    switch (root->nodetype){
        case INUMBER_TYPE:
            return root->value;
            break;
        case MUL_TYPE:
        case NULL_TYPE:
            return 1 * deep_mul(root->left_node, symbol_table) * deep_mul(root->right_node, symbol_table);
            break;
        case ID_TYPE:
        case ADD_TYPE:
        case SUB_TYPE:
        case DIV_TYPE:
        case MOD_TYPE:
        case FUN_CALL_TYPE:
            traverse(root, symbol_table);
            return root->value;
        default:
            cout << "ERROR: deep_mul with nodetype:" << root->nodetype << endl;
            exit(1);
            break;
    }
}

int deep_and(ASTNode* root, SymbolTable* symbol_table) {
    if (root == nullptr) {
        return 1;
    }
    switch (root->nodetype){
            break;
        case BOOLVAL_TYPE:
            return root->value;
            break;
        case AND_TYPE:
        case NULL_TYPE:
            return (deep_and(root->left_node, symbol_table) && deep_and(root->right_node, symbol_table)) > 0 ? 1 : 0;
            break;
        case ID_TYPE:
        case OR_TYPE:
        case NOT_TYPE:
        case FUN_CALL_TYPE:
            traverse(root, symbol_table);
            return root->value;
            break;
        default:
            cout << "ERROR: deep_and with nodetype:" << root->nodetype << endl;
            exit(1);
            break;
    }
}

int deep_or(ASTNode* root, SymbolTable* symbol_table) {
    if (root == nullptr) {
        return 0;
    }
    switch (root->nodetype){
        case BOOLVAL_TYPE:
            return root->value;
            break;
        case OR_TYPE:
        case NULL_TYPE:
            return (deep_or(root->left_node, symbol_table) || deep_or(root->right_node, symbol_table)) > 0 ? 1 : 0;
            break;
        case ID_TYPE:
        case AND_TYPE:
        case NOT_TYPE:
        case FUN_CALL_TYPE:
            traverse(root, symbol_table);
            return root->value;
            break;
        default:
            cout << "ERROR: deep_or with nodetype:" << root->nodetype << endl;
            exit(1);
            break;
    }
}

