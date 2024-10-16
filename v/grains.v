module main

import math {pow}

fn grains_on_square(square int) !u64 {
    return u64(pow(2, (square - 1)))
}

fn total_grains_on_board() u64 {
    mut res := u64(0)
    for i in 1..65 {
        res += u64(2 ^ (i - 1))
    }
    return res
}

println(grains_on_square(2)!)