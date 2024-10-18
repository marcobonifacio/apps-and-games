import net.html

fn main() {
    doc := html.parse('<html><body><h1 class="title">Hello world!</h1></body></html>')
    tag := doc.get_tags(name: 'h1')[0] // Hello world!

    println(tag.name) // h1
    println(tag.content) // Hello world!
    println(tag.attributes) // {'class':'title'}
    println(tag.str()) // Hello world!

}