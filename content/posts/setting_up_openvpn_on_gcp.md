+++
title = "Setting up OpenVPN on GCP"
date = 2018-10-08
lastmod = 2020-04-19T18:00:29-05:00
draft = false
weight = 2005
+++

At work I've recently been assigned with analyzing Ransomware samples to improve
our detection heuristics. As an extra precaution I've set up OpenVPN on a GCP
instance to ensure my home IP is not being captured by bad actors.

If you don't use GCP and would like to use this as a guide for another cloud
provider feel free, as the same general steps apply.

## Compute Instance Configuration {#compute-instance-configuration}

First, create a compute instance from the cloud console. Allow HTTP and HTTPS
traffic. If you want to force HTTPS, only select the allow HTTPS traffic option.

Once the instance is up and running, go to VPC network -> External IP Addresses
from the selection drawer in the top left. Change the external ip address for
the new VM instance from Ephemeral to Static.

Lastly, we need to setup the firewall rules for openvpn traffic. Select firewall
rules from the side tab, then click select 'Create Firewall Rule'. Name the
first rule openvpn-ingress. Change the following,

\#+BEGIN_SRC
Target tags: openvpn Source filter: 0.0.0.0/0 (if you will be accessing openvpn
from a static address, for example 1.2.3.4, you can change the filter to
(1.2.3.4/32) for added security.) Protocols and ports: udp 1194 (you can
customize this during openvpn setup or use the default) #+END_SRC

Change the same settings for an openvpn-egress rule, but change the direction of
traffic to egress.

That should be all the setup from the GCP Console.

## Configuring the compute instance. {#configuring-the-compute-instance-dot}

SSH into the compute instance. If you have the Google Cloud SDK installed and
configured for your account run,

```sh
gcloud compute ssh vpn #+END_SRC

From the compute instance we'll use the setup script from
https://github.com/angristan/openvpn-install to expedite the openvpn install
process.

Get the script and make it executable:

#+BEGIN_SRC sh
curl -O
https://raw.githubusercontent.com/Angristan/openvpn-install/master/openvpn-install.sh
chmod +x openvpn-install.sh #+END_SRC

Run the script,
#+BEGIN_SRC
./openvpn-install.sh #+END_SRC

Change the IP address to the static address assigned to the instance. Hit enter
for default selections for IPv6 support, listening port, protocol, dns resolver,
compression, and encryption

#+BEGIN_SRC sh

Your host does not appear to have IPv6 connectivity.

Do you want to enable IPv6 support (NAT)? [y/n]: n

What port do you want OpenVPN to listen to?
   1) Default: 1194
   2) Custom
   3) Random [49152-65535]
Port choice [1-3]: 1

What protocol do you want OpenVPN to use? UDP is faster. Unless it is not
available, you shouldn't use TCP.
   1) UDP
   2) TCP
Protocol [1-2]: 1

What DNS resolvers do you want to use with the VPN?
   1) Current system resolvers (from /etc/resolv.conf)
   2) Self-hosted DNS Resolver (Unbound)
   3) Cloudflare (Anycast: worldwide)
   4) Quad9 (Anycast: worldwide)
   5) Quad9 uncensored (Anycast: worldwide)
   6) FDN (France)
   7) DNS.WATCH (Germany)
   8) OpenDNS (Anycast: worldwide)
   9) Google (Anycast: worldwide)
   10) Yandex Basic (Russia)
   11) AdGuard DNS (Russia)
DNS [1-10]: 3

Do you want to use compression? It is not recommended since the VORACLE attack
make use of it. Enable compression? [y/n]: n

Do you want to customize encryption settings? Unless you know what you're doing,
you should stick with the default parameters provided by the script. Note that
whatever you choose, all the choices presented in the script are safe. (Unlike
OpenVPN's defaults) See
https://github.com/angristan/openvpn-install#security-and-encryption to learn
more.

Customize encryption settings? [y/n]: n

Okay, that was all I needed. We are ready to setup your OpenVPN server now. You
will be able to generate a client at the end of the installation. Press any key
to continue...
```

Continue with the installation.

After the installation succeeds you'll be prompted with the client name and
password/passwordless security settings for the machine you intend to connect to
the server.

Lastly, the instance needs to be configured to forward ipv4 packets.

Edit /etc/sysctl.conf and uncommment,

```conf
-#net.ipv4.ip_forward=1
+net.ipv4.ip_forward=1
```

The OpenVPN server should now be up and running.

## Client Setup {#client-setup}

From your client machine run,

```nil
gcloud compute scp <username>@<instance>:~/<clientname>.ovpn .
```

Import that config into your openvpn client and connect. If everything
configured correctly you should see the ip of your compute instance when
searching "whats my ip" on google.

[//]: # "Exported with love from a post written in Org mode"
[//]: # "- https://github.com/kaushalmodi/ox-hugo"
