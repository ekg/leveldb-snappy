all: test

libsnappy.a: snappy/*cc snappy/*h
	cd snappy && mkdir -p build && ./autogen.sh && ./configure --prefix=`pwd`/build/ && $(MAKE) && $(MAKE) install
	cp snappy/build/lib/libsnappy.a ./

libleveldb.a: leveldb/include/leveldb/*.h leveldb/db/*.c leveldb/db/*.cc leveldb/db/*.h
	cd leveldb && $(MAKE) libleveldb.a
	cp leveldb/libleveldb.a ./

test: libsnappy.a libleveldb.a
	g++ -pthread -Ileveldb/include test.cpp -o test -L. -lleveldb -lsnappy

.PHONY: clean

clean:
	cd snappy && rm -rf build && rm -f libsnappy.a
	rm libsnappy.a
	cd leveldb && make clean
	rm libleveldb.a
