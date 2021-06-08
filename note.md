1. deployable (for ALTO WG rechartering)
2. novelty (for research)

scalable routing collection

information from multiple peer sessions

information redundancy

information inconsistency

example

# Introduction

Application-Layer Traffic Optimization (ALTO) {{RFC7285}} protocol relies on
the service framework provided by the ALTO server. However, operating an ALTO
server can be complex. In practice, the operations of an ALTO server may
include decisions on the set of information resources (e.g., what metrics,
how they are divided into multiple entries) exposed in the information
resource directory (IRD), population (may be proactive and reactive) of the
content of the services (e.g., pull the backend, or trigger just-in-time
measurements), and aggregation/processing of the collected information to
give clients the proper response.

Manual operations are inefficient and may lead to inconsistency. Thus, the
automation of the operations of the ALTO services can be highly valuable.

This document will investigate the best
practices in ALTO operations automation, including
interop/interfaces/protocols with routing systems and measurement tools.


=======



operation complexity

ALTO resource computation depends on lots of network telemetry



useful telemetry depends on the network state and application demands

network state change
application demand change

```
+--rw resource-id    alto-types:resource-id
+--rw resource-type  alto-types:service-type
+--rw description?   string
+--rw resource-params* [sub-resource-id]
|  +--rw sub-resource-id   alto-types:resource-id
|  +--rw dependency*       alto-types:resource-id
|  +--rw (sub-resource-params)
|     +--:(networkmap)
|     |  +--rw alto-networkmap-params
|     +--:(costmap)
|     |  +--rw alto-costmap-params
|     |     +--rw cost-type* [cost-mode,cost-metric]
|     |     |  +--rw cost-mode       alto-types:cost-mode
|     |     |  +--rw cost-metric     alto-types:cost-metric
|     |     +--rw test-constraints?  boolean
|     +--:(endpointcost)
|     |  +--rw alto-endpointcost-params
|     +--:(endpointprop)
|     |  +--rw alto-endpointprop-params
|     +--:(propmap)
|     |  +--rw alto-propmap-params
|     +--:(cdni)
|     |  +--rw alto-cdni-params
|     +--:(update)
|        +--rw alto-update-params
+--rw data-source* [source-id]
|  +--rw source-id   uuid
|  +--rw source-type alto-types:source-type
|  +--rw (source-params)
|     +--:(internal)
|     |  +--rw internal-source-params
|     +--:(external)
|     |  +--rw external-source-params
|     |     +--rw source-uri  uri
|     +--:(reactive)
|        +--rw reactive-source-params
|           +--rw reactive-source-uri  uri
+--rw (algorithm)
```