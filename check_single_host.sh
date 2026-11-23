#!/bin/bash

resolved_ip=$(nslookup "$1" "$3" 2>/dev/null | awk '/^Address: / {print $2}' | grep -v ':' | head -n1)

if [ -n "$resolved_ip" ] && [ "$resolved_ip" != "$2" ]; then
    echo "Bogus IP for $1!"
fi
