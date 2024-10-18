import wasm
import os

fn main() {
    mut m := wasm.Module{}
    mut func := m.new_function('add', [.i32_t, .i32_t], [.i32_t])
    {
        func.local_get(0) // | local.get 0
        func.local_get(1) // | local.get 1
        func.add(.i32_t) // | i32.add
    }
    m.commit(func, true) // `export: true`

    mod := m.compile() // []u8

    os.write_file_array('add.wasm', mod)!
}