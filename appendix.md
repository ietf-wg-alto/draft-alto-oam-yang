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
{::include yang/example-vendor-alto-server-discovery.yang}
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
{::include yang/example-vendor-alto-auth.yang}
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
{::include yang/example-vendor-alto-data-source.yang}
~~~

## An Example Module for Information Resource Creation Algorithm {#example-alg}

The base data model "ietf-alto" does not include any choices cases
for information resource creation algorithms. But developers may augment the
"ietf-alto" module with definitions for custom creation algorithms
for different information resources. The following example module demonstrates
the parameters of a network map creation algorithm that translates an IETF
layer 3 unicast topology into a network map.

~~~
module: example-vendor-alto-alg

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
The update of the reference data source depends on the used `update-policy` (See
[](#data-source)).

~~~
{::include yang/example-vendor-alto-alg.yang}
~~~

## Example Usage

This section presents a complete example showing how the base data model and
all the vendor extended models above are used to set up an ALTO server and
configure corresponding components (e.g., data source listener, information
resource, access control).

~~~
{::include-fold examples/full-model-usage.json}
~~~

<!-- End of sections -->
