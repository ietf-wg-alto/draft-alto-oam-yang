# Design of ALTO OAM Data Model

## Overview of ALTO OAM Data Model

The ALTO YANG module defined in this document has all the common building blocks
for ALTO OAM.

NOTE: So far, the ALTO YANG module only focuses on the ALTO server related
configuration. The ALTO client related configuration will be added in a future
version of the document.

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
     |   +--rw resource-type  identityref
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
     |      |     +--rw testable-cost-type-names*
     |      |             string {multi-cost}?
     |      |     +--rw calendar?          boolean {cost-calendar}?
     |      |     +--rw (algorithm)
     |      +--:(endpointcost)
     |      |  +--rw alto-endpointcost-params
     |      |     +--rw cost-type* [cost-mode,cost-metric]
     |      |     |  +--rw cost-mode       cost-mode
     |      |     |  +--rw cost-metric     cost-metric
     |      |     +--rw cost-constraints?  boolean
     |      |     +--rw max-cost-types?    uint32 {multi-cost}?
     |      |     +--rw testable-cost-type-names*
     |      |             string {multi-cost}?
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
        +--rw source-type identityref
        +--rw (update-policy)
        |  +--:(reactive)
        |  |  +--rw reactive         boolean
        |  +--:(proactive)
        |     +--rw poll-interval    uint32
        +--rw (source-params)
           +--:(internal)
           |  +--rw internal-source-params
           |     +--rw source-path   yang:xpath1.0
           +--:(external)
              +--rw external-source-params
                 +--rw source-uri    inet:uri
                 +--rw query-data?   string
~~~

## Meta Information of ALTO Server

The ALTO server instance contains the following basic configurations for the
server setup. 

The hostname is the name that is used to access the ALTO server. It will be also
used in the URI of each information resource provided by the ALTO server.

The cost type list is the registry for the cost types that can be used in the
ALTO server.

The `meta` list contains the customized meta data of the ALTO server. It will be
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

The ALTO server instance contains a list of `resource` entries. Each `resource`
entry contains the configurations of an ALTO information resource (See Section
8.1 of {{RFC7285}}). The operator of the ALTO server can use this model to
create, update, and remove the ALTO information resource.

Each `resoruce` entry is considered as an intent to create or update an ALTO
information resource.  Adding a new `resource` entry will submit an ALTO
information resource creation intent to the intent system to create a new ALTO
information resource. Updating an existing `resource` entry will update the
corresponding ALTO information resource creation intent. Removing an existing
`resource` entry will remove the corresponding ALTO information resource
creation intent and also the created ALTO information resource.

The parameter of the intent interface defined by a `resource` entry MUST include
a unique `resource-id` and a `resource-type`.

It can also include an `accepted-group` node containing a list of `user-group`s
that can access this ALTO information resource.

For some `resource-type`, the parameter of the intent interface MUST also
include the a `dependency` node containing the `resource-id` of the dependent
ALTO information resources (See Section 9.1.5 of {{RFC7285}}).

For each type of ALTO information resource, the creation intent MAY also need
type-specific parameters. These type-specific parameters include two categories:

1. One categories of the type-specific parameters are common for the same type
   of ALTO information resource. They declare the Capabilities of the ALTO
   information resource (See Section 9.1.3 of {{RFC7285}}).
2. The other categories of the type-specific parameters are algorithm-specific.
   The developer of the ALTO server can implement their own creation altorithms
   and augment the `algorithm` node to declare algorithm-specific input
   parameters.

Except for the `ird` resource, all the other types of `resource` entries have
augmented `algorithm` node. The augmented `algorithm` node can reference data
sources subscribed by the `data-source` entries (See [](#data-source)).

The developer cannot customize the creation algorithm of the `ird` resource. The
default `ird` resource will be created automatically based on all the added
`resource` entries. The delegated `ird` resource will be created as a static
ALTO information resource (See Section 9.2.4 of {{RFC7285}}).

~~~
module: ietf-alto
  +--rw alto-server
     ...
     +--rw resource* [resource-id]
     |   +--rw resource-id    resource-id
     |   +--rw resource-type  identityref
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
     |      |     +--rw testable-cost-type-names*
     |      |             string {multi-cost}?
     |      |     +--rw calendar?          boolean {cost-calendar}?
     |      |     +--rw (algorithm)
     |      +--:(endpointcost)
     |      |  +--rw alto-endpointcost-params
     |      |     +--rw cost-type* [cost-mode,cost-metric]
     |      |     |  +--rw cost-mode       cost-mode
     |      |     |  +--rw cost-metric     cost-metric
     |      |     +--rw cost-constraints?  boolean
     |      |     +--rw max-cost-types?    uint32 {multi-cost}?
     |      |     +--rw testable-cost-type-names*
     |      |             string {multi-cost}?
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

### Information Resource Creation Algorithm Example

The following example shows how the developer can augment a creation algorithm
for the network map resource.

~~~
  augment /alto:alto-server/alto:resource/alto:resource-params
            /alto:networkmap/alto:alto-networkmap-params
            /alto:algorithm:
    +--rw l3-unicast-cluster-algorithm
       +--rw l3-unicast-topo
       |       -> /alto:alto-server/data-source/source-id
       +--rw depth?    uint32
~~~

This example defines a creation algorithm called `l3-unicast-cluster-algorithm`
for the network map resource. It takes two algorithm-specific parameters:

l3-unicast-topo
: This parameter refers to the source id of a data source node subscribed in the
  `data-source` list (See [](#data-source)). The corresponding data source is
  assumed to be an internel data source (See [](#internal-data-source)) for an
  IETF layer 3 unicast topology defined in {{RFC8346}}. The algorithm uses the
  topology data from this data source to compute the ALTO network map resource.

depth
: This optional parameter sets the depth of the clustering algorithm. For
  example, if the depth sets to 1, the algorithm will generate PID for every
  l3-node in the topology.

The creation algorithm can be reactively called once the referenced data source
updates. Therefore, the ALTO network map resource can be updated dynamically.
The update of the reference data source depends on the used `update-policy` (See
[](#data-source)).

## Data Sources {#data-source}

The ALTO server instance contains a list of `data-source` entries to subscribe
the data sources from which ALTO information resources are derived (See Section
16.2.4 of {{RFC7285}}).

A `data-source` entry MUST include:

- a unique `source-id` for resource creation algorithms to reference,
- the `source-type` attribute to declare the type of the data source,
- the `update-policy` to specify how to get the data update from the data
  source,
- the `source-params` to specify where and how to query the data.

The update policy can be either reactive or proactive. For the reactive update,
the ALTO server gets the update as soon as the data source changes. For the
proactive update, the ALTO server has to proactively fetch the data source
periodically.

To use the reactive update, the `reactive` attribute MUST be set true. To use
the proactive update, the `poll-interval` attribute MUST be greater than zero.
The value of `poll-interval` specifies the interval of fetching the data in
milliseconds. If `reactive` is false or `poll-interval` is zero, the ALTO server
will not update the data source.

The target of the data source can be either internal or external.

~~~
module: ietf-alto
  +--rw alto-server
     ...
     +--rw data-source* [source-id]
        +--rw source-id   string
        +--rw source-type identityref
        +--rw (update-policy)
        |  +--:(reactive)
        |  |  +--rw reactive         boolean
        |  +--:(proactive)
        |     +--rw poll-interval    uint32
        +--rw (source-params)
           +--:(internal)
           |  +--rw internal-source-params
           |     +--rw source-path   yang:xpath1.0
           +--:(external)
              +--rw external-source-params
                 +--rw source-uri    inet:uri
                 +--rw query-data?   string
~~~

### Internal Data Source {#internal-data-source}

The `internal-source-params` is used to subscribe the internel data source which
is located in the same YANG model-driven data store supplying the current ALTO
OAM data model. The `source-path` is used to specify the XPath of the data
source node.

### External Data Source {#external-data-source}

The `external-source-params` is sued to subscribe the external data source which
is located in other database systems, e.g., an SNMP server, a prometheus
monitor, or a SQL database. The `source-uir` is used to establish the connection
with the external data source. The `query-data` is used to speficify the
potential query expression.

## Model for ALTO Server-to-server Communication

TBD.

## Model for ALTO Statistics

TBD.

<!-- End of sections -->