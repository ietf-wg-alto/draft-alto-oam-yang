Hi Qin,

This is meant to be more about to health of the ALTO server itself instead
of that of the underlying network. This is to monitor the functioning of
the ALTO protocol with various statistics and counters.

Is the use of the term "ALTO-specific performance metrics", a source of
confusion? We could change that...

Thanks!
Dhruv


On Sat, Jul 9, 2022 at 8:10 PM Qin Wu <bill.wu=40huawei.com@dmarc.ietf.org>
wrote:

> Hi, All:
>
> In draft-ietf-alto-oam-yang-00, two YANG models have been defined:
>
> 1.ietf-alto.yang: focusing on server configuration
>
> 2.ietf-alto-stats.yang: focusing on performance monitor and logging and
> fault reporting
>
> I am not sure I understand the role or responsibility of the second model
> ietf-alto-stats.yang
>
> It seems the second yang module more looks into System and Service
> performance measurement based on requirements defined in section 3.4.3 of
> RFC7971:
>
> “
>
> 3.4.3.  System and Service Performance
>
>
>
>    A number of interesting parameters can be measured at the ALTO
>
>    server.  [RFC7285] suggests certain ALTO-specific metrics to be
>
>    monitored:
>
>
>
>    o  Requests and responses for each service listed in an Information
>
>       Directory (total counts and size in bytes).
>
>
>
>    o  CPU and memory utilization
>
>
>
>    o  ALTO map updates
>
>
>
>    o  Number of PIDs
>
>
>
>    o  ALTO map sizes (in-memory size, encoded size, number of entries)
>
>
>
>    This data characterizes the workload, the system performance as well
>
>    as the map data.  Obviously, such data will depend on the
>
>    implementation and the actual deployment of the ALTO service.
>
>    Logging is also recommended in [RFC7285].
>
>
>
> ”
>
> ALTO sever doesn’t need to collect these information from its southbound interface or from the underlying network.
>
> Since ALTO server can expose Cost metric information to ALTO client, I am wondering how these network performance related cost metrics are collected,
>
> Doesn’t ALTO Server be triggered to initiate measurement task and collect the network performance information from the underlying network? Or these measurement task have been pre-provisioned.
>
>
>
> What do I miss?
>
>
>
> -Qin (Speak as individual)
>
>
> _______________________________________________
> alto mailing list
> alto@ietf.org
> https://www.ietf.org/mailman/listinfo/alto
>