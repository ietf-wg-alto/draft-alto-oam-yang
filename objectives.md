# Design Scope and Requirements {#sec-req}

## Scope of Data Model for ALTO O&M

What is in the scope of this document?

- Data model for deploy an ALTO server/client.
- Data model for operate and manage a running ALTO server/client.
- Data model for functionality/capability configuration for ALTO services.
- Data model for monitoring ALTO-related performance metrics.

What is not in the scope of this document?

This document does not define any data model related to specific
implementation, including:

- Data structures for how to store/deliver ALTO information resources (e.g.,
  database schema to store a network map).
- Data structures for how to store information collected from data sources.
  (e.g., database schema to store topology collected from an Interface to the
  Routing System (I2RS) client {{RFC7921}})

## Basic Requirements {#requirements}

Based on discussions and recommendations in {{RFC7285}} and {{RFC7971}}, the
data model provided by this document satisfies basic requirements listed in
[](#TableReq).

| Requirement                                                                                         | Reference                                                 |
| --------------------------------------------------------------------------                          | --------------------------------------------------------- |
| R1: The data model should support configuration for ALTO server setup.                              | Section 16.1 of {{RFC7285}}                               |
| R2: The data model should provide logging management.                                               | Section 16.2.1 of {{RFC7285}}                             |
| R3: The data model should provide ALTO-related management information.                              | Section 16.2.2 of {{RFC7285}}                             |
| R4: The data model should support configuration for security policy management.                     | Section 16.2.6 of {{RFC7285}}                             |
| R5-1: The data model should support configuration for different data sources.                       | Section 16.2.4 of {{RFC7285}}, Section 3.2 of {{RFC7971}} |
| R5-2: The data model should support configuration for information resource generation algorithms.   | Section 16.2.4 of {{RFC7285}}                             |
| R5-3: The data model should support configuration for access control at information resource level. | Section 16.2.4 of {{RFC7285}}                             |
| R6: The data model should provide metrics for server failures.                                      | Section 16.2.3 of {{RFC7285}}, Section 3.3 of {{RFC7971}} |
| R7: The data model should provide performance monitoring for ALTO-specific metrics.                 | Section 16.2.5 of {{RFC7285}}, Section 3.4 of {{RFC7971}} |
{: #TableReq title="Basic Requirements of Data Model for ALTO O&M."}

## Additional Requirements for Extensibility

R8: As the ALTO protocol is extensible, the data model for ALTO O&M should
allow for augmentation to support potential future extensions.

<!--
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
-->


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

<!--
NOTE: The data model supporting configuration for the ALTO client and the
communication between the administrated ALTO server and other ALTO servers will
be considered in a future version of the document.
-->

## Overview of ALTO O&M Data Model for Reference ALTO Architecture

[](#alto-ref-arch) shows a reference architecture for ALTO server
implementation and YANG modules that server components implement. The server
manager, information resource manager and data source listeners need to
implement `ietf-alto.yang` (see [](#alto-model)). The performance monitor and
logging and fault manager need to implement `ietf-alto-stats.yang` (see
[](#alto-stats-model)).

The data broker and algorithm plugins are not in the scope of the data model
defined in this document. But user specified YANG modules can be applied to
different algorithm plugins by augmenting the data model defined in this
document (see [](#alto-ext-model)).

~~~
  +----------------------+      +-----------------+
  | Performance Monitor: |<-----| Server Manager: |
  | ietf-alto-stats.yang |<-+ +-| ietf-alto.yang  |
  +----------------------+  | | +-----------------+
                          report
  +----------------------+  | | +-------------------+
  | Logging and Fault    |  +---| Information       |
  | Manager:             |<---+ | Resource Manager: |
  | ietf-alto-stats.yang |<-----| ietf-alto.yang    |
  +----------------------+      +-------------------+
                                         ^|
                                         || callback
                                         |v
     .............          ..............................
    /             \ ------> . Algorithm Plugin:          .
    . Data Broker .  read   . example-ietf-alto-alg.yang .
    ...............         ..............................
           ^
           | write
  +----------------+  Southbound  ++=============++
  | Data Source    |     API      ||             ||
  | Listener:      | <==========> || Data Source ||
  | ietf-alto.yang |              ||             ||
  +----------------+              ++=============++
~~~
{: #alto-ref-arch title="A Reference ALTO Server Architecture and YANG Modules"}

<!-- End of sections -->
