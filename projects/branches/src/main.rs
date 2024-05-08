fn fahrenheit_to_celsius(degrees: f64) -> f64 {
    (degrees - 32.0) * 5.0 / 9.0
}

fn celsius_to_fahrenheit(degrees: f64) -> f64 {
    degrees * 9.0 / 5.0 + 32.0
}

fn fibonacci(n: u32) -> u32 {
    if n == 1 {
        0
    } else if n == 2 {
        1
    } else {
        fibonacci(n-1) + fibonacci(n-2)
    }
}

fn twelve_days() {
    let days = [
        "first", "second", "third", "fourth", "fifth", "sixth",
        "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth"
    ];
    let gifts = [
        "a partridge in a pear tree", "two turtle doves",
        "three French hens", "four calling birds", "five gold rings",
        "six geese a-laying", "seven swans a-swimming",
        "eight maids a-milking", "nine ladies dancing",
        "ten lords a-leaping", "eleven pipers piping", 
        "twelve drummers drumming"
    ];
    let mut ending = String::new();
    let mut n = 0;
    while n < 12 {
        if n == 0 {
            ending = gifts[n].to_owned() + ".\n" + &ending;
        } else if n == 1 {
            ending = gifts[n].to_owned() + ",\nand " + &ending;
        } else {
            ending = gifts[n].to_owned() + ",\n" + &ending;
        }
        println!(
            "On the {} day of Christmas\nmy true love sent to me:", &days[n]
        );
        println!("{ending}");
        n +=1
    };
}

fn main() {
    let fahrenheit = 32.0;
    let celsius = fahrenheit_to_celsius(fahrenheit);
    println!("{fahrenheit}°F equals to {celsius}°C\n");

    let celsius = 100.0;
    let fahrenheit = celsius_to_fahrenheit(celsius);
    println!("{celsius}°C equals to {fahrenheit}°F\n");

    let n = 10;
    let fib = fibonacci(n);
    println!("{n}th Fibonacci number is {fib}\n");

    twelve_days()
}