#!/bin/sh

swww init || swww img $(find $1 -type f | shuf -n 1)
