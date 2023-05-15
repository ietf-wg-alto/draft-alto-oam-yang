# Security Considerations

The "ietf-alto" and "ietf-alto-stats" YANG modules define data nodes that are designed to be accessed
via YANG based management protocols, such as NETCONF {{RFC6241}} and RESTCONF
{{RFC8040}}. Both of these protocols have mandatory-to-implement secure
transport layers (e.g., SSH, TLS) with mutual authentication.

The Network Access Control Model (NACM) {{RFC8341}} provides the means to
restrict access for particular users to a pre-configured subset of all
available protocol operations and content.

None of the readable data nodes in these YANG modules are considered sensitive or
vulnerable in network environments. The NACM "default-deny-all" extension has
not been set for any data nodes defined in these module.

None of the writable data nodes in these YANG modules are considered sensitive
in network environments. The NACM "default-deny-write" extension has not been
set for any data nodes defined in these modules.

However, there are a number of writable data nodes defined in these YANG
modules that are considered vulnerable in network environments. Write
operations to these data nodes without proper protection can have a negative
effect. These are the data nodes and their vulnerable:

feed-interval:
  : A malicious client could attempt to set a very low/large value to this
  node. Setting a very low value could attack the data source. And setting a
  very large value would lead to maintaining stale data in the ALTO server.

poll-interval:
  : A malicious client could attempt to set a very low/large value to this
  node. Setting a very low value could attack the data source. And setting a
  very large value would lead to maintaining stale data in the ALTO server.

The "ietf-alto" supports an HTTP listen mode to cover cases where the ALTO
server stack does not handle the TLS termination itself, but is handled by a
separate component. Special care should be considered when such mode is
enabled. Note that the default listen mode is "https".

Also, please be aware that these modules include choice nodes that can be augmented
by other extended modules. The augmented data nodes may be considered sensitive
or vulnerable in some network environments. For instance, an augmented case of
the "source-params" choice in "data-source" may include authentication
information about how to access a data source including private network
information. The "yang-datastore" case in [](#example-data-source) is such an
example. The "restconf" and "netconf" nodes in it may reveal the access to a
private YANG datastore. Thus, those extended modules may have the NACM
extension "default-deny-all" set.

These modules use groupings defined in other RFCs that
define data nodes that do set the NACM "default-deny-all" and
"default-deny-write" extensions.

# IANA Considerations

This document registers the following URIs in the "IETF XML Registry" {{RFC3688}}:

      URI: urn:ietf:params:xml:ns:yang:ietf-alto
      Registrant Contact: The IESG.
      XML: N/A; the requested URI is an XML namespace.

      URI: urn:ietf:params:xml:ns:yang:ietf-alto-stats
      Registrant Contact: The IESG.
      XML: N/A; the requested URI is an XML namespace.

This document registers the following two YANG modules in the "YANG Module Names" registry
{{RFC6020}}:

      Name: ietf-alto
      Namespace: urn:ietf:params:xml:ns:yang:ietf-alto
      Prefix: alto
      Maintained by IANA: N
      Reference: [RFC XXXX]

      Name: ietf-alto-stats
      Namespace: urn:ietf:params:xml:ns:yang:ietf-alto-stats
      Prefix: alto-stats
      Maintained by IANA: N
      Reference: [RFC XXXX]

<!-- End of sections -->
