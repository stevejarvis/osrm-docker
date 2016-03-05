OSRM in Docker
==============

Sets up and run the Open Source Routing Machine with data for the state of Massachusetts.

From project directory, build image with:

    docker build --tag=osrm .

Map to whatever port is desired on host. To run in the background (probably desired), issue a command similar to this:

    docker run -d --publish=5000:5000 osrm

Alternatively, to run in foreground:

    docker run --rm --interactive --tty --publish=5000:5000 osrm

Currently set up to generate walking routes. Change the "mode" ENV var in the Dockerfile to generate for car or bike. These different modes of transit could all be run in different daemons and offered on different ports on the host (e.g. walking on port 5000, driving port 5001, bicycle port 5002).

[See here for API documentation](https://github.com/Project-OSRM/osrm-backend/wiki/Server-api). Here's one example query (provides walking time, in tenths of seconds, from Arlington to Copley MBTA stops):

    http://localhost:5000/table?loc=42.351902,-71.070893&loc=42.342116,-71.121263
