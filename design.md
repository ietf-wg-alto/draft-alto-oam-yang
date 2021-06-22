# Design of ALTO OAM Data Model

## Overview of ALTO OAM Data Model

~~~
module: ietf-alto
  +--rw alto-server
     +--rw hostname  inet:host
     +--rw resource* [resource-id]
     |   +--rw resource-id    resource-id
     |   +--rw resource-type  service-type
     |   +--rw description?   string
     |   +--rw accept-group* [user-group]
     |      ...
     |   +--rw resource-params
     |      +--rw dependency*       resource-id
     |      +--:(ird)
     |      |  +--rw alto-ird-params
     |      |     +--rw delegation         inet:uri
     |      +--:(networkmap)
     |      |  +--rw alto-networkmap-params
     |      |     +--rw (algorithm)
     |      +--:(costmap)
     |      |  +--rw alto-costmap-params
     |      |     +--rw cost-type* [cost-mode,cost-metric]
     |      |     |  +--rw cost-mode       cost-mode
     |      |     |  +--rw cost-metric     cost-metric
     |      |     +--rw test-constraints?  boolean
     |      |     +--rw calendar?          boolean
     |      |     +--rw (algorithm)
     |      +--:(endpointcost)
     |      |  +--rw alto-endpointcost-params
     |      |     +--rw (algorithm)
     |      +--:(endpointprop)
     |      |  +--rw alto-endpointprop-params
     |      |     +--rw (algorithm)
     |      +--:(propmap)
     |      |  +--rw alto-propmap-params
     |      |     +--rw (algorithm)
     |      +--:(cdni)
     |      |  +--rw alto-cdni-params
     |      |     +--rw (algorithm)
     |      +--:(update)
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

<!-- End of sections -->