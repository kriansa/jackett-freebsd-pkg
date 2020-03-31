# Jackett FreeBSD Package

This is a package builder for the Jackett binaries available on their [github releases page][jackett-releases].

## How to install

On a FreeBSD Jail, pull this repository then run the following commands:

```bash
$ make all
$ sysrc jackett_enable=YES
$ service jackett start
```

## Quick info

- **Logs:** /usr/local/var/Jackett/log.txt
- **Port:** 9117

## License

Apache 2.0

---
jackett-releases: https://github.com/Jackett/Jackett/releases
