# BashPlay

**BashPlay** is a simple command-line tool that takes a song or artist name as an argument and plays a preview of a recommended song to listen to. Perfect for quick music discovery from the command line!

## Installation

For **Mac**:

Make sure [Homebrew](https://brew.sh/) is installed, then follow these steps:

1. Tap the repository:
   ```bash
   brew tap CoolCoder54323/bashmusic
   ```

2. Install `bashplay`:
   ```bash
   brew install bashplay
   bashplay "<query>"
   ```
For **Linux or wsl**:

1. Clone the repository:
   ```bash
   git clone "https://github.com/CoolCoder54323/homebrew-bashMusic.git"
   ```

2. Run directly `bashplay`:
   ```bash
   cd homebrew-bashMusic
   bash bashPlay.sh "<query>"
   ```

Once installed, you can use the `bashplay` command directly from your terminal.

## Usage

**BashPlay** requires a single argument, which can be the name of a song or an artist. It then fetches a preview of a song that matches your input.

```bash
bashplay "<song or artist name>"
```
### Note
- The tool currently supports only one argument (song or artist) at a time.

## License

This project is licensed under the MIT License.

---
