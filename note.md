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


======

1. I agree management consideration provide a set of requirements for ALTO data
model design and is a good input to this document. I am wondering whether we
have other reference work as input such as server discovery, server to server
communication, I assume ALTO deployment document can be one of them, related to
sever to server communication, what about server discovery? Do we need to
configure the ALTO client for server discovery?  Do we need to configure ALTO
server for server discovery, suppose we use DNS mechanism to discover ALTO
server, I think we actually need to configure DNS server? What am I missing? I
encourage to take a close look at server discovery aspect, what is needed for
ALTO data model?

2. I agree we need to better manage ALTO information resource and data source,
Do we need to monitor ALTO information resource lifecycle management, what is
missing part is performance measurement aspect, I think we should reference
section 16.2.5 to see how to provide ALTO information resource monitoring?  Also
consider how to integrate generic measurement framework into this data model,
one relevant work is draft-xie-alto-lmap-00?

3. For data source aspect, I am wondering whether we should also consider not
only where to collect data, but also how to collect data or what kind of data we
can collect?  e.g., we can use pub sub mechanism to collect the data, suppose we
collect the routing data, topology data, performance related data, how these
data are translated into network map or cost map? I know we support reactive
update and proactive update, but it looks both are poll based which is slow.

4. For Access Control, I feel it is confusing, I don't think access control is
about a list of permissions associated with a system resource (object),e.g, data
flow with the specific 5 tuples, I think access control is related to security
policy such as HTTP authentication, TLS client and server authentication, TLS
encryption parameters, this can be used not only in client server communication
but also in server to server communication. I am wondering how this can be
modelled in the ALTO data model?