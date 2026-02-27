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

### whisperkit-vk-cli

On-device speech recognition for Apple Silicon, powered by [WhisperKit](https://github.com/argmaxinc/WhisperKit) and optimized by vibekernels.

```bash
brew tap vibekernels/tap
brew install whisperkit-vk-cli
```

The binary installs as `whisperkit-vk-cli`.

## Creating a release

### zstd-vk

1. Tag and push a release in the zstd-vk-macos-arm64 repo:
   ```bash
   git tag v1.6.0
   git push origin v1.6.0
   ```

2. The **Build Homebrew Bottle** workflow in `zstd-vk-macos-arm64` runs automatically on release publish. It builds the hybrid PGO binary, packages it as a bottle, and uploads it to the release. The CI output prints the `bottle do` block to add to the formula.

3. Update `Formula/zstd-vk.rb` with the new version URL, source SHA256, and the `bottle do` block from CI.

### whisperkit-vk-cli

1. Create a release in the whisperkit-vk repo (via GitHub UI or CLI):
   ```bash
   gh release create v0.1.0 --repo vibekernels/whisperkit-vk --generate-notes
   ```

2. The **Homebrew Bottle** workflow runs automatically on release publish. It builds the Swift binary, packages it as a bottle, uploads it to the release, and auto-updates `Formula/whisperkit-vk-cli.rb` in this tap.

3. If the `HOMEBREW_TAP_TOKEN` secret is not configured, the CI output prints the `bottle do` block to add to the formula manually.
