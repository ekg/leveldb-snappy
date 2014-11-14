#include <iostream>
#include "leveldb/db.h"
using namespace std;

int main(int argc, char** argv) {
    leveldb::DB* db;
    leveldb::Options options;
    options.create_if_missing = true;
    leveldb::Status status = leveldb::DB::Open(options, "/tmp/testdb", &db);
    if (status.ok()) {
        cerr << "it's all good!" << endl;
        return 0;
    } else {
        cerr << "we've failed to make our db :(" << endl;
        return 1;
    }
}
