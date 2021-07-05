# chttp-utils

This plugin is available on the [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2537802091).

This is a support library that provides additional functions and wrappers for my HTTP library,
[CHTTP](https://github.com/timschumi/gmod-chttp).

Please note that installing the CHTTP module is still required.

If you like my work or otherwise profited from this addon, consider
[buying me a beer](https://paypal.me/schumact)!

## Usage

chttp-utils isn't a normal module due to naming conflicts with the actual binary module.
Instead, it is a normal LUA file that should be included.

```
-- Set this if you don't want to print any error messages when the module fails to load
-- (for example if you have your own messages or if you have fallback options).
CHTTP_SILENT = true

-- This will provide a global `chttp` table providing all the functions.
-- The table will not be present if the module fails to load.
include("chttp.lua")
```

The following functions will be available:

```
-- Behaves just like http.Fetch (https://wiki.facepunch.com/gmod/http.Fetch)
chttp.Fetch(url, onSuccess, onFailure, headers)

-- Behaves just like http.Post (https://wiki.facepunch.com/gmod/http.Post)
chttp.Post(url, parameters, onSuccess, onFailure, headers)
```
