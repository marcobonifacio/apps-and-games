module main

fn demo() {
	ia := i8(2)
	ib := i16(2)
	ic := int(2)

	println('----type definitions----')
	println('Variable ia is of type: ${typeof(ia).name}')
	println('Variable ib is of type: ${typeof(ib).name}')
	println('Variable ib is of type: ${typeof(ic).name}')
	println('')
	iaa := ia + ia // i8 with i8 results i8
	ibb := ib + ib // i16 with i16 results i16
	icc := ic + ic // int with int results int

	println('----mixing types----')
	println('Variable iaa is of type: ${typeof(iaa).name},
		after adding ${typeof(ia).name} with itself')
	println('Variable ibb is of type: ${typeof(ibb).name},
		after adding ${typeof(ib).name} with itself')
	println('Variable icc is of type: ${typeof(icc).name},
		after adding ${typeof(ic).name} with itself')
	println('')
	iab := ia + ib // i8 with i16 results in i16
	ibc := ib - ic // i16 with i32 results in i32

	println('----type promotion----')
	println('Variable iab is promoted to type: ${typeof(iab).name},
		after adding ${typeof(ia).name} with ${typeof(ib).name}')
	println('Variable ibc is promoted to type: ${typeof(ibc).name},
		after subtracting ${typeof(ib).name} with ${typeof(ic).name}')
	println('')

	iba := ib / ia // the division of i16 and i8 types

	println('Variable iba is promoted to the higher data type: 
		${typeof(iba).name}, which is carried from ib of type 
		${typeof(ib).name} divided from variable ia of type 
		${typeof(ia).name}')

	fa := f32(2)

	fa_iba := fa + iba // fa is type of f32 and iba is of type i32

	println('Variable fa_iba is promoted to the higher data type: 
		${typeof(fa_iba).name}, which is carried from fa of type 
		${typeof(fa).name} when added with variable iba of type 
		${typeof(iba).name}')
}

fn main() {
	demo()
}