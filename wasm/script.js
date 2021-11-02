let wasmExports = null;
let wasmMemory = new WebAssembly.Memory({initial:256, maxmum:256});

async function loadWasm(){
  let res = await fetch('fn.wasm');
  let bytes = await res.arrayBuffer();
  let wasmObj = await WebAssembly.instantiate(bytes, info);
  wasmExports = wasmObj.instance.exports;
}
