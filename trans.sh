#!/bin/bash

SCRIPT_ABS_PATH="$(cd $(dirname "$0"); pwd)"

cd "$SCRIPT_ABS_PATH" || exit 1

[ -d "$SCRIPT_ABS_PATH/applications" ] && rm "$SCRIPT_ABS_PATH/applications" -rf
mkdir -p "$SCRIPT_ABS_PATH/applications"

APP_ARRAY=(
    # "/mnt/A/openwrt-latest/package/lean/luci-app-*"
    # "/mnt/A/BuildOpenWRT/latest/package/ctcgfw/luci-app-qos-gargoyle"
    )
for APP in ${APP_ARRAY[*]}
do
    APP_PATH=${APP%*/}
    APP_NAME=${APP_PATH##*/}
    APP_LOCAL_PATH="./applications/$APP_NAME"
    # echo $APP_PATH && echo $APP_NAME
    APP_LOCAL_PATH="./applications/$APP_NAME"
    ## set soft link
    echo "$APP_LOCAL_PATH"
    [ -e "$APP_LOCAL_PATH" ] || ln -s -t ./applications "$APP_PATH"
    ## scan
    mkdir -p "$APP_LOCAL_PATH/po/templates"
    cd "$APP_LOCAL_PATH" || exit 1
    "$SCRIPT_ABS_PATH/build/i18n-scan.pl" . > "./po/templates/${APP_NAME}.pot"
    cd "$SCRIPT_ABS_PATH" || exit 1
done

## add lang
"$SCRIPT_ABS_PATH/build/i18n-add-language.sh" zh_Hans

for APP in ${APP_ARRAY[*]}
do
    APP_PATH=${APP%*/}
    APP_NAME=${APP_PATH##*/}
    # echo $APP_PATH && echo $APP_NAME
    APP_LOCAL_PATH="./applications/$APP_NAME"
    ## update
    "$SCRIPT_ABS_PATH/build/i18n-update.pl" "$APP_LOCAL_PATH/po"
    sed -i '/^"Language: / s/^.*$/"Language: zh-Hans\\n"/' "$APP_LOCAL_PATH/po/zh_Hans/${APP_NAME}.po"
done
