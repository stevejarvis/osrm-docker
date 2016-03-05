Open Source Routing Machine in Docker
==============

Sets up and run the OSRM with OpenStreetMap data for the state of Massachusetts (in a Docker container).

## Setup

From project directory, build image with:

    docker build --tag=osrm .

Map to whatever port is desired on host. To run in the background (probably desired), issue a command similar to this:

    docker run -d --publish=5000:5000 osrm

Alternatively, to run in foreground:

    docker run --rm --interactive --tty --publish=5000:5000 osrm

Currently set up to generate walking routes. Change the "mode" ENV var in the Dockerfile to generate for car or bike. These different modes of transit could all be run in different daemons and offered on different ports on the host (e.g. walking on port 5000, driving port 5001, bicycle port 5002).

## API

[See here for API documentation](https://github.com/Project-OSRM/osrm-backend/wiki/Server-api). Here's one example query (provides walking time, in tenths of seconds, from each source/dest combination of Arlington, Copley, and BU West MBTA stops):

    http://localhost:5000/table?loc=42.351902,-71.070893&loc=42.342116,-71.121263&loc=42.350941,-71.113876

Returns:

    {
      "status":200,
      "source_coordinates":
      [
        [42.351886,-71.070882],
        [42.342118,-71.121222],
        [42.350977,-71.113867]
      ],
      "destination_coordinates":
      [
        [42.351886,-71.070882],
        [42.342118,-71.121222],
        [42.350977,-71.113867]
      ],
      "distance_table":
      [
        [0,32681,27497],
        [32680,0,10035],
        [27497,10036,0]
      ]
    }
