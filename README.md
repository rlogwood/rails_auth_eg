# Example Implementation of Rails 7.1 Authentication

This code was created from the following video:
[GoRails Rails 7.1 Authentication From Scratch](https://youtu.be/Hb9WtQf9K60?si=7JtHXMlzqTPVu9iY)

### Installing / Running the app
```shell
git clone https://github.com/rlogwood/rails_auth_eg.git
cd rails_auth_eg
bin/bundle
bin/rails db:prepare
bin/dev
```


### The app was originally created with the following options:
```shell
rails new (appname) --asset-pipeline=propshaft --javascript=importmap --css=tailwind --database=sqlite3
```

### Experiment with rate limiting
Rate limiting was added to the sessions controller as follows.
see [Rate Limiting Requests in Rails 7.2](https://youtu.be/n0GdAHGRMhE?si=PQTEfAe56Oh0kg2Q)
```ruby
class SessionsController < ApplicationController
  # TODO: determine best settings for rate_limit
  rate_limit to: 5, within: 1.minutes, by: -> { request.remote_ip },
             with: -> { head :too_many_requests, alert: "Too many requests"}

```



### Password resets
To test password resets, look for the generated email in the log and cut and paste the link found. Here's an example:
```html
23:30:11 web.1  | <!-- BEGIN app/views/layouts/mailer.html.erb --><!DOCTYPE html>
23:30:11 web.1  | <html>
23:30:11 web.1  |   <head>
23:30:11 web.1  |     <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
23:30:11 web.1  |     <style>
23:30:11 web.1  |       /* Email styles need to be inline */
23:30:11 web.1  |     </style>
23:30:11 web.1  |   </head>
23:30:11 web.1  |
23:30:11 web.1  |   <body>
23:30:11 web.1  |     <!-- BEGIN app/views/password_mailer/password_reset.html.erb --><a href="http://localhost:3000/password_reset/edit?token=eyJfcmFpbHMiOnsiZGF0YSI6WzEsIldHU2YuN01xQ3UiXSwiZXhwIjoiMjAyNC0wOC0yNFQwMzo0NToxMS41NzJaIiwicHVyIjoiVXNlclxucGFzc3dvcmRfcmVzZXRcbjkwMCJ9fQ%3D%3D--49f86bf9485f884880b3ec5519e8e576353eb41f">Reset your password</a>
23:30:11 web.1  | <!-- END app/views/password_mailer/password_reset.html.erb -->
23:30:11 web.1  |   </body>
23:30:11 web.1  | </html>
23:30:11 web.1  | <!-- END app/views/layouts/mailer.html.erb -->
```

### Tailwind Intellisense for RubyMine Users
```shell
yarn add -D tailwindcss
# Restart the IDE, TailwindCSS intellisense will start to work
# To Undo this development fix:
rm -fR node_modules
rm package.json yarn.lock
```
