# Security Considerations

## The "ietf-alto" YANG Module

The "ietf-alto" YANG module defines data nodes that are designed to be accessed
via YANG based management protocols, such as NETCONF {{RFC6241}} and RESTCONF
{{RFC8040}}. Both of these protocols have mandatory-to-implement secure
transport layers (e.g., SSH, TLS) with mutual authentication.

The Network Access Control Model (NACM) {{RFC8341}} provides the means to
restrict access for particular users to a pre-configured subset of all
available protocol operations and content.

None of the readable data nodes in this YANG module are considered sensitive or
vulnerable in network environments. The NACM "default-deny-all" extension has
not been set for any data nodes defined in this module.

None of the writable data nodes in this YANG module are considered sensitive or
vulnerable in network environments. The NACM "default-deny-write" extension has
not been set for any data nodes defined in this module.

This module does not define any RPCs, actions, or notifications, and thus the
security consideration for such is not provided here.

Please be aware that this module uses groupings defined in other RFCs that
define data nodes that do set the NACM "default-deny-all" and
"default-deny-write" extensions.

## The "ietf-alto-stats" YANG Module

The "ietf-alto-stats" YANG module defines data nodes that are designed to be
accessed via YANG based management protocols, such as NETCONF {{RFC6241}} and
RESTCONF {{RFC8040}}. Both of these protocols have mandatory-to-implement
secure transport layers (e.g., SSH, TLS) with mutual authentication.

The Network Access Control Model (NACM) {{RFC8341}} provides the means to
restrict access for particular users to a pre-configured subset of all
available protocol operations and content.

None of the readable data nodes in this YANG module are considered sensitive or
vulnerable in network environments. The NACM "default-deny-all" extension has
not been set for any data nodes defined in this module.

None of the writable data nodes in this YANG module are considered sensitive or
vulnerable in network environments. The NACM "default-deny-write" extension has
not been set for any data nodes defined in this module.

This module does not define any RPCs, actions, or notifications, and thus the
security consideration for such is not provided here.

Please be aware that this module uses groupings defined in other RFCs that
define data nodes that do set the NACM "default-deny-all" and

# IANA Considerations

This document registers two URIs in the "IETF XML Registry" {{RFC3688}}.
Following the format in RFC 3688, the following registrations are requested.

      URI: urn:ietf:params:xml:ns:yang:ietf-alto
      Registrant Contact: The IESG.
      XML: N/A; the requested URI is an XML namespace.

      URI: urn:ietf:params:xml:ns:yang:ietf-alto-stats
      Registrant Contact: The IESG.
      XML: N/A; the requested URI is an XML namespace.

This document registers two YANG modules in the "YANG Module Names" registry
{{RFC6020}}.

      Name: ietf-alto
      Namespace: urn:ietf:params:xml:ns:yang:ietf-alto
      Prefix: alto
      Reference: [RFCthis]

      Name: ietf-alto-stats
      Namespace: urn:ietf:params:xml:ns:yang:ietf-alto-stats
      Prefix: alto
      Reference: [RFCthis]

[RFC Editor: Please replace RFCthis with the published RFC number for this document.]

<!-- End of sections -->
