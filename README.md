# Bing wallpaper downloader

This simple script will download one, or more, wallpaper images from bing image archive service.

## Install

``` sh
make install
```

### Systemd users

Systemd service and timer are already provided to download a wallpaper every day. To register them:

``` sh
systemd daemon-reload
systemd enable --now bwd.timer
```

### cron users

For cron users, add the following line to your crontab to run the script every day:

``` text
0 0 */1 * *   /usr/bin/bwd
```

## Uninstall

``` sh
make uninstall
```

## Security

Required privileges:

| Privilege                      | Reason                                 |
|--------------------------------|----------------------------------------|
| write access to WALLPAPERS_DIR | Is where wallpapers will be downloaded |
