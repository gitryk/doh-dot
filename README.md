# doh-dot

Serve DoT+DoH DNS server with traefik+adguard home

&nbsp;

## What is?

I have uploaded the configuration that was verified to be working on my personal Oracle Cloud A1 server.

It would be beneficial for you to modify the settings to suit your own environment.

**The client IP address does not appear to be preserved for DNS-over-TLS (DoT) traffic.**

It seems difficult to resolve this in an isolated Docker network environment.

However, I did not use it because I did not want the Docker network mode to be set to host.

I will update the configuration once I find a solution for this issue.

&nbsp;

## Environment

* On Oracle A1 Ampere Server(ubuntu aarch minimal)
* Oracle NLB(irrelevant to this document)
* Docker
* traefik 3.6
* adguard home latest

&nbsp;

## Exceptions

The content of this document was written in English, translated using Gemini. 

Please understand that the author, being a non-native speaker, may have imperfect English.
