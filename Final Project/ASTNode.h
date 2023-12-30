#ifndef ASTNODE_H
#define ASTNODE_H

#include <iostream>

using namespace std;


typedef enum {
    NULL_TYPE,
    BOOLVAL_TYPE,
    INUMBER_TYPE,
    ID_TYPE,
    DEFINE_TYPE,
    FUN_TYPE,
    FUN_EXP_TYPE,
    FUN_CALL_TYPE,
    IF_TYPE,
    ADD_TYPE,
    SUB_TYPE,
    MUL_TYPE,
    DIV_TYPE,
    MOD_TYPE,
    GREATER_TYPE,
    SMALLER_TYPE,
    EQUAL_TYPE,
    AND_TYPE,
    OR_TYPE,
    NOT_TYPE,

    PRINT_BOOL_TYPE,
    PRINT_NUM_TYPE,
}NodeType;

class ASTNode {
    public:
        NodeType nodetype;
        ASTNode* left_node;
        ASTNode* right_node;
        ASTNode* right_node2;
        int value;
        string variable_name;

        ASTNode(NodeType nodetype, ASTNode* left_node, ASTNode* right_node, ASTNode* right_node2, int value, string variable_name);
        ASTNode(NodeType nodetype, ASTNode* left_node, ASTNode* right_node);
        ASTNode(ASTNode* srcNode);
};

ASTNode* makeDefineNode(ASTNode* left_node, ASTNode* right_node);
ASTNode* makeIDNode(string variable_name);
ASTNode* makeINumberNode(int value);
ASTNode* makeBoolValNode(int value);
ASTNode* makeIFNode(ASTNode* left_node, ASTNode* right_node, ASTNode* right_node2);
ASTNode* makeFunNode(ASTNode* left_node, ASTNode* right_node);

#endif