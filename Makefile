run: build
	@./zig-out/bin/ParticleEngine

build: delete
	@zig build

delete:
	@rm -rf zig-out/
