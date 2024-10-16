module main

fn main() {
	t := true
	f := false

	// Logical And using && operator
	and_tt := t && t
	and_tf := t && f
	and_ft := f && t
	and_ff := f && f

	println('Logical And using && operator')
	println('$t && $t = $and_tt')
	println('$t && $f = $and_tf')
	println('$f && $t = $and_ft')
	println('$f && $f = $and_ff')
	println('')

	// Logical Or using || operator
	or_tt := t || t
	or_tf := t || f
	or_ft := f || t
	or_ff := f || f

	println('Logical Or using || operator')
	println('$t || $t = $or_tt')
	println('$t || $f = $or_tf')
	println('$f || $t = $or_ft')
	println('$f || $f = $or_ff')
	println('')

	// Logical Not using ! operator
	not_t := !t
	not_f := !f
	
	println('Logical Not using ! operator')
	println('!$t = $not_t')
	println('!$f = $not_f')
}