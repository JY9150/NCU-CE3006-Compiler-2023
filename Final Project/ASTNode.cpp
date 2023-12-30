#include <iostream>

#include "ASTNode.h"

using namespace std;


ASTNode::ASTNode(NodeType nodetype, ASTNode* left_node, ASTNode* right_node, ASTNode* right_node2, int value, string variable_name){
    this->nodetype = nodetype;
    this->left_node = left_node;
    this->right_node = right_node;
    this->right_node2 = right_node2;
    this->value = value;
    this->variable_name = variable_name;
};
ASTNode::ASTNode(NodeType nodetype, ASTNode* left_node, ASTNode* right_node) {
    this->nodetype = nodetype;
    this->left_node = left_node;
    this->right_node = right_node;
    this->right_node2 = nullptr;
    this->value = 0;
};
ASTNode::ASTNode(ASTNode* srcNode) {
    this->nodetype = srcNode->nodetype;
    this->left_node = (srcNode->left_node == nullptr) ? nullptr : new ASTNode(srcNode->left_node);
    this->right_node = (srcNode->right_node == nullptr) ? nullptr : new ASTNode(srcNode->right_node);
    this->right_node2 = (srcNode->right_node2 == nullptr) ? nullptr : new ASTNode(srcNode->right_node2);
    this->value = srcNode->value;
    this->variable_name = srcNode->variable_name;
};


ASTNode* makeDefineNode(ASTNode* left_node, ASTNode* right_node) {
    return new ASTNode(DEFINE_TYPE, left_node, right_node, nullptr, 0, "");
};
ASTNode* makeIDNode(string variable_name) {
    return new ASTNode(ID_TYPE, nullptr, nullptr, nullptr, 0, variable_name);
};
ASTNode* makeINumberNode(int value) {
    return new ASTNode(INUMBER_TYPE, nullptr, nullptr, nullptr, value, "");
};
ASTNode* makeBoolValNode(int value) {
    return new ASTNode(BOOLVAL_TYPE, nullptr, nullptr, nullptr, value, "");
};
ASTNode* makeIFNode(ASTNode* left_node, ASTNode* right_node, ASTNode* right_node2) {
    return new ASTNode(IF_TYPE, left_node, right_node, right_node2, 0, "");
};
ASTNode* makeFunNode(ASTNode* left_node, ASTNode* right_node) {
    return new ASTNode(FUN_EXP_TYPE, left_node, right_node, nullptr, 0, "");
};
