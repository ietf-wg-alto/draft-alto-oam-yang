# Introduction

This document defines a YANG data model for the operations and management of
Application-Layer Traffic Optimization (ALTO) Protocol. The basic propose of
this YANG data model is discussed in Section 16 of {{RFC7285}}. The operator can
use the data model to create and update ALTO information resources, manage the
access control, configure server-to-server communication and server discovery,
and collect statistical data.

The basic structure of this YANG data model is guided by Section 16 of
{{RFC7285}} and {{RFC7971}}. Although the scope of the YANG data model in this
document mainly focuses on the support of the base ALTO protocol {{RFC7285}} and
the existing ALTO standard extensions (including {{RFC8189}}, {{RFC8895}} and
{{RFC8896}}), the design will also be extensible for future standard extensions
(e.g., {{I-D.ietf-alto-path-vector}}, {{I-D.ietf-alto-unified-props-new}},
{{RFC8896}}, and {{I-D.ietf-alto-performance-metrics}}).

# Requirements Language

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD",
"SHOULD NOT", "RECOMMENDED", "NOT RECOMMENDED", "MAY", and "OPTIONAL" in this
document are to be interpreted as described in BCP 14 {{RFC2119}} {{RFC8174}}
when, and only when, they appear in all capitals, as shown here. When the words
appear in lower case, they are to be interpreted with their natural language
meanings.

<!-- End of sections -->
