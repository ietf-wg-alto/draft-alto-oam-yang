# Design of ALTO O&M Data Model {#alto-model}

## Overview of ALTO O&M Data Model

The ietf-alto module defined in this document provide all the basic ALTO O&M
data models fitting the requirements listed in [](#sec-req).

The container "alto-server" in the ietf-alto module contains all the configured
and operational parameters of the adminstrated ALTO server instance.

NOTE: So far, the ALTO YANG module only focuses on the ALTO server related
configuration. The ALTO client related configuration will be added in a future
version of the document.

~~~
module: ietf-alto
  +--rw alto-server
     +--rw scope
     |  +--rw static*    inet:ip-prefix
     |  +--rw dynamic*   -> /alto-server/data-source/source-id
     +--rw listen
     |  +---u alto-server-listen-stack-grouping
     +--rw cost-type* [cost-type-name]
     |  +--rw cost-type-name    string
     |  +--rw cost-mode         identityref
     |  +--rw cost-metric       identityref
     +--rw meta* [meta-key]
     |  +--rw meta-key      string
     |  +--rw meta-value    string
     +--rw resource* [resource-id]
     |  +--rw resource-id                       resource-id
     |  +--rw resource-type                     identityref
     |  +--rw description?                      string
     |  +--rw accepted-group*                   string
     |  +--rw dependency*
     |  |       -> /alto-server/resource/resource-id
     |  +--rw auth
     |  |  +--rw (auth-type-selection)?
     |  |     +--:(auth-key-chain)
     |  |     |  +--rw key-chain?   key-chain:key-chain-ref
     |  |     +--:(auth-key)
     |  |     +--:(auth-tls)
     |  +--rw (resource-params)?
     |     +--:(ird)
     |     |  +--rw alto-ird-params
     |     |     +--rw delegation    inet:uri
     |     +--:(networkmap)
     |     |  +--rw alto-networkmap-params
     |     |     +--rw is-default?   boolean
     |     |     +--rw filtered?     boolean
     |     |     +---u algorithm
     |     +--:(costmap)
     |     |  +--rw alto-costmap-params
     |     |     +--rw filtered?           boolean
     |     |     +---u filt-costmap-cap
     |     |     +---u algorithm
     |     +--:(endpointcost)
     |     |  +--rw alto-endpointcost-params
     |     |     +---u filt-costmap-cap
     |     |     +---u algorithm
     |     +--:(endpointprop)
     |     |  +--rw alto-endpointprop-params
     |     |     +--rw prop-types*   string
     |     |     +---u algorithm
     |     +--:(propmap) {propmap}?
     |     |  +--rw alto-propmap-params
     |     |     +---u algorithm
     |     +--:(cdni) {cdni}?
     |     |  +--rw alto-cdni-params
     |     |     +---u algorithm
     |     +--:(update) {incr-update}?
     |        +--rw alto-update-params
     |           +---u algorithm
     +--rw data-source* [source-id]
        +--rw source-id                             string
        +--rw source-type                           identityref
        +--rw (update-policy)
        |  +--:(reactive)
        |  |  +--rw reactive                        boolean
        |  +--:(proactive)
        |     +--rw poll-interval                   uint32
        +--rw (source-params)?
           +--:(yang-datastore)
           |  +--rw yang-datastore-source-params
           |     +--rw source-path
           |     |       yang:xpath1.0
           |     +--rw (restconf-endpoint)?
           |        +--:(local)
           |        +--:(remote)
           |           +--rw restconf-endpoint-params
           |              +---u rcc:restconf-client-listen-stack-grouping
           +--:(prometheus)
              +--rw prometheus-source-params
                 +--rw source-uri    inet:uri
                 +--rw query-data?   string
~~~

## Meta Information of ALTO Server

The ALTO server instance contains the following basic configurations for the
server setup.

The "listen" contains all the configurations for the whole server listen stack
across HTTP layer, TLS layer and TCP layer.

~~~
  grouping alto-server-listen-stack-grouping
    +-- (transport)
       +--:(http) {http-listen}?
       |  +-- http
       |     +-- tcp-server-parameters
       |     |  +---u tcp:tcp-server-grouping
       |     +-- http-server-parameters
       |     |  +---u http:http-server-grouping
       |     +-- alto-server-parameters
       +--:(https)
          +-- https
             +-- tcp-server-parameters
                +---u tcp:tcp-server-grouping
                +-- tls-server-parameters
                |  +---u tls:tls-server-grouping
                +-- http-server-parameters
                |  +---u http:http-server-grouping
                +-- alto-server-parameters
~~~

TODO: A "base-uri" for ALTO clients to access may still be needed.

The "scope" container is used to configure endpoints in the scope of the
network domain serving this ALTO server. It contains two leaf lists. The
"static" list contains a list of manual configured endpoints. The "dynamic"
list points to a list of data sources to retrieve the endpoints dynamically. As
suggested by {{RFC7286}} and {{RFC8686}}, the IP prefixes in the scope will be
translated into DNS NAPTR resource records for server discovery.

The "cost-type" list is the registry for the cost types that can be used in the
ALTO server.

The "meta" list contains the customized meta data of the ALTO server. It will be
populated into the meta field of the default Information Resource Directory
(IRD).

~~~
module: ietf-alto
  +--rw alto-server
     +--rw scope
     |  +--rw static*    inet:ip-prefix
     |  +--rw dynamic*   -> /alto-server/data-source/source-id
     +--rw listen
     |  +---u alto-server-listen-stack-grouping
     +--rw cost-type* [cost-type-name]
     |  +--rw cost-type-name    string
     |  +--rw cost-mode         identityref
     |  +--rw cost-metric       identityref
     +--rw meta* [meta-key]
     |  +--rw meta-key      string
     |  +--rw meta-value    string
     ...
~~~

## ALTO Information Resources Configuration Management

The ALTO server instance contains a list of `resource` entries. Each `resource`
entry contains the configurations of an ALTO information resource (See Section
8.1 of {{RFC7285}}). The operator of the ALTO server can use this model to
create, update, and remove the ALTO information resource.

Each `resoruce` entry provide configuration defining how to create or update an ALTO
information resource. Adding a new `resource` entry will submit an ALTO
information resource creation intent to the intent system to create a new ALTO
information resource. Updating an existing `resource` entry will update the
corresponding ALTO information resource creation intent. Removing an existing
`resource` entry will remove the corresponding ALTO information resource
creation intent and also the created ALTO information resource.

The parameter of the intent interface defined by a `resource` entry MUST include
a unique `resource-id` and a `resource-type`.

It can also include an `accepted-group` node containing a list of `user-group`s
that can access this ALTO information resource.

As section 15.5.2 of {{RFC7285}} suggests, the module also defines
authentication related configuration to employ access control at information
resource level. The ALTO server returns the IRD to the ALTO client based on its
authentication information.

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
     |  +--rw resource-id                       resource-id
     |  +--rw resource-type                     identityref
     |  +--rw description?                      string
     |  +--rw accepted-group*                   string
     |  +--rw dependency*
     |  |       -> /alto-server/resource/resource-id
     |  +--rw auth
     |  |  +--rw (auth-type-selection)?
     |  |     +--:(auth-key-chain)
     |  |     |  +--rw key-chain?   key-chain:key-chain-ref
     |  |     +--:(auth-key)
     |  |     +--:(auth-tls)
     |  +--rw (resource-params)?
     |     +--:(ird)
     |     |  +--rw alto-ird-params
     |     |     +--rw delegation    inet:uri
     |     +--:(networkmap)
     |     |  +--rw alto-networkmap-params
     |     |     +--rw is-default?   boolean
     |     |     +--rw filtered?     boolean
     |     |     +---u algorithm
     |     +--:(costmap)
     |     |  +--rw alto-costmap-params
     |     |     +--rw filtered?           boolean
     |     |     +---u filt-costmap-cap
     |     |     +---u algorithm
     |     +--:(endpointcost)
     |     |  +--rw alto-endpointcost-params
     |     |     +---u filt-costmap-cap
     |     |     +---u algorithm
     |     +--:(endpointprop)
     |     |  +--rw alto-endpointprop-params
     |     |     +--rw prop-types*   string
     |     |     +---u algorithm
     |     +--:(propmap) {propmap}?
     |     |  +--rw alto-propmap-params
     |     |     +---u algorithm
     |     +--:(cdni) {cdni}?
     |     |  +--rw alto-cdni-params
     |     |     +---u algorithm
     |     +--:(update) {incr-update}?
     |        +--rw alto-update-params
     |           +---u algorithm
     ...

  grouping filt-costmap-cap
    +-- cost-type-names*            string
    +-- cost-constraints?           boolean
    +-- max-cost-types?             uint32 {multi-cost}?
    +-- testable-cost-type-names*   string {multi-cost}?
    +-- calendar-attributes {cost-calendar}?
       +-- cost-type-names*       string
       +-- time-interval-size     decimal64
       +-- number-of-intervals    uint32
~~~

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

The `data-source/source-params` node can be augmented for different types of
data sources. This data model only includes import interfaces for a list of
predefined data sources. More data sources can be supported by future documents
and other third-party providers.

~~~
module: ietf-alto
  +--rw alto-server
     ...
     +--rw data-source* [source-id]
        +--rw source-id                             string
        +--rw source-type                           identityref
        +--rw (update-policy)
        |  +--:(reactive)
        |  |  +--rw reactive                        boolean
        |  +--:(proactive)
        |     +--rw poll-interval                   uint32
        +--rw (source-params)?
           +--:(yang-datastore)
           |  +--rw yang-datastore-source-params
           |     +--rw source-path
           |     |       yang:xpath1.0
           |     +--rw (restconf-endpoint)?
           |        +--:(local)
           |        +--:(remote)
           |           +--rw restconf-endpoint-params
           |              +---u rcc:restconf-client-listen-stack-grouping
           +--:(prometheus)
              +--rw prometheus-source-params
                 +--rw source-uri    inet:uri
                 +--rw query-data?   string
~~~

Note: Current source configuration still has limitations. It should be
revised to support more general southbound and data retrieval mechanisms.

### Yang DataStore Data Source {#internal-data-source}

The `yang-datastore-source-params` is used to import the YANG data from a YANG model-driven data store.

It supports two types of endpoints: local and remote.

- For a local endpoint, the YANG data is located the data from the same
  YANG model-driven data store supplying the current ALTO O&M data model.
  Therefore, the ALTO data source listener retrieves the data using the
  internal API provided by the data store.
- For a remote endpoint, the ALTO data source listener establishes an HTTP
  connection to the remote RESTCONF server, and retrieve the data using the
  RESTCONF API.

The `source-path` is used to specify the XPath of the data
source node.

### Prometheus Data Source {#external-data-source}

The `prometheus-source-params` is used to import common performance metrics
data which is provided by a Prometheus server. The `source-uir` is used to
establish the connection with the Prometheus server. The `query-data` is used
to speficify the potential query expression in PromQL.

## Model for ALTO Server-to-server Communication

In practice, multiple ALTO servers can be deployed for scalability. That may
require communication among different ALTO servers.

The YANG module defined in this document contains the configuration for
the communication between two ALTO servers.

TODO: this is still under the open discussion status.

# Design of ALTO O&M Statistics Data Model {#alto-stats-model}

## Model for ALTO Logging and Fault Management

As section 16.2.1 and section 16.2.3 of {{RFC7285}} suggest, the YANG data
module defined in this document contains statistics for logging and failure
detection.

NOTE: The detailed YANG module will appear in the future version.

## Model for ALTO-specific Performance Monitoring

As section 16.2.5 of {{RFC7285}} suggests, the YANG data module defined in this
document also contains statistics for ALTO-specific performance metrics.

More specifically, this data model contains the following measurement
information suggested by {{RFC7971}}:

- Measurement of impact
    - Total amount and distribution of traffic
    - Application performance
- System and service performance
    - Requests and responses for each information resource
    - CPU and memory utilization
    - ALTO map updates
    - Number of PIDs
    - ALTO map sizes

Besides the measurement information suggested by {{RFC7971}}, this data model
also contains useful measurement information for other ALTO extensions:

- Number of generic ALTO entities (for {{I-D.ietf-alto-unified-props-new}} and
  {{I-D.ietf-alto-cdni-request-routing-alto}})
- Statistics for update sessions and events (for {{RFC8189}})
- Statistics for calendar (for {{RFC8896}})

<!--
Note that this module only contains statstics for performance information that a
common web server or an O&M tool cannot provide.
-->

The module, "ietf-alto-stats", augments the ietf-alto module to include
statistics at the ALTO server and information resource level.

~~~
module: ietf-alto-stats

  augment /alto:alto-server:
    +--ro num-total-req?         yang:counter32
    +--ro num-total-succ?        yang:counter32
    +--ro num-total-fail?        yang:counter32
    +--ro num-total-last-req?    yang:counter32
    +--ro num-total-last-succ?   yang:counter32
    +--ro num-total-last-fail?   yang:counter32
  augment /alto:alto-server/alto:resource:
    +--ro num-res-upd?    yang:counter32
    +--ro res-mem-size?   yang:counter32
    +--ro res-enc-size?   yang:counter32
    +--ro num-res-req?    yang:counter32
    +--ro num-res-succ?   yang:counter32
    +--ro num-res-fail?   yang:counter32
  augment /alto:alto-server/alto:resource/alto:resource-params
            /alto:networkmap/alto:alto-networkmap-params:
    +--ro num-map-pid?   yang:counter32
  augment /alto:alto-server/alto:resource/alto:resource-params
            /alto:propmap/alto:alto-propmap-params:
    +--ro num-map-entry?   yang:counter32
  augment /alto:alto-server/alto:resource/alto:resource-params
            /alto:cdni/alto:alto-cdni-params:
    +--ro num-base-obj?   yang:counter32
  augment /alto:alto-server/alto:resource/alto:resource-params
            /alto:update/alto:alto-update-params:
    +--ro num-upd-sess?      yang:counter32
    +--ro num-event-total?   yang:counter32
    +--ro num-event-max?     yang:counter32
    +--ro num-event-min?     yang:counter32
    +--ro num-event-avg?     yang:counter32
~~~

# Extension of ALTO O&M Data Model {#alto-ext-model}

As ALTO protocol is extensible, new protocol extensions can be developed after
this data model is published. To support future ALTO protocol extensions, the
extension documents can augment the existing cases of the `resource-params`
choice with new configuration parameters for existing ALTO information resource
extensions, or augment the `resource-params` with new cases for new ALTO
information resources.

Developers and operators can also extend this ALTO O&M data model to align
with their own implementations. Specifically, the following nodes of the data
model can be augmented:

- The `algorithm` choice of the `resource-params` of each `resource`.
- The `data-source` choice.

The following example shows how the developer augments the `algorithm`
choice of `alto-networkmap-params` with a creation algorithm for the network
map resource.

~~~
module: example-ietf-alto-alg

  augment /alto:alto-server/alto:resource/alto:resource-params
            /alto:networkmap/alto:alto-networkmap-params
            /alto:algorithm:
    +--:(l3-unicast-cluster)
       +--rw l3-unicast-cluster-algorithm
          +--rw l3-unicast-topo
          |       -> /alto:alto-server/data-source/source-id
          +--rw depth?             uint32
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

<!-- End of sections -->
