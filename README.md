Inmate
======

A build system where you make the rules.

# Basic Idea
The main inmate script doesn't do much at all - It simply looks for a controller that can build the given directory. Most of the heavy lifting is done by the default controller is no custom controllers are found. Custom controllers are found by filename convention:
    
    project/
        modules/
            _directory.rule
            dir1/
            dir2/
        images/
        images.rule
        html/

- The `project` root and `html` directories will both use inmate's default controller which looks up `.rule` files for each individual file.

- Each subdirectory in `modules` will use the custom `_directory.rule`

- Finally, the `images` directory will use `images.rule`

Directory rules receive two arguments:

    1. the source directory path, relative to the PWD `some/dir`
    2. the build target root directory `/project/_built`

Allowing for custom rules for an entire directory allows us to treat a collection of files as a whole. Something that a _default.rule cannot do for us.

## Default Controller - directory.rule
As in redo, by default inmate controller looks for executable rules to build each file. Each rule receives two arguments:

    1. the source file path, relative to the PWD: `some/file.ext`
    2. the target root directory `/project/_built`

File rules are looked up in the following order. (Files beginning with a `_` are ignored):

    # given foobar.ext

    # as a sibling to the src file only. Websites often have files of the same name at various levels of the tree.
    foobar.ext.rule

    # recursively up the file tree
    _default.foobar.ext.rule
    _default.ext.rule
    _default.rule

    # finally, if no rule is found
    INMATE/default.rule

## Default Rule
By default, any file not beginning with an _ will be copied to the target build directory.


### TODO:

- Plugins can be installed into the ~/.inmate/plugins directory to allow something like `inmate plugin amd-module $1` inside user created rules. (To make various tools more portable for those only interested in plug and play)
- Make allow for some user created commands to be inserted into the inmate life cycle? I have no idea why or if that would even be useful.

