#!/usr/bin/env bash

awesome-client "
  require('awful')
  for _, c in ipairs(client.get()) do
    if c.profile then
      if c.profile:match('firefox.*') then
        c.icon = c.alticon
      end
    end
  end
"
