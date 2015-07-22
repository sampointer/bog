# bog [![Build Status](https://travis-ci.org/opsunit/bog.svg?branch=master)](https://travis-ci.org/opsunit/bog)

![OpsUnit Logo][99]

A tool for managing cloud API and configuration management credentials. rbenv for dotfiles.

It is brought to you by the folks at [OpsUnit][1].

## Introduction
In a modern operations team it is common to have many different sets of credentials and dotfile configurations.
You may have multiple clients, or may split your environments between EC2 accounts. `bog` allows you to easily
work with collections of dotfile configurations and to swap between those sets.

## Example
```bash
$ bog myclient init --aws 	# Configure ~/.bog with a stub for AWS under profile 'myclient'
Enter your Amazon Secrect Access Key:
...
$ bog myclient					# Switch to profile 'myclient'
$ knife client list
$ aws s3 ls
...
$ bog personal					# Switch to another profile
...
```

### One-off commands 
```bash
$ bog myclient exec aws s3 ls          # Exec command as myclient, then
$ bog myclient exec knife client list  # switch back to previous profile 
...
```

## How it works
`bog init myclient --aws` will create 

```
.bog
├── current -> profiles/myclient/
├── plugins
└── profiles
    └── myclient
        └── .aws
```
If you passed a switch such as `--aws` then the correctly named configuration files will be present and populated. Otherwise you
are free to include whatever you choose.

`bog` will never touch your `~/.aws` and similar directories. You will need to symlink these to `~/.bog/current/.aws` (as appropriate) in order to have bog work.

### Roaming profiles
By sourcing `~/.bog/bog.sh` into your shell environment and placing a file called `.bog-profile` into one or more directories you can take advantage of roaming profiles. In short, when `bog` detects such a file it'll automatically change your current profile to that given in the dotfile. This enables you to easily work with per-project profiles, for example.

It does this by recursing up from the current directory until it either finds a `.bog-profile` file or fails and continues with the current profile. You should be aware of the implications therefore of nested directories and of the implications for concurrency when running commands under `bog` in multiple terminals.

You should be sure to source `~/.bog/bog.sh` **after** anything else that might hook into `$PROMPT_COMMAND`, such as chruby, rvm, or liquidprompt.

## Why another dotfile manager
There are plenty out there. `bog` aims to fit a modern operational workflow and toolset.

## Development

The gem and its dependencies are tested against the following ruby versions:

* 1.9.3
* 2.0.0
* 2.1.0

[1]: http://www.opsunit.com
[99]: http://opsunit.com/assets/images/opsunit-logo-large.png
