# GitDeploy
[![endorse](https://api.coderwall.com/hauleth/endorsecount.png)](https://coderwall.com/hauleth)

This is module for creating git-deployable services in super easy way. Under hard development, but
I hope that in future it will be more configureable and advanced than Heroku (if you will help me
to achieve that ;)).

## Usage

Firstyly we need to be sure that we have all needed apps and required users/paths/etc.:

    class {'gitdeploy':}

But it will be nice if all developers have privileges to push to the git repo. So add on server file
that meets `authorized_keys` syntax and write:

    class {'gitdeploy':
      authkeyspath => 'puppet:///ssh/authorized_keys'
    }

To create project use:

    gitdeploy::project { 'project_name':
      path => '/path/to/contain/your_app'
    }

After that you should be able to push your application to server:

    $ git remote add production git@your-server:project_name.git
    $ git push production master

After that all files should be checkouted to `path`, all gems installed (so far this accept only
Ruby apps that use Bundler) and server should start using Foreman.

## TODO

- Add Redis to store each app configuration
- Write simple CLI managament tool
- Privileges for write to repository per user, now everyone is allowed to write to all (of course if
  is in `authorized_keys`)
- Add more detectable projects, now only Ruby apps that use Bundler are allowed
- Allow to configure Foreman instances

## License

See `LICENCE` file.
