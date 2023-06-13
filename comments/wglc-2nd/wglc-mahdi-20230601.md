Dear authors,

I have reviewed the draft draft-ietf-alto-oam-yang-07 and have some comments to share with you.

Firstly, I appreciate the concise and clear nature of the document. It was easy for me to follow the content, and I believe it lays a solid foundation for ALTO-OAM development purposes.

The document's focus on requirements and providing point solutions for those requirements is valuable. However, I noticed that some sections, such as 5.4.3 and 6, are missing references to the requirements.

Since the document is in its final stages, I would like to suggest some revisions to improve its readability.

The document sometimes uses "model[s]" and "module[s]" interchangeably to refer to single notions. For example, in 6.2, the last paragraph refers to "IETF-alto-stats" as both a module and a data model. I believe the intent of the document is to define YANG data models with multiple modules that should remain consistent throughout.

Regarding fault management metrics, I think a simple running count of failure cases may not cover the full range of useful information for administering and maintaining an ALTO server. The document could consider providing additional data points that can guide debugging. For example, snapshots of performance metrics or simple metrics like failure times could be useful. Using failure times, relevant debugging information can be extracted from Syslog.

On page 18 (section 5.4.2), the definition of the first category of type-specific parameters is not clear. Although the definition of "information resources with specific capabilities (e.g., cost constraints)" is clearer in 9.1.5 of RFC7285.

3.1 Additionally, on the same page, if these two categories are the only possible classes, "include two categories" should be changed to "fall into two categories."

The very last sentence of section 5.4.3 is complex. A simpler rephrasing could be: "If an authenticated ALTO client is included in any roles with access permission to a resource, the client is granted access to that resource."

Regarding the resource usage limits defined in section 5.4.2, a more generic definition that is extensible to general resources, not just limited to memory usage and the number of active update streams, would be favourable. While these two measures may seem the most important/desirable, a broader approach would be beneficial.

A reference to the relevant figure is missing from section 5.3.4.

On page 7, section 4.4 under "performance monitor," instead of "during," it should be "while" to accurately convey the intended meaning.

The last comment might be my personal opinion, so please feel free to neglect it by all means. The difference between management and maintenance is not fully specified in the RFC6291. The intent of this document is clearly broader than the definition of OAM in 6291 though. Maybe the document can use O&M everywhere to align the terminology?
Lastly, I would like to commend the team once again for writing such a clear and well-structured draft. Congratulations, and best of luck.

I am currently reading the data model code at the end of the document, and if I have any comments, I will provide them upon completion. I have no comments on the extension examples in the appendix. The examples are very clear and informative. Thank you.

Best regards, Mahdi
