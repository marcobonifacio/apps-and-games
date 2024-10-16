module main

fn response(hey_bob string) string {
	res := match true {
		hey_bob.bytes().all(it.is_space()) { "Fine.Be that way!" }
		hey_bob.is_upper() && hey_bob[hey_bob.len - 1].ascii_str() == '?' { "Calm down, I know what I'm doing!" }
		hey_bob.is_upper() { "Whoa, chill out!" }
		hey_bob[hey_bob.len - 1].ascii_str() == '?' { "Sure." }
		else { "Whatever." }
	}
	return res
}

println(response(''))
