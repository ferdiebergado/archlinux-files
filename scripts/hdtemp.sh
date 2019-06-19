#!/bin/sh
nc 127.0.0.1 7634 | awk -F '|' '{print $4}'
