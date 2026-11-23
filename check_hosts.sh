#!/bin/bash
echo "andrei furculita"

cat /etc/hosts | while read -r ip name; do
    [[ -z "$ip" || "$ip" =~ ^# ]] && continue
    [[ -z "$name" ]] && continue
    [[ "$ip" =~ ^127\. ]] && continue
    [[ "$ip" =~ : ]] && continue
    [[ "$name" == "localhost" ]] && continue

    resolved_ip=$(nslookup "$name" 8.8.8.8 2>/dev/null | awk '/^Address: / {print $2}' | grep -v '#' | grep '\.' | head -n1)

    if [ -n "$resolved_ip" ] && [ "$resolved_ip" != "$ip" ]; then
        echo "Bogus IP for $name in /etc/hosts!"
    fi
done
