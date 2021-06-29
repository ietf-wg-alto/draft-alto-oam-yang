# Design of ALTO OAM Data Model

## Overview of ALTO OAM Data Model

The ALTO YANG module defined in this document has all the common building blocks
for ALTO OAM.

The container "alto-server" in the ALTO yang module contains all the configured
and operational parameters of the adminstrated ALTO server instance.

~~~
module: ietf-alto
  +--rw alto-server
     +--rw hostname  inet:host
     +--rw cost-type* [cost-type-name]
     |   +--rw cost-type-name string
     |   +--rw cost-mode      cost-mode
     |   +--rw cost-metric    cost-metric
     |--rw meta* [meta-key]
     |   +--rw meta-key       string
     |   +--rw meta-value     string
     +--rw resource* [resource-id]
     |   +--rw resource-id    resource-id
     |   +--rw resource-type  service-type
     |   +--rw description?   string
     |   +--rw accepted-group* [user-group]
     |   +--rw dependency*    resource-id
     |   |  ...
     |   +--rw (resource-params)
     |      +--:(ird)
     |      |  +--rw alto-ird-params
     |      |     +--rw delegation         inet:uri
     |      +--:(networkmap)
     |      |  +--rw alto-networkmap-params
     |      |     +--rw is-default?        boolean
     |      |     +--rw filtered?          boolean
     |      |     +--rw (algorithm)
     |      +--:(costmap)
     |      |  +--rw alto-costmap-params
     |      |     +--rw filtered?          boolean
     |      |     +--rw cost-type-names*   string
     |      |     +--rw cost-constraints?  boolean
     |      |     +--rw max-cost-types?    uint32 {multi-cost}?
     |      |     +--rw testable-cost-type-names* string {multi-cost}?
     |      |     +--rw calendar?          boolean {cost-calendar}?
     |      |     +--rw (algorithm)
     |      +--:(endpointcost)
     |      |  +--rw alto-endpointcost-params
     |      |     +--rw cost-type* [cost-mode,cost-metric]
     |      |     |  +--rw cost-mode       cost-mode
     |      |     |  +--rw cost-metric     cost-metric
     |      |     +--rw cost-constraints?  boolean
     |      |     +--rw max-cost-types?    uint32 {multi-cost}?
     |      |     +--rw testable-cost-type-names* string {multi-cost}?
     |      |     +--rw calendar?          boolean {cost-calendar}?
     |      |     +--rw (algorithm)
     |      +--:(endpointprop)
     |      |  +--rw alto-endpointprop-params
     |      |     +--rw (algorithm)
     |      +--:(propmap) {propmap}?
     |      |  +--rw alto-propmap-params
     |      |     +--rw (algorithm)
     |      +--:(cdni) {cdni}?
     |      |  +--rw alto-cdni-params
     |      |     +--rw (algorithm)
     |      +--:(update) {incr-update}?
     |         +--rw alto-update-params
     |            +--rw (algorithm)
     +--rw data-source* [source-id]
        +--rw source-id   string
        +--rw source-type source-type
        +--rw (source-params)
           +--:(internal)
           |  +--rw internal-source-params
           |     +--rw source-path   yang:xpath1.0
           +--:(external)
           |  +--rw external-source-params
           |     +--rw source-uri    inet:uri
           |     +--rw query-data    string
           +--:(reactive)
              +--rw reactive-source-params
                 +--rw reactive-source-uri  inet:uri
~~~

## Meta Information of ALTO Server

The ALTO server instance contains the following basic configurations for the
server setup. 

The hostname is the name that is used to access the ALTO server. It will be also
used in the URI of each information resource provided by the ALTO server.

The cost type list is the registry for the cost types that can be used in the
ALTO server.

The meta list contains the customized meta data of the ALTO server. It will be
populated into the meta field of the default Information Resource Directory
(IRD).

~~~
module: ietf-alto
  +--rw alto-server
     +--rw hostname  inet:host
     +--rw cost-type* [cost-type-name]
     |   +--rw cost-type-name string
     |   +--rw cost-mode      cost-mode
     |   +--rw cost-metric    cost-metric
     |--rw meta* [meta-key]
     |   +--rw meta-key       string
     |   +--rw meta-value     string
     ...
~~~

## Intent-based Interfaces for ALTO Information Resources Management

The operator of the ALTO server can use this YANG data model to create, update,
and remove the ALTO information resource.

~~~
module: ietf-alto
  +--rw alto-server
     ...
     +--rw resource* [resource-id]
     |   +--rw resource-id    resource-id
     |   +--rw resource-type  service-type
     |   +--rw description?   string
     |   +--rw accepted-group* [user-group]
     |   +--rw dependency*    resource-id
     |   |  ...
     |   +--rw (resource-params)
     |      +--:(ird)
     |      |  +--rw alto-ird-params
     |      |     +--rw delegation         inet:uri
     |      +--:(networkmap)
     |      |  +--rw alto-networkmap-params
     |      |     +--rw is-default?        boolean
     |      |     +--rw filtered?          boolean
     |      |     +--rw (algorithm)
     |      +--:(costmap)
     |      |  +--rw alto-costmap-params
     |      |     +--rw filtered?          boolean
     |      |     +--rw cost-type-names*   string
     |      |     +--rw cost-constraints?  boolean
     |      |     +--rw max-cost-types?    uint32 {multi-cost}?
     |      |     +--rw testable-cost-type-names* string {multi-cost}?
     |      |     +--rw calendar?          boolean {cost-calendar}?
     |      |     +--rw (algorithm)
     |      +--:(endpointcost)
     |      |  +--rw alto-endpointcost-params
     |      |     +--rw cost-type* [cost-mode,cost-metric]
     |      |     |  +--rw cost-mode       cost-mode
     |      |     |  +--rw cost-metric     cost-metric
     |      |     +--rw cost-constraints?  boolean
     |      |     +--rw max-cost-types?    uint32 {multi-cost}?
     |      |     +--rw testable-cost-type-names* string {multi-cost}?
     |      |     +--rw calendar?          boolean {cost-calendar}?
     |      |     +--rw (algorithm)
     |      +--:(endpointprop)
     |      |  +--rw alto-endpointprop-params
     |      |     +--rw (algorithm)
     |      +--:(propmap) {propmap}?
     |      |  +--rw alto-propmap-params
     |      |     +--rw (algorithm)
     |      +--:(cdni) {cdni}?
     |      |  +--rw alto-cdni-params
     |      |     +--rw (algorithm)
     |      +--:(update) {incr-update}?
     |         +--rw alto-update-params
     |            +--rw (algorithm)
     ...
~~~

## Data Sources Subscription

TBD.

<!-- End of sections -->