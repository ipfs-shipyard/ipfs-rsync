#!/bin/bash
set -ex

rm -rf test source
ipfs files rm -r --force /test
ipfs repo gc

mkdir -p "source/test/a"
echo a > "source/test/a/a"
echo b > "source/test/a/b"
echo b > "source/test/b"

rsync -rtLivH --delete-after --delay-updates source/test . | ./ipfs-rsync

ipfs files ls /test
ipfs files ls /test/a
ipfs files read "/test/b"

echo b >> "source/test/b"

rsync -rtLivH --delete-after --delay-updates source/test . | ./ipfs-rsync

ipfs files read "/test/b"

rm -r "source/test/a"

rsync -rtLivH --delete-after --delay-updates source/test . | ./ipfs-rsync

ipfs files ls /test

rm -rf test source
