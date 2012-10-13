Archive
=======
This plugin provides wrappers for various archive tools.

It's extensible and pluggable.

Disable extensions
------------------
You can disable certain extensions for specific functionalities or globally.

    zstyle ':zoppo:plugin:archive' disable 'deb' 'tar.gz'
    zstyle ':zoppo:plugin:archive:extract' disable 'tar.xz'

