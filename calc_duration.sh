#!/usr/bin/env sh

calc_secounds() {
  echo "$1" | sed -r '
    s#\b([0-9]+d)?([0-9]+h)?([0-9]+m)?([0-9]+s?)?\b#(\0)#g
    s#([0-9]+)d#(\1 * 86400)#g
    s#([0-9]+)h#(\1 * 3600)#g
    s#([0-9]+)m#(\1 * 60)#g
    s#([0-9]+)s#(\1)#g
    s#\)\(#) + (#g
  '
}

calc=$(calc_secounds "$1")
seconds=$(echo "$calc" | bc)

days=$((seconds / 86400))
hours=$(( (seconds % 86400) / 3600 ))
minutes=$(( (seconds % 3600) / 60 ))
seconds=$((seconds % 60))


result="${days}d${hours}h${minutes}m${seconds}s"
result=$(echo "$result" | sed -r 's#(\b|[dhms])0[dhms]#\1#g')

echo "$result"
