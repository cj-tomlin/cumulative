update-packwiz:
	go install github.com/packwiz/packwiz@latest
	go install github.com/Merith-TK/packwiz-wrapper/cmd/pw@main
	clear
	@echo "Packwiz has been Updated"
export-fabric:
	-mkdir -p .build/fabric/
	cd versions/fabric && pw batch mr export
	-mv versions/fabric/*/*.mrpack .build/fabric
export-quilt:
	-mkdir -p .build/quilt/
	cd versions/quilt && pw batch mr export
	-mv versions/quilt/*/*.mrpack .build/quilt
update-fabric:
	cd versions/fabric && pw batch update --all
update-quilt:
	cd versions/quilt && pw batch update --all
refresh-fabric:
	cd versions/fabric && pw batch refresh
refresh-quilt:
	cd versions/quilt && pw batch refresh
refresh:
	make refresh-fabric
	make refresh-quilt
update:
	make update-fabric
	make update-quilt
export:
	make export-fabric
	make export-quilt

server:
	@echo "Building server pack for Fabric 1.21.5"
	-rm -rf .server
	@mkdir -p .server
	@if [ -f versions/fabric/1.21.5/icon.png ]; then cp versions/fabric/1.21.5/icon.png .server/server-icon.png; fi
	cd .server && java -jar ../packwiz-installer-bootstrap.jar -s server ../versions/fabric/1.21.5/pack.toml
	@echo "Packaging server pack as zip"
	7z a .build/server-pack.zip .server
	@echo "Cleaning up .server folder"
	-rm -rf .server
	@echo "Server zip ready at .build/server-pack.zip"