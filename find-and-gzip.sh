#!/bin/bash

find . -size +10M | grep -v '.gz$' | grep -v '.bz2' | xargs bzip2
