Hi Shenshen,

Many thanks for your review comments. Please see my response inline.

Thanks,
Jensen


On Sat, May 20, 2023 at 6:05 PM Shenshen Chen <shenshen.chen.tj@gmail.com>
wrote:

> Hi, all
>
> I wrote a review for draft-ietf-alto-oam-yang-07, following the call for
> volunteers from Jordi.
> Since I am not confident with my comments, please feel free to ignore
> them. The following comments are started with the related part of the draft.
>
> 1. The whole draft
> It confuses me if this draft claims "a single data model" or "multiple
> models".
>
>     Some sentences take a single model:
>     * defines a YANG data model (Introduction)
>     * Scope of data model (title of Sec 4.1.)
>     * The data model (Table 2)
>
>     Some assume multiple models:
>     * YANG Data Models (title of this document)
>     * The following items are in the scope of the data models (Sec 4.1.)
>
> I prefer a single model (with multiple modules). By the way, there are
> some more
> "singular and plural" issues, e.g., titles of A.3. and A.5.
>

Thanks for catching the inconsistent words. We will go through the whole
document and fix them.


>
> 2. Figure 1
> The description of Figure 1 seems to be ambiguous - it presents
>     * Both the server manager and information resource manager will
>       report statistics data to performance monitor and logging and
>       fault manager.
> But Figure 1 shows that Information Resource Manager only reports to
> Logging and Fault Manager, rather than both two Managers.
>

Maybe the "report" label is confusing. We want to label "report" on all
four arrows from server manager and information resource manager to
performance monitor and logging & fault manager. We will refine Figure 1 to
make it clear.


>
> Also, the 2nd paragraph of the description presents
>     * The algorithm plugins will register callbacks to the corresponding
>       ALTO information resources upon the configuration; ...
> But I cannot find the corresponding components in Figure 1
> (I assume the "plugin" shown in Figure 1 refers to the 5th paragraph).
>

Not sure which components are missing here. Algorithm plugins or ALTO
information resources?


>
> 3. Sec 5.4.1.
> It presents
>     * If poll-interval is zero, the ALTO server will not fetch the data
> source.
> I wonder whether the poll-interval should be allowed to be zero since it
> seems cannot work.
> If it should, should we define such a mode differently from
> proactive/reactive modes?
>

Although I don't understand why it cannot work, I agree that it is a good
idea to move it to a different mode.


>
> 5. Some relationships/structures are not clear to me
> a) The R3 seems to be overlapped with R6 and R7.
> And the 'meta' defined in Sec 5.3.3. seems to be overlapped with Sec 6.2.
>

R3 focuses on the writable data nodes. R6 and R7 focus on the read-only
data nodes.


>
>
> b) Sec 5.3. presents "Server-level Operation and Management" and
> Sec 5.4. presents "Server Configuration Management".
> Does it mean the Management (the "M" in "O&M") consists of
> server-level management and configuration management?
>

Management ("M" in "O&M") is not limited to server-level management and
configuration management. RFC 6291 has more concrete descriptions of this
term. For ALTO, RFC 7285 (Sec 16) suggests 6 pieces of management
components. The server-level management in this document defines an
aggregation of multiple management components. I guess this makes you
confused. We will add a paragraph at the beginning of Sec 5.3 to clarify
this.


>
> Clarifying their relationships explicitly would be helpful to me.
>
> And there are some minor comments:
> 1. Sec 5.1.
>     * The container 'alto-server' contains both configuration and
> operational data
> Use "configurational" to be consistent with "operational".
>
> 2. Figure 4
>     * IETF ALTO Server Level Subtree Structure (title)
> Use "Server-Level" to be consistent with other parts.
>
> 3. Sec 5.3.
>     * The ALTO server instance contains a set of data nodes server-level
> operation
>       and management for ALTO that are shown in Figure 4.
> It seems a word (e.g. "for") is missing between "nodes" and "server-level
> operation".
>
> 4. Sec 5.4.3.
>     * They declare the Capabilities of the ALTO information resource ...
> Use "Capabilities (Section 9.1.3 of [RFC7285])" to make it clear.
>
> 5. Sec 5.3.4.
>     * All the related configurations are covered by the server listen
> stack.
> Use "ALTO Server Listen Stack" to make it clear.
>
> 6. Sec 5.4.2.
>     * Each resource entry provides configurations defining how to create
> or update an ALTO information resource.
> This topic sentence does not mention "remove". Maybe use expressions like
> "One can create, update or remove an ALTO information resource by adding,
> updating, or removing a resource entry" or some other expressions.
>

Many thanks for the editing suggestions. We will consider them.


>
> In the end, here is a random thought: is there any concern about the
> shutdown, or just assume the ALTO server would never be deliberately shut
> down?
>

That's a very good point. The operation of server shutdown is not in the
scope. But the server crash should be considered. Right now, the data model
does not include any healthcheck-related data nodes explicitly. The syslog
may be used to handle this.


>
> Best Regards,
> Shenshen
>
> Shenshen Chen
>
> PhD student
>
> Tongji University
