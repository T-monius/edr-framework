# EDR Framework

This repo represents the development of a framework for monitoring Endpoint Detection and Response (EDR) agents in Ruby (support for MacOS and Linux).

## CRUD Activity

The EDR Framework is a ruby program that can create, update, and delete files which it stored in an `edr-files` directory at root of the project.

In order to create a file run the program with a `-c` flag to create a file and `-p` followed by the name of the file which will be created at the relative path to the `edr-files`:

```sh
ruby edr_framework.rb -c -p 'temp.txt'
```

For updating a file, run the program with the `-u` flag and a `-p` flag followed by the name of the file to be updated and the data to write to the file in that order:

```sh
ruby edr_framework.rb -u -p 'temp.txt' 'a bit more data'
```

In order to delete a file, run the program with a `-d` flag and the `-p` flag followed by the name of the file to delete:

```sh
ruby edr_framework.rb -d -p 'temp.txt'
```

## Transmitting Data

The EDR Framework will transmit data over a TCP connection to a host and port provided. In order to test the functionality, a sample server is provided in the `sample-server` directory which will run on localhost port 3002.

Run the TCP server prior to attempting to transmit data:

```sh
# From project root
ruby sample-server/tcp_server.rb
```

__To transmit to the server__

Run the framework with an `-n` flag followed by the host to which to connect the data, the port, and the data to be transmitted in that order:

```sh
ruby edr_framework.rb -n 'localhost' 3002 'hello'
```

## Logs

Logs of the activity will be written to the `logs/edr_framework_log.yaml` which attempts to track activity in YAML format, but due to utilization of Ruby's internal `logger`, some log data is prepended in non-yaml format.

## Future Work

- Customize logging to create valid YAML
- Refactor out logging, CRUD, and Network operations in an OOP manner and to make more robust
- Test
