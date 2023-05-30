# Review: draft-ietf-alto-oam-yang-06.txt


## module ietf-alto

- General:

  - very well written
  - large module but quite understandable for implementors

### List Key Issues

- there are 3 list keys that use unconstrained 'string'
  as the data type

  - /alto/alto-client/client-id
  - /alto/alto-server/cost-type/cost-type-name
  - /alto/alto-server/role/role-name
  - /alto/alto-server/data-source/source-id


- the 'resource-id' is done correctly, using a well-constrained
  typedef to define the key leaf.

- A similar typedef for each of these 3 types is needed.
  The constraints do not have to be the same.
  Machine-readable stmts are preferred but description
  is just as normative as 'pattern'.

- the typedef should clarify the following issues:

  - semantics:

    - it should be clear if the name has any
      special meaning or derived from a field defined
      in a document.
    - Use 'reference' if possible to define the linkage.

  - whitespace:
    - leading or trailing whitespace allowed?
    - whitespace within the key string value allowed?

  - zero-length: if not allowed then a minimum length of 1
    should be specified.

  - max-length:
    - it may be desirable to pick a maximum string length
      - example with limit: range "1 .. 64";
      - without limit: range "1 .. max";
    - there are some engineering trade-offs to consider.
      Details are out of scope here.

  - allowed characters:
    - use of plain string means the server is expected to
      support the entire character set.  If this is not
      what is desired then limit the character set with a
      pattern or a description-stmt.

### /alto/alto-client

- mentioned in sec 5, 5.1, 5.2

- not clear if alto-client and alto-server would be implemented on the
  same device or expected that a device will implement one container
  or the other




### /alto/alto-server/logging-system/syslog-params/config-file

-  It is unusual to have an implementation or OS-specific
   default value for this sort of parameter.

        leaf config-file {
          type inet:uri {
            pattern 'file:.*';
          }
          default "file:/etc/syslog.conf";
          description
            "The file location of the syslog configuration.";
        }


### /alto/alto-server/meta

- The referenced RFC text is not sufficient to implement
  this list.

- It appears each list entry is a map entry and
  the meta-key is a JSONString, and meta-value is
  a JSONValue.

-  Not clear how arbitrary JSON is encoded here


       list meta {
        key "meta-key";
        description
          "Mapping of custom meta information";
        reference
          "Section 8.4.1 of RFC 7285.";
        leaf meta-key {
          type string;
          description
            "Custom meta key";
        }
        leaf meta-value {
          type string;
          mandatory true;
          description
            "Custom meta value";
        }
       }

- the entire referenced section

      Meta information is encoded as a map object for flexibility.
      Specifically, ResponseMeta is defined as:

        object-map { JSONString -> JSONValue } ResponseMeta;


### /alto/alto-server/auth-client/authentication

- this choice is not mandatory and there is no default.
- either add a mandatory-stmt, or a default-stmt, or explain
  what should happen if no authentication method is configured.


### /alto/alto-server/data-source/source-params

- Not much guidance or description on this placeholder choice.
  I understand you do not want to reference the 'example'
  YANG modules that augment this choice.

- Please add a reference or description mentioning the
  section in this RFC that explains the source params
  augmentation model.


        choice source-params {
          description
            "Data source specific configuration.";
        }

### grouping algorithm

- Same comment as source-params.
- Provide reference or other guidance how this mandatory
  empty choice is used.


         grouping algorithm {
          description
            "This grouping defines the base data model for information
             resource creation algorithm.";
          choice algorithm {
            mandatory true;
            description
              "Information resource creation algorithm to be augmented.";
          }
        }


### /alto/alto-server/data-source/feed-interval

- Add a units statement
- Is value zero allowed? If so what does it mean?
  If not then use a range-stmt


### /alto/alto-server/data-source/poll-interval

- Add a units statement
- Is value zero allowed? If so what does it mean?
  If not then use a range-stmt


### /alto/alto-server/resource/alto-costmap-params/cost-type-names

- Why is the type 'string' instead of a leafref
  to /alto/alto-server/cost-type/cost-type-name?

- Do not use a plural name for a leaf-list. (Use cost-type-name here)

### /alto/alto-server/resource/alto-costmap-params/testable-cost-type-names

- Why is the type 'string' instead of a leafref
  to /alto/alto-server/cost-type/cost-type-name?

- Do not use a plural name for a leaf-list.

### /alto/alto-server/resource/alto-endpointprop-params/prop-types

- Is there some other YANG data structure that this list
  of property types references?

- What are the allowed values for this string?
  Add a reference or description.

- Do not use a plural name for a leaf-list.


              leaf-list prop-types {
                type string;
                min-elements 1;
                description
                  "Supported endpoint properties.";
              }

## module ietf-alto-stats

###  container for statistics

- Suggest using a container (e.g., 'statistics') instead  of
  adding this many counter leafs directly to a list entry.
  This makes retrieval of all counters easier.

  - augment "/alto:alto/alto:alto-server"
  - augment "/alto:alto/alto:alto-server/alto:resource"

### 5 minute counters

- Should be type gauge64, not counter64 because the value can go down.

  - num-total-last-req
  - num-total-last-succ
  - num-total-last-fail

### size counters

- Should be type uint64, not counter64 because the value is a size.

  - res-mem-size
  - res-enc-size

### update event counters

- It is not clear what the correct data type should be. Not counter64.

  - num-event-max
  - num-event-min

- Are these leafs maintained over a 5 minute interval perhaps?
  Then they should be gauge64.

- The procedure to determine min and max should be specified or referenced.


## Example modules

### Leafref Typedefs

- There should be typedefs defined in ietf-alto to simplify
  usage in an extension module.

  - source-datastore
  - top-name

  - Example: source-datastore

          leaf source-datastore {
            type leafref {
              path '/alto:alto/alto:alto-server/alto:data-source'
                 + '/alto:source-id';
            }

  - Add a typedef to ietf-alto.yang

          typedef data-source-ref {
            type leafref {
              path '/alto:alto/alto:alto-server/alto:data-source'
                 + '/alto:source-id';
            }
          }

  - Change the leaf to use the typedef

          leaf source-datastore {
            type alto:data-source-ref;
          }

- The topo-name leafref definition should be a typedef.
  It is not clear which module should define the typedef.

          leaf topo-name {
            type leafref {
              path '/alto:alto/alto:alto-server/alto:data-source'
                 + '[alto:source-id = current()/../source-datastore]'
                 + '/alto-ds:yang-datastore-source-params'
                 + '/alto-ds:target-paths/alto-ds:name';
            }
            description
              "The name of the IETF layer 3 unicast topology.";
          }
