Hi，
Regarding ALTO Logging and Fault Management, it hasn’t been specified in draft-ietf-alto-oam-yang, I am thinking whether we should consider the following aspects,

1. Success or failure configuration: The configuration can be applied either successfully or not
2. Operation of ALTO server and update to capabilities: You might add new capability or modify one existing capability, Operation of ALTO server can also be logged
3. Status Update of the ALTO server: It can be related interface status information or schedule status information.

Best regards
Chongfeng Xie

---

Hi Chongfeng,

Many thanks for all your suggestions. See my responses inline.

On Thu, Jul 14, 2022 at 2:17 PM Chongfeng Xie <chongfeng.xie@foxmail.com> wrote:
> Hi，
> Regarding ALTO Logging and Fault Management, it hasn’t been specified in draft-ietf-alto-oam-yang, I am thinking whether we should consider the following aspects,
> 1. Success or failure configuration: The configuration can be applied either successfully or not

It makes sense to me.
 
> 2. Operation of ALTO server and update to capabilities: You might add new capability or modify one existing capability, Operation of ALTO server can also be logged

I agree. But I think the YANG data model should only contain some counts and types of the operation events, not the detailed logging messages.
 
> 3. Status Update of the ALTO server: It can be related interface status information or schedule status information.

Can you explain more about this? What kinds of status information do you envision? Do you mean the connection status between the ALTO server and some data sources (southbound interfaces)?
 

> Best regards
> Chongfeng Xie


Thanks again. We will consider all your comments in the next revision.

Thanks,
Jensen