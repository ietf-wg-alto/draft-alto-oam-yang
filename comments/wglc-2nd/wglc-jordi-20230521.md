Please find below comments from my latest review of the doc draft-ietf-alto-oam-yang. No major blockers from my side, mainly some comments on definitions, semantics, and nits. Many thanks.

Jordi


* Definitions:
-------------

(1) In Section 4.4., the following terms are introduced for the first time:

{'server manager', 'information resource', 'performance monitor', 'logging and fault manager', 'algorithm', 'algorithm plugin', 'data source'}

Some of these terms might be intuitive, but I think it would be important to provide an explicit definition. For instance, the term 'algorithm' is quite generic, but it does have a specific meaning in the context of this specification that would be beneficial to state. Providing an example would also be very useful. Can I suggest that we add a subsection of definitions, providing a definition for each of these terms and a simple example?

(2) In Section 5.2 we explain 'server-discovery-channel' but we don't explain 'client-id'. Shall we also add a sentence describing 'client-id' for completeness?

(3) In this sentence "By default, 'syslog' is the only", shall we include a reference to the syslog RFC? (E.g., RFC 5425)

* Semantics:
--------------

(1) In the sentence "an ALTO server implementation should contain", should the 'should' be capitalized? (SHOULD)

(2) The following sentence is a bit confusing in a couple of ways: "the top-level container 'alto' in the "ietf-alto" module contains a single 'alto-server' and a list of 'alto-client' that are uniquely identified"

'alto-client' is the list itself, so instead of "a list of 'alto-client'", I think it should be "a list 'alto-client'" without "of". Also, it is not clear what this part refers to: "that are uniquely identified". I think it refers to the fact that the ALTO clients are uniquely identified (via 'client-id'). But the subject in this sentence is the list 'alto-client', not the clients themselves. So I might suggest using "the top-level container 'alto' in the "ietf-alto" module contains a single 'alto-server' and a list 'alto-client'". (Without "of" and without the qualifier "that are uniquely identified".)

(3) The doc states that "If 'feed-interval' is zero, the data source is expected to work in the 'on-change' mode". But wouldn't in this case 'on-change' be present and 'feed-interval' not be present? It seems redundant to have 'feed-interval' be zero and 'on-change' be present at the same time. Also in some parser implementations, it could be prone to error or add complexity If both are present. So maybe requiring that 'feed-interval' be larger than zero and delegating the case of zero to 'on-change' would keep it simpler.

(4) The doc states that "If poll-interval is zero, the ALTO server will not fetch the data source". In this case (corresponding to proactive updates), how is data fetched? A clarification would likely help.

(5) This paragraph is repeated twice: "A malicious client could attempt to set a very low/ large value to this node. Setting a very low value could attack the data source. And setting a very large value would lead to maintaining stale data in the ALTO server." 

May I suggest:
"In particular, for both 'feed-interval' and 'poll-interval', a malicious client could attempt to set a very low/large value to this node. Setting a very low value could attack the data source, while setting a very large value would lead to maintaining stale data in the ALTO server."

* Nits:
--------

s/The detailed design of the data model is illustrated by Section 5 and Section 6/The detailed design of the data model is illustrated in Section 5 and Section 6/

s/And some examples of how to extend this data model/Some examples of how to extend this data model

s/the following interactions with each others/the following interactions with each other/

s/Both the server manager and information resource manager will report statistics data to performance monitor and logging and fault manager/Both the server manager and the information resource manager will report statistics data to the performance monitor and the logging and fault manager/

Instead of "The algorithm plugins will register callbacks to the corresponding ALTO information resources upon the configuration", I would suggest "upon configuration" (without 'the') or, alternatively, you can probably say "The algorithm plugins will register callbacks to the corresponding ALTO information resources at initialization time"

s/A data source listener will update the preprocessed data to an optional data broker/A data source listener will send the preprocessed data to an optional data broker/ 
(Note: In this case, I would also omit the word 'optional', since otherwise it does not make sense to send something to a destination that does not exist.)

s/Data Model for Server-level Operation and Management/Data Model for ALTO Server Operation and Management/ (note: this is to follow the same style as in heading 5.2 and 5.4)

s/The 'listen' contains/'listen' contains (without 'The')

s/But it does not contain/However, it does not contain

s/which is sugested by/as suggested by

s/the ALTO server reactively waits the data source for pushing updates. For the proactive update, the ALTO server has to proactively fetch the data source periodically/the ALTO server reactively waits for the data source to push updates. For the proactive update, the ALTO server proactively fetches the data source periodically

s/To use the reactive update, two publish modes are supported/Two publish modes are available to support reactive updates

s/will trigger notifications to be generated/will trigger notifications (note: could you also clarify to who are these notifications sent?)

s/This basic model only includes authentication approach directly provided by the HTTP server/This basic model only includes the authentication approach provided by an HTTP server

s/statistics that indicates/statistics that indicate

s/More specifically, num-total-* and num-total-last-* provides server-level/More specifically, num-total-* and num-total-last-* provide server-level

s/num-map-entry and num-base-obj provides measurement for number of/num-map-entry and num-base-obj provide the measurement for the number of

s/num-upd-stream and num-upd-msg-* provides statistics/num-upd-stream and num-upd-msg-* provide statistics

s/that can be directly measured at the ALTO server/that can be directly measured by the ALTO server (Note: I am not fully sure here, but since ALTO is not in the data plane, that 'by' is a bit more appropriate, since 'at' tens to mean "in situ")

s/subset of all available protocol/subset of available protocol

s/in network environments/in the network environments that they are expected to operate in (note: there are 3 occurences of this sentence in Section 8)

s/their vulnerable:/their vulnerability:

s/when such mode is enabled/when such a mode is enabled (note: or perhaps even better to say "when this mode is enabled"

s/case in Appendix A.3 is such an example/case in Appendix A.3 provides an example

s/provided by the HTTP server/provided by an HTTP server

s/how a implementation-specific/how an implementation-specific

s/for an IETF layer 3 unicast/for the IETF layer 3 unicast

s/if the depth sets to 1, the algorithm will generate PID for every l3-node/if the depth is set to 1, the algorithm will generate a PID for every l3-node
