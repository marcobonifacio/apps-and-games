import term
import os

fn main() {
    term.clear() // clears the content in the terminal
    width, height := term.get_terminal_size() // get the size of the terminal
    term.set_cursor_position(x: width / 2, y: height / 2) // now we point the cursor to the middle of  the terminal
    println(term.strikethrough(term.bright_green('hello world'))) // Print green text
    term.set_cursor_position(x: 0, y: height) // Sets the position of the cursor to the bottom of the terminal
    // Keep prompting until the user presses the q key
    for {
        if var := os.input_opt('press q to quit: ') {
            if var != 'q' {
                continue
            }
            break
        }
        println('')
        break
    }
    println('Goodbye.')
}