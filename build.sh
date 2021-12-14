#!/usr/bin/env bash

#mix deps.get --only brain
mix deps.get

#deploy frontend assets
cd apps/frontend/
mix assets.deploy
cd ../../

MIX_ENV=prod mix compile

#npm install --prefix ./apps/webserver/assets
#npm run deploy --prefix ./apps/webserver/assets

MIX_ENV=prod mix phx.digest

rm -rf "_build"
MIX_ENV=prod mix release brain

