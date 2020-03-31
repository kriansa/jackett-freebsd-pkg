build_dir=build
package_dir=build/package

.PHONY: all
all: clean download package manifest build install

.PHONY: clean
clean:
	rm -rf $(build_dir)

.PHONY: download
download:
	mkdir $(build_dir) || true
	curl -s https://api.github.com/repos/jackett/jackett/releases/latest | \
		grep "tag_name" | grep -Eo "v[0-9.]+" > $(build_dir)/VERSION
	cd $(build_dir) && curl -OL https://github.com/Jackett/Jackett/releases/download/`cat VERSION`/Jackett.Binaries.Mono.tar.gz

.PHONY: package
package:
	mkdir -p $(package_dir)/usr/local/lib/jackett
	mkdir -p $(package_dir)/usr/local/etc/rc.d
	cd $(build_dir) && tar -zxpvf Jackett.Binaries.Mono.tar.gz
	mv $(build_dir)/Jackett/* $(package_dir)/usr/local/lib/jackett
	cp assets/service $(package_dir)/usr/local/etc/rc.d/jackett
	chmod +x $(package_dir)/usr/local/etc/rc.d/jackett

.PHONY: manifest
manifest:
	env VERSION=$$(cat $(build_dir)/VERSION | cut -c 2-) envsubst '$$VERSION' \
		< assets/MANIFEST.tpl > $(build_dir)/MANIFEST
	echo "files: {" >> $(build_dir)/MANIFEST
	find $(package_dir) \( -type f -o -type l \) -exec sha256 -r {} + | \
		awk '{print "  \"" $$2 "\": \"" $$1 "\""}' | sed 's:$(package_dir)::' \
		>> $(build_dir)/MANIFEST
	echo "}" >> $(build_dir)/MANIFEST
	echo "directories: {" >> $(build_dir)/MANIFEST
	find $(package_dir) -type d -mindepth 1 | \
		awk '{print "  " $$1 ": y"}' | sed 's:$(package_dir)::' \
		>> $(build_dir)/MANIFEST
	echo "}" >> $(build_dir)/MANIFEST

.PHONY: build
build:
	pkg create -r $(package_dir) -M $(build_dir)/MANIFEST -o $(build_dir)

.PHONY: install
install:
	pkg add $(build_dir)/jackett-$$(cat $(build_dir)/VERSION | cut -c 2-).txz
