## Installation

* Edit config/database.yml (using config/database.yml.example)
* Setup the database

```shell
    rake db:setup
    rake db:migrate
```

* Setup git pre-commit hook
```shell
    ln -s ../../pre-commit/rubohook.rb .git/hooks/pre-commit
    chmod +x .git/hooks/pre-commit
```
