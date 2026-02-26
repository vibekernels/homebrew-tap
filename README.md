# vibekernels/tap

Homebrew tap for [vibekernels](https://github.com/vibekernels) projects.

## Formulas

### zstd-vk

ARM64-optimized [Zstandard](https://facebook.github.io/zstd/) compression built with hybrid GCC/Clang PGO for +5-16% decompression speed on Apple Silicon.

```bash
brew tap vibekernels/tap
brew install vibekernels/tap/zstd-vk
```

The binary installs as `zstd-vk` and coexists with the standard `zstd` formula.

## Creating a release

1. Tag and push a release in the zstd-vk-macos-arm64 repo:
   ```bash
   git tag v1.6.0
   git push origin v1.6.0
   ```

2. The **Build Homebrew Bottle** workflow in `zstd-vk-macos-arm64` runs automatically on release publish. It builds the hybrid PGO binary, packages it as a bottle, and uploads it to the release. The CI output prints the `bottle do` block to add to the formula.

3. Update `Formula/zstd-vk.rb` with the new version URL, source SHA256, and the `bottle do` block from CI.
