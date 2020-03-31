# Jackett FreeBSD Package

This is a package builder for the Jackett binaries available on their [github releases page][jackett-releases].

## How to install

On a FreeBSD Jail, pull this repository then build and install it by running the following commands:

```bash
# pkg install curl mono
# fetch https://github.com/kriansa/jackett-freebsd-pkg/archive/master.zip
# unzip master.zip && rm master.zip
# cd jackett-freebsd-pkg-master
# make all
# sysrc jackett_enable=YES
# service jackett start
```

## Quick info

- **Logs:** /usr/local/var/Jackett/log.txt
- **Port:** 9117

## License

Apache 2.0

[jackett-releases]: https://github.com/Jackett/Jackett/releases
