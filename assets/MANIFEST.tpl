name: jackett
version: $VERSION
origin: local/jackett
comment: API Support for your favorite torrent trackers.
desc: <<EOD
  Jackett works as a proxy server: it translates queries from apps (Sonarr,
  Radarr, SickRage, CouchPotato, Mylar, Lidarr, DuckieTV, qBittorrent,
  Nefarious etc.) into tracker-site-specific http queries, parses the html
  response, then sends results back to the requesting software. This allows for
  getting recent uploads (like RSS) and performing searches. Jackett is a
  single repository of maintained indexer scraping & translation logic -
  removing the burden from other apps.
EOD
arch: amd64
www: https://github.com/Jackett/Jackett
maintainer: daniel@garajau.com.br
licenses: [GPLv2]
categories: [net-p2p]
prefix: /usr/local
deps: {
  mono: { origin: lang/mono }
}
