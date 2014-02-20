![CI In a Can](https://raw.github.com/darrencauthon/ci_in_a_can/master/assets/smalllogo.png)

# CI In a Can

Super-easy continuous integration.  With one command, you can turn a cloud server (AWS, Digital Ocean) into a CI server for Ruby apps. Others (like node, .Net) coming soon.

This currently only hooks to Github repos.  More later.

## Philosophy

CI should be as easy as running tests on your own computer.  When a change is made, your CI server should download the changes, run the tests, and report the results.

So that's what this application does.  It handles the basics... receiving notifications of new pushes, running the tests, and reporting back the results.  

And just like running the tests on your own computer... you'll have to set up your server to run your app.  That's outside the scope of CI In a Can.  But once your server can run the tests, CI In a Can will work for you.

## Installation

Install with:

    $ gem install ci_in_a_can

## Usage

Run:

````
ciinacan create YOUR_NAME
cd YOUR_NAME
rake start
````

This will create a directory named YOUR_NAME, start up a Sinatra app on port 80, and start a backend service for running builds.  **You now have a running CI server.**

For any project you want to hook to a CI server, add a Github webhook to "http://YOUR_WEBSITE".  

When any push is made to your Github repository, Github will send a notification to your Sinatra site.  This will initiate a clone, run the usual stuff you need "bundle install, etc.", then run "bundle exec rake" to run your tests.

## Requirements

1.  A default rake task that runs all of your tests.
2.  An environment variable named GITHUB_AUTH_TOKEN.  This is used to report results back to Github.
3.  An environment variable named SITE_URL.  This will be the URL of your site, for things like providing Github with a link back to the site to show test results.
4.  A server that will "just run" your application.  Set up your own server with whatever dependencies your application needs.  
5.  An environment variable named PASSPHRASE. You'll need to provide this if you want to make config changes. You may not need to do this, so this step is optional.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
