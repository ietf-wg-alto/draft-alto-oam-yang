# Examples of Extending the ALTO O&M Data Model {#alto-ext-model}

Developers and operators can also extend the ALTO O&M data model to align
with their own implementations. Specifically, the following nodes of the data
model can be augmented:

- The `server-discovery-manner` choice of the `server-discovery`.
- The `authentication` choice of each `auth-client`.
- The `data-source` choice.
- The `algorithm` choice of the `resource-params` of each `resource`.

## An Example Module for Extended Server Discovery Manners {#example-server-disc}

The base data model defined by ietf-alto.yang only includes a reverse DNS based
server discovery manner. The following example module demonstrates how
additional server discovery manners can be augmented into the base data model.

The case `internet-routing-registry` allows the ALTO server to update the
server URI to the attribute of the corresponding aut-num class in IRR.

The case `peeringdb` allows the ALTO server to update the server URI to the org
object of the organization record in PeeringDB.

~~~
{::include yang/example-alto-server-discovery.yang}
~~~

## An Example Module for Extended Client Authentication Approaches {#example-client-auth}

The base data model "ietf-alto" only includes the client
authentication approaches directly provided by the HTTP server. However, an
implementation may authenticate clients in different ways. For example, an implementation may
delegate the authentication to a third-party OAuth 2.0 server. The following
example module demonstrates how additional client authentication approaches can
enrich the base data model.

In this example, the `oauth2` case includes the URI to a third-party OAuth 2.0
based authorization server that the ALTO server can redirect to for the client
authentication.

~~~
{::include yang/example-alto-auth.yang}
~~~

## Example Module for Extended Data Sources {#example-data-source}

The base data model defined by ietf-alto.yang does not include any choice cases
for specific data sources. The following example module demonstrates how a
implementation-specific data source can be augmented into the base data model.

The `yang-datastore` case is used to import the YANG data from a YANG
model-driven datastore. It includes:

- `datastore` to indicate which datastore is fetched.
- `target-paths` to specify the list of nodes or subtrees in the datastore.
- `protocol` to indicate which protocol is used to access the datastore. Either
  `restconf` or `netconf` can be used.

~~~
{::include yang/example-alto-data-source.yang}
~~~

## An Example Module for Information Resource Creation Algorithm {#example-alg}

The base data model "ietf-alto" does not include any choices cases
for information resource creation algorithms. But developers may augment the
"ietf-alto" module with definitions for custom creation algorithms
for different information resources. The following example module demonstrates
the parameters of a network map creation algorithm that translates an IETF
layer 3 unicast topology into a network map.

~~~
module: example-alto-alg

  augment /alto:alto/alto:alto-server/alto:resource
            /alto:alto-networkmap-params/alto:algorithm:
    +--:(l3-unicast-cluster)
       +--rw l3-unicast-cluster-algorithm
          +--rw l3-unicast-topo
          |  +--rw source-datastore    alto:data-source-ref
          |  +--rw topo-name?          leafref
          +--rw depth?             uint32
~~~

This example defines a creation algorithm called `l3-unicast-cluster-algorithm`
for the network map resource. It takes two algorithm-specific parameters:

'l3-unicast-topo':
: This parameter contains information referring to the target path name of an
  operational `yang-datastore` data source node (See [](#example-data-source))
  subscribed in the `data-source` list (See [](#data-source)). The referenced
  target path in the corresponding `yang-datastore` data source is assumed for
  an IETF layer 3 unicast topology defined in {{RFC8346}}. The algorithm uses
  the topology data from this data source to compute the ALTO network map
  resource. 'source-datastore' refers to the 'source-id' of the operational
  `yang-datastore` data source node, and 'topo-name' refers to the 'name' of
  the target path in the source datastore.

'depth':
: This optional parameter sets the depth of the clustering algorithm. For
  example, if the depth is set to 1, the algorithm will generate PID for every
  l3-node in the topology.

The creation algorithm can be reactively called once the referenced data source
updates. Therefore, the ALTO network map resource can be updated dynamically.

~~~
{::include yang/example-alto-alg.yang}
~~~

## Example Usage

This section presents a complete example showing how the base data model and
all the extended models above are used to set up an ALTO server and
configure corresponding components (e.g., data source listener, information
resource, access control).

~~~
{::include-fold examples/full-model-usage.json}
~~~

# A Sample ALTO Server Architecture to Implement ALTO O&M YANG Modules

[](#alto-ref-arch) shows a sample architecture for an ALTO server
implementation. It indicates the major server components that an ALTO server
usually needs to include and the YANG modules that these server components
need to implement.

> This section does not intend to impose an internal structure of server
> implementations, but is provided to exemplify how the various data model
> components can be used, including having provisions for future augmentations.

The following server components need to implement the 'ietf-alto' module ([](#alto-model)):

Server manager:
  : Provides the functionality and configuration of the server-level
  management, including server listen stack setup, server discovery setup,
  logging system configuration, global metadata, and server-level security
  configuration.

Information resource manager:
  : Provides the operation and management for creating, updating, and
  removing ALTO information resources.

Data source listener:
  : An ALTO server may start multiple data source listeners. Each data source
  listener defines a communication endpoint that can fetch ALTO-related
  information from data sources. The information can be either raw
  network/computation information or pre-processed ALTO-level information.

The following components need to implement the 'ietf-alto-stats' module
([](#alto-stats-model)) to provide statistics information:

Performance monitor:
  : Collects ALTO-specific performance metrics at a running ALTO server.

Logging and fault manager:
  : Collects runtime logs and failure events that are generated by an ALTO server and the service
  of each ALTO information resource.

The following components are also important for an ALTO server, although they
are not in the scope of the data models defined in this document:

Data broker:
  : An ALTO server may implement a data broker to store network/computation
  information collected from data sources or cache some preprocessed data. The
  service of the ALTO information resource can read them from the data broker
  to calculate ALTO responses and return to ALTO clients.

Algorithm plugin:
  : The service of each ALTO information resource needs to configure an algorithm to decide
  how to calculate the ALTO responses. The algorithm plugins implement those
  algorithms. User-specified YANG modules can be applied to different algorithm
  plugins by augmenting the ALTO modules
  ([](#alto-ext-model)).

Generally, the ALTO server components illustrated above have the following
interactions with each other:

- Both the server manager and information resource manager will report
  statistics data to the performance monitor and the logging and fault manager.
- The algorithm plugins will register callbacks to the corresponding ALTO
  information resources upon configuration; Once an ALTO information
  resource is requested, the registered callback algorithm will be invoked.
- A data source listener will fetch data from the configured data source using
  the corresponding data source API in either proactive mode (polling) or
  reactive mode (subscription/publication).
- A data source listener will send the preprocessed data to a data
  broker.
- An algorithm plugin may read data from an optional data broker to calculate
  the ALTO information resource.

~~~
  +----------------------+      +-----------------+
  | Performance Monitor: |<-----| Server Manager: |
  |  "ietf-alto-stats"   |<-+ +-|  "ietf-alto"    |
  +----------------------+  | | +-----------------+
                          report
  +----------------------+  | | +-------------------+
  | Logging and Fault    |  +---| Information       |
  | Manager:             |<---+ | Resource Manager: |
  | "ietf-alto-stats"    |<-----|    "ietf-alto"    |
  +----------------------+      +-------------------+
                                         ^|
                                         || callback
                                         |v
     .............          ................................
    /             \ <------ . Algorithm Plugin:            .
    . Data Broker .  read   .   "example-alto-alg"  .
    ...............         ................................
           ^
           | write
  +----------------+  Data Source  ++=============++
  | Data Source    |      API      ||             ||
  | Listener:      | <=====-=====> || Data Source ||
  |  "ietf-alto"   |               ||             ||
  +----------------+               ++=============++
~~~
{: #alto-ref-arch title="A Sample ALTO Server Architecture and ALTO YANG Modules"}

<!-- End of sections -->
