# afEfan

`afEfan` is a [Fantom](http://fantom.org/) library for rendering Embedded Fantom (efan) templates.

Much like `EJS` for Javascript, `ERB` for Ruby and `JSP` for Java, `efan` allows you to embed snippets of Fantom code inside textual templates.

`afEfan` aims to hit the middle ground between programmatically rendering markup with `web::WebOutStream` and using logicless templates with [Mustache](https://bitbucket.org/xored/mustache/).



## Quick Start

xmas.efan:

    <% ctx.times |i| { %>
      Ho! 
    <% } %>
    Merry Christmas!


Fantom code:

    // --> Ho! Ho! Ho! Merry Christmas!
    Efan().renderFromStr(`xmas.fan`.toFile.readAllStr, 3)



## Documentation

Full API & fandocs are available on the [status302 repository](http://repo.status302.com/doc/afEfan/#overview).



## Install

Download from [status302](http://repo.status302.com/browse/afEfan).

Or install via fanr:

    $ fanr install -r http://repo.status302.com/fanr/ afEfan

To use in a project, add a dependency in your `build.fan`:

    depends = ["sys 1.0", ..., "afEfan 0+"]
