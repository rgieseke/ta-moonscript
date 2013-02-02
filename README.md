## [MoonScript](http://moonscript.org) module for the [Textadept](http://foicica.com/textadept/) editor

### Installation

Clone this repository into your `.textadept/modules` directory:

    cd ~/.textadept/modules
    git clone https://github.com/rgieseke/ta-moonscript.git moonscript

Copy the MoonScript lexer from lexer/moonscript.lua to

    .textadept/lexers

or create a symlink.

Add

    % MoonScript
    moon moonscript

to your

    .textadept/mime_types.conf

file.

### Notes

This was my first attempt at writing MoonScript, pull requests welcome!

To edit and compile the module with the watch option run
    moonc -w init.moon
in your terminal.

### License
[MIT](http://www.opensource.org/licenses/mit-license.php)

Moonscript lexer:

Copyright 2006-2011 Mitchell mitchell<att>caladbolg.net.

Moonscript lexer by leaf corcoran <http://leafo.net>

Moonscript module:

2012, Robert Gieseke, robert.gieseke@gmail.com

