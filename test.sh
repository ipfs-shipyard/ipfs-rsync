#!/bin/bash
set -ex

clean() {
	rm -rf test source
	#ipfs pin ls --type recursive | cut -d' ' -f1 | ipfs pin rm || :
	ipfs files stat --hash /test | ipfs pin rm || :
	ipfs files rm -r --force /test
	ipfs repo gc
}

output() {
	ipfs filestore ls
}

clean

mkdir -p "source/test/ab"
echo a > "source/test/ab/a"
echo b > "source/test/ab/b"
echo c > "source/test/c"
echo d > "source/test/d"

rsync -rtLivH --delete source/test . | ./ipfs-rsync

output

echo aa > "source/test/ab/a"
echo ab > "source/test/ab/b"
echo d > "source/test/c"
echo c > "source/test/d"

rsync -rtLivH --delete source/test . | ./ipfs-rsync

output

rm -r "source/test/ab"

rsync -rtLivH --delete source/test . | ./ipfs-rsync

output

clean
