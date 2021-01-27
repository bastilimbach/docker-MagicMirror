# Klaernie's Kubernetes Magic Mirror

## Where did I start?

I currently run two magic mirror screens.

One hallway screen, that serves as the family calendar hub, showing some nice picture and a few grafana panels.
The second screen is tied to the office, and mainly is used to get a nice clock, and the currently most relevant events for us homeoffice workers.

At the starting point of this project both render the same magic-mirror serveronly URL.
The server runs on my big workstation, so save CPU power on the display devices.

## So, where's the problem with that?

As my workstation serves as the main hub, it always got annoying when I rebooted the workstation, that I had to run to two magic mirror instances and restart them, as they lost connection to the server instance.

Furthermore as both instances share a config, it get's annoying with the layout. The two screens do not match in their resolution - the hallway has a healthy amount of space with 3440x1440, while the office only has 1280x800.
Also after just a week or two I noticed, that I don't care about a week's worth of calendar in the office, but rather just the current day and tomorrow.

## Now, what's the plan?

Now, under my desk I have a beefy server, recently upgraded to host all the internal services and finally gotten around to setting up a Kubernetes cluster as three VMs on it (yes, I wanted to play with KVM and Kubernetes - no other reason).
So the next logical question was: can I solve my magic-mirror problems with my Kubernetes setup.

So the plan is as following:
- set up two pods, one for the small screen, one for the big screen.
- keep the configuration in configmaps for easy editing
- expose the pods via a service
- as both instances need access to the calendar files, centralize that in a single nginx pod, reachable (for now) only from inside the cluster
- To feed the calendar data in, use a NFS-Share from my server. I did not what to wrap my working vdirsyncer setup in a container yet, so that's the easiest way.
- To store the modules I also used the NFS-Share

Besides this document you find the exact version (okay, the weather api key is missing ;) ) of the yaml files I used to deploy everything.

To set everything up I did the following:
- setup an NFS export on my server (it's `hive.ak-online.be:/volumes/k8s/magic-mirror`) accessible to my local network
- copy the entire modules directory from my working magic-mirror instances into it.
- change my vdirsyncer setup, so that it writes the synchronized ical files to this NFS share's `calendars/` directory.
  after a while I wanted to run vdirsyncer in a container as well, so checkout [klaernie/docker-vdirsyncer](https://github.com/klaernie/docker-vdirsyncer) if you like.
- create the namespace `magicmirror`
- `kubectl apply -f .` (in this directory)

