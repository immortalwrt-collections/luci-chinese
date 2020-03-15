# Normalize Chinese Version for OpenWRT luci application

## Usage:

1. Adding luci app path(absolute) `APP_ARRAY` in `trans.sh`

Example:
``` bash
APP_ARRAY=(
    "/mnt/A/openwrt-latest/package/lean/luci-app-*"
    "/mnt/A/BuildOpenWRT/latest/package/ctcgfw/luci-app-qos-gargoyle"
    )
```

2. Running `./trans.sh` for initialization or update

Po file for Chinese will be generated in `applications/[app name]/po/zh_Hans`.

Tip:
> You can merge old Chinese `.po` file
> 1. following above steps
> 2. open new-generated `.po` file in zh_Hans
> 3. copy all content in old po file to replace content of new file
> 4. run again `./trans.sh'
