module main

import veb

pub struct User {
pub mut:
    name string
    id   int
}

// Our context struct must embed `veb.Context`!
pub struct Context {
    veb.Context
pub mut:
    // In the context struct we store data that could be different
    // for each request. Like a User struct or a session id
    user       User
    session_id string
}

pub struct App {
pub:
    // In the app struct we store data that should be accessible by all endpoints.
    // For example, a database or configuration values.
    secret_key string
}

// This is how endpoints are defined in veb. This is the index route
pub fn (app &App) index(mut ctx Context) veb.Result {
    return ctx.text('Hello V! The secret key is "${app.secret_key}"')
}

fn main() {
    mut app := &App{
        secret_key: 'secret'
    }
    // Pass the App and context type and start the web server on port 8080
    veb.run[App, Context](mut app, 8080)
}