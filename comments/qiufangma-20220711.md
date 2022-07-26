Hi, all

I have reviewed the draft-ietf-alto-oam-yang-00 draft today, and have got some comments regarding ietf-alto YANG module defined in the draft.

Please feel free to reject/accept them:

*         The "hostname" parameter, the type of this leaf is defined as inet:host, just a reminder that the inet:host in RFC 6991(and also in rfc6991-bis) is an union of inet:ip-address and inet:host-name. Is the authors' intention here to also cover a type of ip-address? Or you just want to define it as inet:host-name?

*         the new type of cost-mode is defined as enumeration, which is unscalable (unless you want IANA to maintain it). Since additional cost modes may be defined in the future, "identityref" should be used here instead of an enumeration.

*         The new type of cost-metric is defined as string, this is not proper from my perspective. All of the possible cost metrics defined in "ALTO Cost Metrics" IANA registry should be given, maybe an "identityref" type should also be used here?

*         For networkmap case, I don't really understand "is-default" parameter defined here. If there are multiple network maps as the ALTO server resource, it would be good to allow to specify a default network map to interact with simple ALTO client which may only support to use single network map. Since I don't see any network map list node in this model, so how to specify a default one? Any misunderstanding?

*         For endpointprop case, should the leaf-list data node "prop-types" be the type of an arbitrary "string"? I think we should list the set of possible values here and allow it to be extensible.

*         For proactive data source update policy, should the start and end time be allowed to configure here? Generally I think you can define the poll-interval as "mandatory true", and start/end time as optional.

*         Regarding the yang-datastore data source, are the authors referring to the xpath in the local ALTO server(which works as a restconf server here) datastore? Can it be a datastore inside any remote RESTCONF/NETCONF server?


Best Regards,
Qiufang