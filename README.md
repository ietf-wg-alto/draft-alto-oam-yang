# YANG Data Models for the Application-Layer Traffic Optimization (ALTO) Protocol

[![Action Status](https://github.com/ietf-wg-alto/draft-ietf-alto-oam-yang/actions/workflows/ghpages.yml/badge.svg)](https://github.com/ietf-wg-alto/draft-ietf-alto-oam-yang/actions/workflows/ghpages.yml)
![GitHub Tag](https://img.shields.io/github/v/tag/ietf-wg-alto/draft-ietf-alto-oam-yang)

This is the working area for the Working Group Internet-Draft, "YANG Data Models for the Application-Layer Traffic Optimization (ALTO) Protocol", to meet the
[ALTO WG Charter](https://datatracker.ietf.org/doc/charter-ietf-alto/).

* [Editor's Copy](https://ietf-wg-alto.github.io/draft-ietf-alto-oam-yang/#go.draft-ietf-alto-oam-yang.html)
* [WG Draft](https://tools.ietf.org/html/draft-ietf-alto-oam-yang)
* [Compare Editor's Copy to WG Draft](https://ietf-wg-alto.github.io/draft-ietf-alto-oam-yang/#go.draft-ietf-alto-oam-yang.diff)

If you have any question or comment, please feel free to
[open an issue](https://github.com/ietf-wg-alto/draft-ietf-alto-oam-yang/issues).

## Building the Draft

Formatted text and HTML versions of the draft can be built using `make`.

```sh
$ make
```

This requires that you have the necessary software installed.  See
[the instructions](https://github.com/martinthomson/i-d-template/blob/master/doc/SETUP.md).


## Checking YANG Modules

This repo also provides useful tools to checking the related YANG modules.

### Validating Syntax of YANG Modules

You can use `pyang` to validate the syntax of YANG modules:

```sh
$ make pyang-lint
```

This requires that you have Python and `pyang` installed. See
[the home page of `pyang`](https://github.com/mbj4668/pyang).

Also, you can use `libyang` to validate the syntax of YANG modules for more detailed information:

```sh
$ make yang-lint
```

This requires that you have the `libyang` library and the `yanglint` binary installed. See
[the `libyang` GitHub repo](https://github.com/CESNET/libyang).

### Validating JSON Examples

You can use `yangson` to validate your JSON examples:

```sh
$ make yangson-validate
```

This requires that you have `yangson` installed and the correct `yang-library-ietf-alto.json` file configured. See
[the `yangson` user guide](https://yangson.labs.nic.cz/) and
[the example use cases](https://yangson.labs.nic.cz/examples.html).

### Generating YANG Tree Diagrams

You can generate YANG tree diagrams defined by [RFC8340](https://datatracker.ietf.org/doc/html/rfc8340):

```sh
$ make yang-gen-diagram
```

## Contributing

See the
[guidelines for contributions](https://github.com/ietf-wg-alto/draft-ietf-alto-oam-yang/blob/main/CONTRIBUTING.md).
