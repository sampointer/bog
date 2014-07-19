# bog

![OpsUnit Logo][99]

A tool for managing cloud API and configuration management credentials. rbenv for dotfiles.

It is brought to you by the folks at [OpsUnit][1].

## Example
```bash
$ bog init myclient  --aws --chef	# Configure ~/.bog with stubs for AWS and Chef under profile 'myclient'
$ bog init myclient --aws --prompt	# Configure with AWS stubs and prompt for credentials
Enter your Amazon Secrect Access Key:
...
$ bog myclient					# Switch to profile 'myclient'
$ knife client list
$ aws s3 ls
...
$ bog personal					# Switch to another profile
$ bog personal exec knife environment show	# Execute a command in the context of a profile and revert
...
```
## How it works
`bog init myclient --aws --chef` will create 

```
.bog
├── current -> profiles/myclient/
├── plugins
└── profiles
    └── myclient
        ├── .aws
        └── .chef
```
If you passed `--prompt` then the correctly named configuration files will be present and populated. Otherwise you
are free to include whatever you choose.

Within your `$HOME` directory symlinks to the various directories will be made, pointing towards the appropriate directories
under `~/.bog/profiles`. `bog` determines the active profile from the destination of the `~/.bog/current` symlink, although
repointing that symlink will not cause the directories under `$HOME` to be repointed unless `bog profilename` is executed.

`bog profilename exec command` will swap the dot directories for the profile given into place, execute the command, and then
return to the previous state (`~/.bog/current` is not repointed during this).

## Plugins
`bog` includes a plugin system to enable you to extend it. You are very much encouraged to contribute plugins back to the project
by submitting a pull request against the gem.

The current default plugins are:

* `chef`: manage configuration in `~/.chef`, including keys, validators and `knife.rb`
* `ssh`: manage `~/.ssh`
* `aws`: manage configuration in `~/.aws/config`

If you'd like to write your own you can place them in any directory structure you choose under `~/.bog/plugins`.

## Why another dotfile manager
There are plenty out there. `bog` aims to fit a modern operational workflow and toolset.

## Development

The gem and its dependencies are tested against the following ruby versions:

* 1.9.3
* 2.0.0
* 2.1.0

[1]: http://www.opsunit.com
[99]: http://opsunit.com/assets/images/opsunit-logo-large.png
