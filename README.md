# bog [![Build Status](https://travis-ci.org/opsunit/bog.svg?branch=master)](https://travis-ci.org/opsunit/bog) [![Gem Version](https://badge.fury.io/rb/bog.svg)](http://badge.fury.io/rb/bog) ![](http://ruby-gem-downloads-badge.herokuapp.com/bog?type=total) <img align="right" width="370" height="80" src="http://opsunit.com/assets/images/opsunit-logo-large.png" alt="opsunit" />

A tool for managing cloud API and configuration management credentials. rbenv for dotfiles.

It is brought to you by the folks at [OpsUnit][1].

## Introduction
In a modern operations team it is common to have many different sets of credentials and dotfile configurations.
You may have multiple clients, or may split your environments between EC2 accounts. `bog` allows you to easily
work with collections of dotfile configurations and to swap between those sets.

## Example
The traditional form, where you manually switch profiles:

```bash
$ bog myclient init --aws 	# Configure ~/.bog with a stub for AWS under profile 'myclient'
Enter your Amazon Secret Access Key:
...
$ bog myclient					# Switch to profile 'myclient'
$ knife client list
$ aws s3 ls
...
$ bog personal					# Switch to another profile
...
$ bog                   # Show the current profile
personal
$ bog -l                # List available profiles - * indicates current profile
myclient
personal*
```
With roaming profiles enabled:
```bash
$ bog personal default  # Set default profile
$ source ~/.bog/bog.sh  # Source shell helpers
$ cd ~/src/project
$ echo "myclient" > .bog-profile
$ bog                   # Profile set by dotfile
myclient
$ cd ..
$ bog                   # Profile set from default
personal                # without dotfile present
$ bog someprofile
$ bog                   # Setting profile ignored
personal                # with roaming profiles
```

### One-off commands
```bash
$ bog myclient exec aws s3 ls          # Exec command as myclient, then
$ bog myclient exec knife client list  # switch back to previous profile
...
```

## How it works
`bog init myclient` will create

```
.bog
├── current -> profiles/myclient/
├── plugins
└── profiles
    └── myclient
```
`bog` will never touch your `~/.aws` and similar directories. You will need to:

* populate `~/.bog/profiles/myclient/` with dotfiles and directories for that profile.
* symlink the directory the tool would look for:  `ln -s ~/.bog/current/.aws ~/.aws`

When profiles are switched the `~/.bog/current` symlink is repointed.

### Roaming profiles
By sourcing `~/.bog/bog.sh` into your shell environment and placing a file called `.bog-profile` into one or more directories you can take advantage of roaming profiles. In short, when `bog` detects such a file it'll automatically change your current profile to that given in the dotfile. This enables you to easily work with per-project profiles, for example.

It does this by recursing up from the current directory until it either finds a `.bog-profile` file or fails and continues with the **default profile**. You should be aware of the implications therefore of nested directories and of the implications for concurrency when running commands under `bog` in multiple terminals.

It also expects you to have a default profile configured for when a dotfile cannot be found. You can do this by executing `bog PROFILE default`.

**Be aware that using roaming profiles is mutally exclusive to using `bog PROFILE` to set your profile. IT WILL BE IGNORED. Your current profile will be determined either from the presence of a dotfile or from your default.**

You should be sure to source `~/.bog/bog.sh` **after** anything else that might hook into `$PROMPT_COMMAND`, such as chruby, rvm, or liquidprompt.

## Why another dotfile manager
There are plenty out there. `bog` aims to fit a modern operational workflow and toolset.

## Development

The gem and its dependencies are tested against the following ruby versions:

* 1.9.3
* 2.0.0
* 2.1.0
* 2.2.2

[1]: http://www.opsunit.com
