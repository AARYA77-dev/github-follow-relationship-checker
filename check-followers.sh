#!/bin/bash

# Get all followers
echo "Fetching your followers..."
followers=$(gh api user/followers --paginate -q '.[].login' | sort)

# Get all following
echo "Fetching who you follow..."
following=$(gh api user/following --paginate -q '.[].login' | sort)

# Convert to arrays
followers_array=($followers)
following_array=($following)

# Find people you follow but don't follow you back
echo ""
echo "=== People you follow but do NOT follow you back ==="
echo "$following" | while read user; do
  if ! echo "$followers" | grep -q "^$user$"; then
    echo "https://github.com/$user"
  fi
done

# Find people who follow you but you don't follow back
echo ""
echo "=== People who follow you but you do NOT follow back ==="
echo "$followers" | while read user; do
  if ! echo "$following" | grep -q "^$user$"; then
    echo "https://github.com/$user"
  fi
done