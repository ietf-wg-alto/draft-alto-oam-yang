# Terminology

This document uses the following acronyms:

- OAM - Operations, Administration, and Maintainance
- O&M - OAM and Management

## Tree Diagrams

A simplified graphical representation of the data model is used in this
document. The meaning of the symbols in these diagrams is defined in
{{RFC8340}}.

## Prefixes in Data Node Names

In this document, names of data nodes and other data model objects are often
used without a prefix, as long as it is clear from the context in which YANG
module each name is defined. Otherwise, names are prefixed using the standard
prefix associated with the corresponding YANG module, as shown in [](#tbl-yang-prefixes).

|---
| Prefix | YANG module | Reference
|:-|:-|:-
| yang | ietf-yang-types | {{RFC6991}}
| inet | ietf-inet-types | {{RFC6991}}
| tcp | ietf-tcp-server | {{I-D.ietf-netconf-tcp-client-server}}
| tls | ietf-tls-server | {{I-D.ietf-netconf-tls-client-server}}
| http | ietf-http-server | {{I-D.ietf-netconf-http-client-server}}
{: #tbl-yang-prefixes title="Prefixes and corresponding YANG modules"}

## Placeholders in reference Statement

Note to the RFC Editor: This section is to be removed prior to publication.

This draft contains placeholder values that need to be replaced with finalized
values at the time of publication.  This note summarizes all of the
substitutions that are needed.  No other RFC Editor instructions are specified
elsewhere in this document.

Artwork in this document contains shorthand references to drafts in progress.
Please apply the following replacements:

- DDDD --> the assigned RFC value for draft-ietf-netconf-tcp-client-server
- FFFF --> the assigned RFC value for draft-ietf-netconf-tls-client-server
- GGGG --> the assigned RFC value for draft-ietf-netconf-http-client-server
- HHHH --> the assigned RFC value for draft-ietf-netconf-netconf-client-server
- IIII --> the assigned RFC value for draft-ietf-netconf-restconf-client-server
- XXXX --> the assigned RFC value for this draft
- YYYY --> the assigned RFC value for draft-ietf-alto-performance-metrics

<!-- End of sections -->
