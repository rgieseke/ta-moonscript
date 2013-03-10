## [MoonScript](http://moonscript.org) module for the [Textadept](http://foicica.com/textadept/) editor

### Installation

Clone this repository into your `.textadept/modules` directory:

    cd ~/.textadept/modules
    git clone https://github.com/rgieseke/ta-moonscript.git moonscript

Download a copy of the MoonScript lexer from
<https://github.com/leafo/moonscript/blob/master/extra/scintillua/lexers/moonscript.lua>
into your `lexers` directory, e.g.

    cd ~/.textadept/lexers
    wget https://raw.github.com/leafo/moonscript/master/extra/scintillua/lexers/moonscript.lua

Add

    % MoonScript
    moon moonscript

to your

    ~/.textadept/mime_types.conf

file.

### Notes

This was my first attempt at writing MoonScript, pull requests welcome!

To edit and compile the module with the watch option run
    moonc -w init.moon
in your terminal.

### License
[MIT](http://www.opensource.org/licenses/mit-license.php)

2012-13, Robert Gieseke, robert.gieseke@gmail.com

