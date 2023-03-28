#!/bin/bash
set -ex

clean() {
	rm -rf test source
	#ipfs pin ls --type recursive | cut -d' ' -f1 | ipfs pin rm || :
	ipfs files stat --hash /test | ipfs pin rm || :
	ipfs files rm -r --force /test
	ipfs repo gc
}

clean

mkdir -p "source/test/a"
echo a > "source/test/a/a"
echo b > "source/test/a/b"
echo b > "source/test/b"

rsync -rtLivH --delete source/test . | ./ipfs-rsync

ipfs files ls /test
ipfs files ls /test/a
ipfs files read "/test/b"

echo b >> "source/test/b"
echo b > "source/test/a/a"

rsync -rtLivH --delete source/test . | ./ipfs-rsync

ipfs files read "/test/b"

rm -r "source/test/a"

rsync -rtLivH --delete source/test . | ./ipfs-rsync

ipfs files ls /test
ipfs pin ls

clean
