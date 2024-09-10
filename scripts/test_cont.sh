CONFIGDIR="."
WKDIR="/home/yymone/git/zkWasm"

BATCH_INFO_INIT=$CONFIGDIR/sample/cont-init.json
BATCH_INFO_RECT=$CONFIGDIR/sample/cont-rec.json
BATCH_INFO_FINAL=$CONFIGDIR/sample/cont-final.json

# Make sure the name field in fibonacci.loadinfo.json is changed to single to fit the above batch configure
RUST_BACKTRACE=1 CUDA_VISIBLE_DEVICES=1 cargo run --features perf --release -- --params $WKDIR/params --output $WKDIR/output batch -k 23  -s shplonk --challenge keccak --info $WKDIR/output/fibonacci.loadinfo.json --name fib_agg --commits $BATCH_INFO_INIT $BATCH_INFO_RECT $BATCH_INFO_FINAL --cont 4

cargo run --release --features cuda -- --params $WKDIR/params --output $WKDIR/output verify --challenge keccak --info $WKDIR/output/fib_agg.final.loadinfo.json
