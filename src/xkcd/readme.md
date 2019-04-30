# XKCD

> see https://aka.ms/autorest

This is the AutoRest configuration file for XKCD

---
## Getting Started
To build the SDK for XKCD, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`
---

## Configuration


### Basic Information
These are the global settings for the  API.




``` yaml

input-file: xkcd.yaml
#namespace: XKCD.Search

powershell:
  clear-output-folder: true
  output-folder: generated


```


``` yaml

use:
- "@microsoft.azure/autorest.powershell@beta"

```