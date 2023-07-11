# Introduction

This document defines a YANG data model for the Operations, Administration, and
Maintenance (OAM) & Management of Application-Layer Traffic Optimization (ALTO)
Protocol. The basic purpose of this YANG data model is discussed in Section 16
of {{RFC7285}}.

The operator of an ALTO server can use this data model to:

* set up the ALTO server,
* configure server discovery,
* create, update and remove ALTO information resources,
* manage the access control of each ALTO information resource,
* collect statistical data of the ALTO server.

The application provider can also use this data model to configure ALTO clients
to communicate with known ALTO servers.

[](#scope) describes what is and is not in scope.
[](#requirements) and [](#extra-req) define more concrete requirements for the
data model.

The basic structure of this YANG data model is guided by Section 16 of
{{RFC7285}} and {{RFC7971}}. Although the scope of the YANG data model in this
document mainly focuses on the support of the base ALTO protocol {{RFC7285}} and
the existing ALTO standard extensions: {{RFC8189}}, {{RFC8895}},
{{RFC8896}}, {{RFC9240}}, {{RFC9241}}, {{RFC9275}}, and
{{I-D.ietf-alto-performance-metrics}}.

The detailed design of the data model is illustrated in [](#alto-model) and
[](#alto-stats-model). Some examples of how to extend this data model for
specific ALTO server implementations are shown in [](#alto-ext-model).

# Requirements Language

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD",
"SHOULD NOT", "RECOMMENDED", "NOT RECOMMENDED", "MAY", and "OPTIONAL" in this
document are to be interpreted as described in BCP 14 {{RFC2119}} {{RFC8174}}
when, and only when, they appear in all capitals, as shown here. When the words
appear in lower case, they are to be interpreted with their natural language
meanings.

<!-- End of sections -->
