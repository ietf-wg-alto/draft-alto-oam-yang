# Example: Extending the ALTO O&M Data Model {#alto-ext-model}

Developers and operators can also extend this ALTO O&M data model to align
with their own implementations. Specifically, the following nodes of the data
model can be augmented:

- The `data-source` choice.
- The `algorithm` choice of the `resource-params` of each `resource`.

## Example Module for Extended Data Sources {#example-data-source}

The base data model defined by ietf-alto.yang does not include any choice cases
for specific data sources. The following example module demonstrates how a
implementation-specific data source can be augmented into the base data model.

The `yang-datastore` case is used to import the YANG data from a YANG
model-driven data store.

It supports two types of endpoints: local and remote.

- For a local endpoint, the YANG data is located the data from the same
  YANG model-driven data store supplying the current ALTO O&M data model.
  Therefore, the ALTO data source listener retrieves the data using the
  internal API provided by the data store.
- For a remote endpoint, the ALTO data source listener establishes an HTTP
  connection to the remote RESTCONF server, and retrieve the data using the
  RESTCONF API.

The `source-path` is used to specify the XPath of the data source node.

~~~
module example-ietf-alto-data-source {

  namespace "urn:example:ietf-alto-data-source";
  prefix "alto-ds";

  import ietf-alto {
    prefix alto;
  }

  identity yang-datastore {
    base source-type;
    description
      "Identity for data source of YANG-based datastore.";
  }

  augment "/alto:alto-server/alto:data-source/alto:source-params" {
    case yang-datastore {
      when 'derived-from-or-self(source-type, "alto:yang-datastore"';
      container yang-datastore-source-params {
        leaf source-path {
          type yang:xpath1.0;
          mandatory true;
          description
            "XPath to subscribed YANG datastore node.";
        }
        description
          "YANG datastore specific configuration.";
        choice restconf-endpoint {
          case local {
            // Use local API to access YANG datastore
          }
          case remote {
            container restconf-endpoint-params {
              uses rcc:restconf-client-listen-stack-grouping;
            }
          }
        }
      }
    }
  }
~~~

## Example Module for Information Resource Creation Algorithm {#example-alg}

The base data model defined by ietf-alto.yang does not include any choice cases
for information resource creation algorithms. But developers may augment the
ietf-alto.yang data model with definitions for any custom creation algorithms
for different information resources. The following example module demonstrates
the parameters of a network map creation algorithm that translates an IETF
layer 3 unicast topology into a network map.

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
  assumed to be a `yang-datastore` data source (See [](#example-data-source)) for an
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

~~~
module example-ietf-alto-alg {

  namespace "urn:example:ietf-alto-alg";
  prefix "alto-alg";

  import ietf-alto {
    prefix "alto";
  }

  augment "/alto:alto-server/alto:resource/alto:resource-params"
        + "/alto:networkmap/alto:alto-networkmap-params"
        + "/alto:algorithm" {
    case l3-unicast-cluster {
      container l3-unicast-cluster-algorithm {
        leaf l3-unicast-topo {
          type leafref {
            path "/alto:alto-server/data-source/source-id";
          }
          mandatory true;
          description
            "The data source to an IETF layer 3 unicast topology.";
        }
        leaf depth {
          type uint32;
          description
            "The depth of the clustering.";
        }
      }
    }
  }
}
~~~

<!-- End of sections -->
