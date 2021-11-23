# Basic Requirements and Objectives

Based on discussions and recommendations in {{RFC7285}} and {{RFC7971}}, the
data model provided by this document satisfies basic requirements listed in [](#TableReq)

| Requirement                                                            | Reference                     |
| ---------------------------------------------------------------------- | ----------------------------- |
| Support configuration for ALTO server setup                            | Section 16.1 of {{RFC7285}}   |
| Define management information model                                    | Section 16.2.2 of {{RFC7285}} |
| Support configuration for data sources                                 | Section 16.2.4 of {{RFC7285}} |
| Support configuration for information resource generation algorithms   | Section 16.2.4 of {{RFC7285}} |
| Support configuration for access control at information resource level | Section 16.2.4 of {{RFC7285}} |
| Support performance monitoring for ALTO-specific metrics               | Section 16.2.5 of {{RFC7285}} |
| Support configuration for security policy management                   | Section 16.2.6 of {{RFC7285}} |
{: #TableReq title="Basic Requirements of Data Model for ALTO OAM."}

## Scope of Data Model for ALTO OAM

What is in the scope of this document?

- Data model for ALTO client/server operation and management.
- Data model for functionality/capability configuration for ALTO services.
- Data model for performance monitoring for operation purpose.

What is not in the scope of this document?

This document does not define any data model related to specific
implementation, including:

- Data structures for how to store/deliver ALTO information resources (e.g.,
  network map, cost map, property map).
- Specific algorithms for ALTO information resource generation.
- Data structures for how to store information collected from data sources.

## Objectives

To satisfy all the basic requirements and consider the potential requirements
for future extensions, this document focuses on the design objectives for the
YANG data model as follows:

- The data model should support configuration for ALTO server setup (e.g.,
  caching policy at information resource level, metadata for server discovery).
- The data model should provide configurable data model for administrators to
  create, update and remove ALTO information resources.
    - The data model should support different types of data source
      provisioning.
    - The data model should allow developers to augment new APIs for ALTO
      information resource generation algorithms.
    - The data model should be extensible for new ALTO information resources.
- The data model should collect statistics information of the
  requests/responses for each ALTO information resource.
- The data model should support security policy configuration at the
  information resource level.


<!--
- The data model should provide intent-based interfaces for administrators to
  create, update and remove ALTO information resources.
  - The data model should be extensible for new ALTO information resources.
  - The data model should allow developers to augment new APIs for ALTO
    information resource generation.
- The data model should support configuration for ALTO server discovery.
- The data model should support access control at the information resource level.
- The data model should collect statistics information of the requests to each
  ALTO information resource.
-->

NOTE: The data model supporting configuration for the ALTO client and the
communication between the administrated ALTO server and other ALTO servers will
be considered in a future version of the document.

<!-- End of sections -->
