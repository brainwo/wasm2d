#!/bin/bash
#	 _____________________ 
#	< How may I help you? >
#	 --------------------- 
#	        \   ^__^
#	         \  (oo)\_______
#	            (__)\       )\/\
#	                ||----w |
#	                ||     ||

cargo build --target wasm32-unknown-unknown --release
mv target/wasm32-unknown-unknown/release/*.wasm www/module.wasm
du www/module.wasm
echo "Stripping down wasm build"
wasm-gc www/module.wasm
du www/module.wasm

