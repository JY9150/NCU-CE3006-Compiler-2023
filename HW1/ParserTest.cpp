/*
CE3006-* HW1-1 ParserTest
110504514
*/
#include <iostream>
#include <string>
#include <vector>

using namespace std;
enum class TokenType
{
    ID,
    STRLIT,
    LBR,
    RBR,
    DOT,
    END
};

class ScanningErrorException : public std::exception {
    public:
    const char* what() const noexcept override {
        return "Scanning Failed.";
    }
};

class ParsingErrorException : public std::exception{
    public:
    const char * what() {
        return "Parsing Failed.";
    }
};

class TokenList {
    public:
    vector<pair<TokenType, string>> mylist;
    int pointer = -1;
    TokenList(){
    }
    bool add(TokenType tt, string id){
        mylist.push_back(make_pair(tt, id));
        return true;
    }
    pair<TokenType, string> get(){
        return mylist[pointer];
    }

    pair<TokenType, string> peek(){
        return mylist[pointer+1];
    }

    TokenType peekType(){
        return mylist[pointer+1].first;
    }

    pair<TokenType, string> next(){
        pointer = (pointer+1)%mylist.size();
        return mylist[pointer];
    }

    size_t size(){
        return mylist.size();
    }

    void printTokens(){
        for(size_t i = 0; i < mylist.size()-1; i++){
            cout << printTokenType(mylist[i].first) << " " << mylist[i].second << endl;
        }
    }

    private:
    string printTokenType(TokenType token_type){
    switch (token_type){
        case TokenType::ID:
            return "ID";
        case TokenType::STRLIT:
            return "STRLIT";
        case TokenType::LBR:
            return "LBR";
        case TokenType::RBR:
            return "RBR";
        case TokenType::DOT:
            return "DOT";
        case TokenType::END:
            return "";
    }
    return "ERROR";
    }
};


bool myScanner(TokenList&, string);
bool myParser(TokenList&);
void program(TokenList&);
void stmts(TokenList&);
void stmt(TokenList&);
void primary(TokenList&);
void primary_tail(TokenList&);
void match(TokenList&, TokenType);



int main(){
    string line = "";
    string input_line = "";
    TokenList token_list;
    

    while (getline(cin, line)) {
        input_line += line; // ???
        input_line += '\n';
    }
    // cout << input_line << endl;

    try{
        myScanner(token_list, input_line);
        myParser(token_list);

        token_list.printTokens();
    }catch (ParsingErrorException e){
        // cout << e.what() << endl;
        cout << "invalid input" << endl;
    }catch (ScanningErrorException e){
        // cout << e.what() << endl;
        cout << "invalid input" << endl;
    }
}



bool myScanner(TokenList& token_list,string in_line){
    string id_temp = "";
    size_t index = 0;
    while(index < in_line.size()){
        char c = in_line[index];

        switch(c){
            case ' ':
                index++;
                break;
            case '\n':
                index++;
                break;
            case '(':
                token_list.add(TokenType::LBR, "(");
                index++;
                break;
            case ')':
                token_list.add(TokenType::RBR, ")");
                index++;
                break;
            case '.':
                token_list.add(TokenType::DOT, ".");
                index++;
                break;
            case '"':
                while(in_line[++index] != '"' && index < in_line.size()){
                    id_temp += in_line[index];
                }
                if (index == in_line.size()){
                    throw ScanningErrorException();
                    return false;
                }
                token_list.add(TokenType::STRLIT, '"' + id_temp + '"');
                id_temp = "";
                index++;
                break;
            default:
                if (isalpha(c)){
                    while(isalpha(in_line[index]) || isdigit(in_line[index]) || in_line[index] == '_'){
                        id_temp += in_line[index];
                        index++;
                    }
                    token_list.add(TokenType::ID, id_temp);
                    id_temp = "";
                    break;
                }
                else{
                    throw ScanningErrorException();
                    return false;
                }
        }

    }
    token_list.add(TokenType::END, "$");
    return true;
}

bool myParser(TokenList& token_list){
    // program(token_list);
    return true;
}

void program(TokenList& token_list){
    TokenType token_type = token_list.peekType();
    if (token_type == TokenType::ID || token_type == TokenType::STRLIT){
        stmts(token_list);
    }else if (token_type == TokenType::END){
        return; // lambda
    }else{
        throw ParsingErrorException();
    }
    return;
}

void stmts(TokenList& token_list){
    TokenType token_type = token_list.peekType();
    if (token_type == TokenType::ID || token_type == TokenType::STRLIT){
        stmt(token_list);
        stmts(token_list);
    }else if (token_type == TokenType::END){
        return; // lambda
    }else{
        throw ParsingErrorException();
    }
    return;
}

void stmt(TokenList& token_list){
    TokenType token_type = token_list.peekType();
    if (token_type == TokenType::ID){
        primary(token_list);
    }else if (token_type == TokenType::STRLIT){
        match(token_list, TokenType::STRLIT);
    }else if (token_type == TokenType::RBR || token_type == TokenType::END){
        return; // lambda
    }else{
        throw ParsingErrorException();
    }
    return;
}

void primary(TokenList& token_list){
    TokenType token_type = token_list.peekType();
    if (token_type == TokenType::ID){
        match(token_list, TokenType::ID);
        primary_tail(token_list);
    // }else if (token_type == TokenType::END){
    //     return; // lamda ?
    }else{
        throw ParsingErrorException();
    }
    return;
}

void primary_tail(TokenList& token_list){
    TokenType token_type = token_list.peekType();
    if (token_type == TokenType::DOT){
        match(token_list, TokenType::DOT);
        match(token_list, TokenType::ID);
        primary_tail(token_list);
    }else if (token_type == TokenType::LBR){
        match(token_list, TokenType::LBR);
        stmt(token_list);
        match(token_list, TokenType::RBR);
        primary_tail(token_list);
    }else if (token_type == TokenType::RBR 
            || token_type == TokenType::STRLIT
            || token_type == TokenType::ID
            || token_type == TokenType::END ){ // very bad
        return; //lamda
    }else{
        throw ParsingErrorException();
    }
    return;
}

void match(TokenList& token_list, TokenType token_type){
    if (token_list.next().first != token_type){
        throw ParsingErrorException();
    }
}