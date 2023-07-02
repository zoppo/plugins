Node.js
=======
This plugin provides some helpers for [Node.js][1] and loads [npm][2]
completion.

The provided helpers are `node:version` and `node:npm:version`.

npm Completion
--------------
You can enable/disable npm completion.

The default is enabled.

    zstyle ':zoppo:plugin:node:npm' enabled 'no'

nvm Integration
---------------
You can enable/disable nvm integration.

The default is enabled.

    zstyle ':zoppo:plugin:node:nvm' enabled 'yes'

You can change `$NVM_DIR` if you don't like the default one.

    zstyle ':zoppo:plugin:node:nvm' path "$HOME/.nvm"

[1]: http://nodejs.org
[2]: http://npmjs.org
