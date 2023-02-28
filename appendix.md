# Example: Extending the ALTO O&M Data Model {#alto-ext-model}

Developers and operators can also extend this ALTO O&M data model to align
with their own implementations. Specifically, the following nodes of the data
model can be augmented:

- The `server-discovery-manner` choice of the `server-discovery`.
- The `authentication` choice of each `auth-client`.
- The `data-source` choice.
- The `algorithm` choice of the `resource-params` of each `resource`.

## Example Module for Extended Server Discovery Manners {#example-server-disc}

The base data model defined by ietf-alto.yang only includes a reverse DNS based
server discovery manner. The following example module demonstrates how
additional server discovery manners can be augmented into the base data model.

The case `internet-routing-registry` allows the ALTO server to update the
server URI to the attribute of the corresponding aut-num class in IRR.

The case `peeringdb` allows the ALTO server to update the server URI to the org
object of the organization record in PeeringDB.

~~~
module example-vendor-alto-server-discovery {
  yang-version 1.1;

  namespace "https://example.com/ns/vendor-alto-server-discovery";
  prefix vendor-alto-disc;

  import ietf-alto {
    prefix alto;
    reference
      "RFC XXXX: A YANG Data Model for OAM and Management of ALTO
       Protocol.";
  }

  import ietf-inet-types {
    prefix inet;
    reference
      "RFC 6991: Common YANG Data Types";
  }

  organization
    "Example, Inc.";

  contact
    "Example, Inc.
     Customer Service

     E-mail: alto-oam-yang@example.com";

  description
    "This module contains a collection of vendor-specific cases of
     server discovery mechanisms for ALTO.";

  revision 2023-02-28 {
    description
      "Version 1.0";
    reference
      "Vendor ALTO Server Discovery Mechanisms: ALTO O&M YANG Model.";
  }

  augment "/alto:alto/alto:alto-server/alto:server-discovery"
        + "/alto:server-discovery-manner" {
    description
      "Examples of server discovery mechanisms provided by the ALTO
       server.";
    case internet-routing-registry {
      description
        "Update descr attributes of a aut-num class in a Internet
         Routing Registry (IRR) database for ALTO server discovery
         using RPSL.";
      reference
        "RFC 2622: Routing Policy Specification Language (RPSL).";
      container irr-params {
        description
          "Configuration parameters for IRR database.";
        leaf aut-num {
          type inet:as-number;
          description
            "The autonomous system (AS) to be updated.";
        }
      }
    }
    case peeringdb {
      description
        "Update metadata of a network record in PeeringDB database
         for ALTO server discovery using PeeringDB lookup.";
      container peeringdb-params {
        description
          "Configuration parameters for PeeringDB database.";
        leaf org-id {
          type uint32;
          description
            "The ID referring to the org object of the
             organization record in PeeringDB.";
        }
      }
    }
  }

  augment "/alto:alto/alto:alto-client/alto:server-discovery-client"
        + "/alto:server-discovery-client-manner" {
    description
      "Examples of server discovery mechanisms used by the ALTO
       client.";
    case internet-routing-registry {
      description
        "Use Internet Routing Registry (IRR) to discover an ALTO
         server.";
      reference
        "RFC 2622: Routing Policy Specification Language (RPSL).";
      container irr-params {
        description
          "Configuration for IRR query using RPSL.";
        leaf whois-server {
          type inet:host;
          description
            "Whois server for IRR query using RPSL.";
        }
      }
    }
    case peeringdb {
      description
        "Use PeeringDB to discover an ALTO server.";
      container peeringdb-params {
        description
          "Configuration for PeeringDB query";
        leaf peeringdb-endpoint {
          type inet:uri;
          description
            "Endpoint of PeeringDB API server.";
        }
      }
    }
  }
}
~~~

## Example Module for Extended Client Authentication Approaches {#example-client-auth}

The base data model defined by ietf-alto.yang only includes the client
authentication approaches directly provided by the HTTP server. However, a real
implementation may authenticate clients in different ways, e.g., it may
delegate the authentication to a third-party OAuth 2.0 server. The following
example module demonstrates how additional client authentication approaches can
be augmented into the base data model.

In this example, the case `oauth2` includes the URI to a third-party OAuth 2.0
based authorization server that the ALTO server can redirect to for the client
authentication.

~~~
module example-vendor-alto-auth {
  yang-version 1.1;

  namespace "https://example.com/ns/vendor-alto-auth";
  prefix vendor-alto-auth;

  import ietf-inet-types {
    prefix inet;
    reference
      "RFC 6991: Common YANG Data Types";
  }

  import ietf-alto {
    prefix alto;
    reference
      "RFC XXXX: A YANG Data Model for OAM and Management of ALTO
       Protocol.";
  }

  organization
    "Example, Inc.";

  contact
    "Example, Inc.
     Customer Service

     E-mail: alto-oam-yang@example.com";

  description
    "This module contains a collection of vendor-specific cases of
     client authentication approaches for ALTO.";

  revision 2023-02-28 {
    description
      "Version 1.0";
    reference
      "Vendor ALTO Client Authentication Approaches: ALTO O&M YANG
       Model.";
  }

  augment "/alto:alto/alto:alto-server/alto:auth-client"
        + "/alto:authentication" {
    description
      "Example of extended ALTO client authentication approaches.";
    case oauth2 {
      description
        "Example of authentication by a third-party OAuth 2.0
         server.";
      container oauth2 {
        description
          "Parameters for authentication by a third-party OAuth 2.0
           server.";
        leaf oauth2-server {
          type inet:uri;
          description
            "The URI to the authorization server.";
        }
      }
    }
  }
}
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
module example-vendor-alto-data-source {
  yang-version 1.1;

  namespace "https://example.com/ns/vendor-alto-data-source";
  prefix vendor-alto-ds;

  import ietf-alto {
    prefix alto;
    reference
      "RFC XXXX: A YANG Data Model for OAM and Management of ALTO
       Protocol.";
  }

  import ietf-datastores {
    prefix ds;
    reference
      "RFC8342: Network Management Datastore Architecture (NMDA)";
  }

  import ietf-yang-push {
    prefix yp;
    reference
      "RFC8641: Subscription to YANG Notifications for Datastore
       Updates";
  }

  import ietf-netconf-client {
    prefix ncc;
    reference
      "RFC HHHH: NETCONF Client and Server Models";
  }

  import ietf-restconf-client {
    prefix rcc;
    reference
      "RFC IIII: YANG Groupings for RESTCONF Clients and RESTCONF
       Servers";
  }

  organization
    "Example, Inc.";

  contact
    "Example, Inc.
     Customer Service

     E-mail: alto-oam-yang@example.com";

  description
    "This module contains a collection of vendor-specific cases of
     data sources for ALTO.";

  revision 2023-02-28 {
    description
      "Version 1.0";
    reference
      "Vendor ALTO Data Sources: ALTO O&M YANG Model.";
  }

  identity yang-datastore {
    base alto:source-type;
    description
      "Identity for data source of YANG-based datastore.";
  }

  identity protocol-type {
    description
      "Base identity for protocol type.";
  }

  identity netconf {
    base protocol-type;
    description
      "Identity for NETCONF protocol.";
  }

  identity restconf {
    base protocol-type;
    description
      "Identity for RESTCONF protocol.";
  }

  augment "/alto:alto/alto:alto-server/alto:data-source"
        + "/alto:source-params" {
    description
      "Example of data source for YANG datastore.";
    case yang-datastore {
      when 'derived-from-or-self(source-type, "yang-datastore")';
      description
        "Example data source for local and/or remote YANG datastore.";
      container yang-datastore-source-params {
        description
          "YANG datastore specific configuration.";
        leaf datastore {
          type ds:datastore-ref;
          mandatory true;
          description
            "Identity reference of the datastore from which to get
             data.";
        }
        list target-paths {
          key name;
          description
            "XPath to subscribed YANG datastore node or subtree.";
          leaf name {
            type string;
            description
              "Identifier of the supported xpath or subtree filters.";
          }
          uses yp:selection-filter-types;
        }
        leaf protocol {
          type identityref {
            base protocol-type;
          }
          description
            "Protocol used to access the YANG datastore.";
        }
        container restconf {
          uses rcc:restconf-client-app-grouping {
            when 'derived-from-or-self(../protocol, "restconf")';
          }
          description
            "Parameters for restconf endpoint of the YANG datastore.";
        }
        container netconf {
          uses ncc:netconf-client-app-grouping {
            when 'derived-from-or-self(../protocol, "netconf")';
          }
          description
            "Parameters for netconf endpoint of the YANG datastore.";
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
module: example-vendor-alto-alg

  augment /alto:alto/alto:alto-server/alto:resource
            /alto:resource-params/alto:networkmap
            /alto:alto-networkmap-params/alto:algorithm:
    +--:(l3-unicast-cluster)
       +--rw l3-unicast-cluster-algorithm
          +--rw l3-unicast-topo    leafref
          +--rw depth?             uint32
~~~

This example defines a creation algorithm called `l3-unicast-cluster-algorithm`
for the network map resource. It takes two algorithm-specific parameters:

l3-unicast-topo
: This parameter refers to the target path name of an operational
  `yang-datastore` data source node (See [](#example-data-source)) subscribed
  in the `data-source` list (See [](#data-source)). The referenced target path
  in the corresponding `yang-datastore` data source is assumed for an IETF
  layer 3 unicast topology defined in {{RFC8346}}. The algorithm uses the
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
module example-vendor-alto-alg {
  yang-version 1.1;

  namespace "https://example.com/ns/vendor-alto-alg";
  prefix vendor-alto-alg;

  import ietf-alto {
    prefix alto;
    reference
      "RFC XXXX: A YANG Data Model for OAM and Management of ALTO
       Protocol.";
  }

  import ietf-datastores {
    prefix ds;
    reference
      "RFC8342: Network Management Datastore Architecture (NMDA)";
  }

  import example-vendor-alto-data-source {
    prefix alto-ds;
  }

  organization
    "Example, Inc.";

  contact
    "Example, Inc.
     Customer Service

     E-mail: alto-oam-yang@example.com";

  description
    "This module contains a collection of vendor-specific cases of
     information resource creation algorithms for ALTO.";

  revision 2023-02-28 {
    description
      "Version 1.0";
    reference
      "Vendor ALTO Information Resource Creation Algorithms: ALTO O&M
       YANG Model.";
  }

  augment "/alto:alto/alto:alto-server/alto:resource"
        + "/alto:resource-params/alto:networkmap"
        + "/alto:alto-networkmap-params/alto:algorithm" {
    description
      "Example of network map creation algorithm.";
    case l3-unicast-cluster {
      description
        "Example algorithm translating an L3 unicast topology of I2RS
         to an ALTO network map";
      container l3-unicast-cluster-algorithm {
        description
          "Parameters for l3-unicast-cluster algorithm";
        leaf l3-unicast-topo {
          type leafref {
            path "/alto:alto/alto:alto-server/alto:data-source"
               + "/alto-ds:yang-datastore-source-params"
               + "/alto-ds:target-paths/alto-ds:name";
          }
          must 'deref(.)/../..'
             + '/alto-ds:datastore = "ds:operational"';
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
