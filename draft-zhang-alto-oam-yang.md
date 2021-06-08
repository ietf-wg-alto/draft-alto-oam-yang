---
docname: draft-zhang-alto-oam-yang-latest
title: A Yang Data Model for Operations, Administration, and Maintenance of ALTO Protocol
abbrev: ALTO OAM YANG
category: info

ipr: trust200902
area: Networks
workgroup: ALTO WG
keyword: ALTO, Internet-Draft

stand_alone: yes
pi:
  strict: yes
  comments: yes
  inline: yes
  editing: no
  toc: yes
  tocompact: yes
  tocdepth: 3
  iprnotified: no
  sortrefs: yes
  symrefs: yes
  compact: yes
  subcompact: no

author:
 -
    ins: J. Zhang
    name: Jingxuan Jensen Zhang
    organization: Tongji University
    email: jingxuan.zhang@tongji.edu.cn
    street: 4800 Cao'An Hwy
    city: Shanghai
    code: 201804
    country: China
 -
    ins: D. Dhody
    name: Dhruv Dhody
    organization: Huawei Technologies
    email: dhruv.ietf@gmail.com
    street: Divyashree Techno Park, Whitefield
    city: Bangalore
    region: Karnataka
    code: 560066
    country: India
 -
    ins: K. Gao
    name: Kai Gao
    street: "No.24 South Section 1, Yihuan Road"
    city: Chengdu
    code: 610000
    country: China
    org: Sichuan University
    email: kaigao@scu.edu.cn

normative:
  RFC2119:
  RFC6991:
  RFC7285:
  RFC7286:
  RFC7971:
  RFC8340:
  RFC8571:
  RFC8686:
  RFC8895:
  RFC8896:
informative:
  RFC8189:
  I-D.ietf-alto-path-vector:
  I-D.ietf-alto-unified-props-new:
  I-D.ietf-alto-cost-calendar:

--- abstract

This document defines a YANG data model for the operations and management of
Application-Layer Traffic Optimization (ALTO) Protocol. The operator can use
the data model to create and update ALTO information resources, manage the
access control, configure server-to-server communication and server discovery,
and collect statistical data.

--- middle

{::include introduction.md}

{::include term.md}

{::include objectives.md}

{::include design.md}

{::include others.md}

--- back

{::include appendix.md}
