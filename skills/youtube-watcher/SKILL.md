---
name: youtube-watcher
description: Fetch and read YouTube video transcripts/subtitles. Use when you need to analyze video content, extract quotes, summarize talks, or pull captions from YouTube URLs. Requires yt-dlp binary (install via brew or pip). Outputs cleaned text transcripts to stdout.
---

# YouTube Watcher — Fetch & Read Transcripts

Extract transcripts and subtitles from YouTube videos in plain text format.

## When to Use

- Analyze video content without watching (get transcripts)
- Extract quotes from talks, interviews, tutorials
- Summarize video messages
- Pull captions for accessibility or reference
- Batch-process multiple video transcripts

## Installation

yt-dlp is required. Install once:

```bash
# Via Homebrew (recommended)
brew install yt-dlp

# Or via pip
pip install yt-dlp
```

Verify:
```bash
yt-dlp --version
```

## Usage

### Basic: Get transcript for a single video

```bash
yt-dlp --write-subs --skip-download --sub-format vtt \
  "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
```

This downloads subtitles as `.vtt` files to the current directory but skips the video itself.

### Clean and read

```bash
# Get subtitles and convert to plain text
yt-dlp --write-subs --skip-download --sub-format vtt \
  "https://www.youtube.com/watch?v=VIDEOID" && \
cat *.en.vtt | grep -v "^WEBVTT" | grep -v "^$" | grep -v "^[0-9:]" | tr '\n' ' '
```

### Multiple videos

```bash
# Create a file: videos.txt with one URL per line
while read url; do
  echo "=== $url ==="
  yt-dlp --write-subs --skip-download --sub-format vtt "$url"
  cat *.en.vtt | grep -v "^WEBVTT" | grep -v "^$" | grep -v "^[0-9:]"
  rm -f *.vtt
done < videos.txt
```

## Output Format

By default, yt-dlp produces `.vtt` (WebVTT) format:

```
WEBVTT

00:00:00.500 --> 00:00:07.000
Caption text here

00:00:07.000 --> 00:00:11.000
More caption text
```

To convert to plain text (no timestamps):

```bash
cat video.en.vtt | grep -v "^WEBVTT" | grep -v "^$" | grep -v "^[0-9:]"
```

## Tips

- **Language:** yt-dlp auto-detects available subtitle languages. For a specific language (e.g., Spanish):
  ```bash
  yt-dlp --write-subs --skip-download --sub-lang es "URL"
  ```

- **Auto-generated captions:** Some videos only have auto-generated captions. yt-dlp will get those if manual subtitles don't exist.

- **No subtitles?** Some videos don't have subtitles available. The command will fail silently or report "unable to download subtitles."

- **Save to file:** Pipe output to a text file:
  ```bash
  yt-dlp ... | tee transcript.txt
  ```

## Security Note

yt-dlp will make network requests to YouTube. The script outputs transcript text to stdout, which your agent may send to external services. **Avoid using on videos with sensitive/private information** if you don't want that content leaving your system.

## See Also

- yt-dlp docs: https://github.com/yt-dlp/yt-dlp
- WebVTT format: https://www.w3.org/TR/webvtt1/
