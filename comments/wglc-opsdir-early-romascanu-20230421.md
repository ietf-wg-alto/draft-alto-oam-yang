Ready with Nits

This document defines YANG data models for Operations, Administration, and
Maintenance (OAM) & Management of ALTO. The operator can use these data models
to set up an ALTO server, create, update and remove ALTO information resources,
manage the access control, configure server discovery, and collect statistical
data.

I like this document. It is clearly written and very well structured. I liked
the description of requirements, the information model corresponding to the
requirements, and the extension example modules in the Appendices. These are
all very useful for operators who need to understand and use the YANG modules.

Understanding and using this document requires a good knowledge of ALTO.

My review is focused on the design and data modelling issues relevant for
operations and manageability. I did not perform a YANG review, I assume that
YANG Doctors review is performed separately.

This document is Ready with a couple of editorial comments.

Editorial & Nits:

1. There are many more acronyms not included in Section 3 or expanded at first
occurrence. Maybe the respective acronyms sections in the ALTO documents should
be mentioned / referred

2. In Section 5.3.1.2

> In practice, multiple ALTO servers can be deployed for scalability.
   That may require communication among different ALTO servers.

   The "ietf-alto" module does not contain any configuration for the
   communication between peer ALTO servers.  Instead, it provides the
   configuration for how an ALTO server can be discovered by another
   ALTO server on demand (Figure 6).

I understand that the communication between ALTO servers is out of scope.
However, I do not understand how is the scalability requirement met. Is there /
Will there be another YANG module to define this data model? Something else
than YANG? Maybe this is described in another ALTO document that I did not find.
