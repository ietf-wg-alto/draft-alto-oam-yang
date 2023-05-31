# Acronyms and Abbreviations

This document uses the following acronyms:

ALTO:
  : Application-Layer Traffic Optimization

CPU:
  : Central Processing Unit

DNS:
  : Domain Name System

HTTP:
  : Hypertext Transfer Protocol

IRR:
  : Internet Routing Registry

OAM:
  : Operations, Administration, and Maintenance (Section 3 of {{?RFC6291}})

O&M:
  : OAM and Management (Section 3 of {{?RFC6291}})

OAuth:
  : Open Authorization

PID:
  : Provider-defined Identifier in ALTO

TCP:
  : Transmission Control Protocol

TLS:
  : Transport Layer Security

URI:
  : Uniform Resource Identifier

## Tree Diagrams

The meaning of the symbols in the tree diagrams is defined in
{{?RFC8340}}.

## Prefixes in Data Node Names

The complete name of a data node or data model object includes a prefix, which
indicates the YANG module in which the name is defined. In this document, the
prefix is omitted when the YANG module is clear from the context; otherwise,
the prefix is included. The prefixes indicating the corresponding YANG modules
are shown in [](#tbl-yang-prefixes).

|---
| Prefix | YANG module | Reference
|:-|:-|:-
| yang | ietf-yang-types | {{RFC6991}}
| inet | ietf-inet-types | {{RFC6991}}
| ds | ietf-datastores | {{RFC8342}}
| yp | ietf-yang-push | {{RFC8641}}
| tcp | ietf-tcp-server | {{I-D.ietf-netconf-tcp-client-server}}
| tls | ietf-tls-server | {{I-D.ietf-netconf-tls-client-server}}
| http | ietf-http-server | {{I-D.ietf-netconf-http-client-server}}
| ncc | ietf-netconf-client | {{I-D.ietf-netconf-netconf-client-server}}
| rcc | ietf-restconf-client | {{I-D.ietf-netconf-restconf-client-server}}
{: #tbl-yang-prefixes title="Prefixes and corresponding YANG modules"}

## Placeholders in Reference Statements

Note to the RFC Editor: This section is to be removed prior to publication.

This document contains placeholder values that need to be replaced with finalized
values at the time of publication.  This note summarizes all of the
substitutions that are needed.  No other RFC Editor instructions are specified
elsewhere in this document.

Please apply the following replacements:

- DDDD --> the assigned RFC number for {{I-D.ietf-netconf-tcp-client-server}}
- FFFF --> the assigned RFC number for {{I-D.ietf-netconf-tls-client-server}}
- GGGG --> the assigned RFC number for {{I-D.ietf-netconf-http-client-server}}
- HHHH --> the assigned RFC number for {{I-D.ietf-netconf-netconf-client-server}}
- IIII --> the assigned RFC number for {{I-D.ietf-netconf-restconf-client-server}}
- XXXX --> the assigned RFC number for this draft
- YYYY --> the assigned RFC number for {{I-D.ietf-alto-performance-metrics}}

<!-- End of sections -->
