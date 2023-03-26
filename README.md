# ipfs-rsync
Parses rsync output and modifies data in IPFS accordingly

### Requirement

* Python 3
* IPFS with filestore enabled
* Rsync with `-i` option enabled

### Usage

#### For debugging or the first try

* Save the outputs of rsync:

```sh
rsync -i source destination | tee rsync.log
```

* Run `ipfs-sync` with `--dry-run` and check the output `ipfs` commands:

```sh
cat rsync.log | ipfs-rsync --dry-run
```

* Adjust the `local-prefix` and `ipfs-prefix` if needed:

```sh
cat rsync.log | ipfs-rsync --dry-run --local-prefix your_local_prefix --ipfs-prefix your_ipfs_prefix
```

* If the output commands look good, run it with:

```sh
cat rsync.log | ipfs-rsync --local-prefix your_local_prefix --ipfs-prefix your_ipfs_prefix
```

#### For formal use

```sh
rsync -i source destination | ipfs-sync
```
