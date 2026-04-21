# Remotion Captions — Whisper, SRT, TikTok-Style

## Install

```bash
npm install @remotion/captions
```

---

## Transcribe Audio with Whisper

```ts
import { transcribe } from '@remotion/captions';

// Local audio file
const { captions } = await transcribe({
  input: 'voice.mp3',
  model: 'base',           // tiny | base | small | medium | large
  language: 'en',
});

// captions = array of:
// { text: "Hello", startMs: 0, endMs: 500, confidence: 0.98 }
```

### Models by Speed/Accuracy

| Model | Speed | Accuracy | Use When |
|-------|-------|----------|----------|
| tiny | Fastest | Low | Quick prototype |
| base | Fast | OK | Social clips |
| small | Medium | Good | Most use cases |
| medium | Slow | Great | High quality |
| large | Slowest | Best | Professional |

---

## Import Existing SRT

```ts
import { parseSrt } from '@remotion/captions';
import fs from 'fs';

const srt = fs.readFileSync('captions.srt', 'utf-8');
const captions = parseSrt({ input: srt });
```

**SRT format:**
```
1
00:00:00,000 --> 00:00:02,500
Hello, welcome to Kaizen.

2
00:00:02,500 --> 00:00:05,000
This is day one.
```

---

## TikTok-Style Word-by-Word Display

Highlight each word as it's spoken:

```tsx
import { useCurrentFrame, useVideoConfig } from 'remotion';

type Caption = { text: string; startMs: number; endMs: number };

const WordByWordCaptions: React.FC<{ captions: Caption[] }> = ({ captions }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  const currentMs = (frame / fps) * 1000;

  const currentCaption = captions.find(
    (c) => currentMs >= c.startMs && currentMs <= c.endMs
  );

  if (!currentCaption) return null;

  return (
    <div
      style={{
        position: 'absolute',
        bottom: 100,
        width: '100%',
        textAlign: 'center',
        fontSize: 64,
        fontWeight: 700,
        color: 'white',
        textShadow: '2px 2px 8px rgba(0,0,0,0.8)',
        fontFamily: 'Inter, sans-serif',
        padding: '0 60px',
      }}
    >
      {currentCaption.text}
    </div>
  );
};
```

---

## Word-Level Highlighting (Per-Word Captions)

For even tighter sync, use word-level timestamps:

```ts
// Whisper returns word-level timestamps when requested
const { captions } = await transcribe({
  input: 'voice.mp3',
  model: 'small',
  wordTimestamps: true, // returns individual word timings
});

// captions[0].words = [
//   { text: 'Hello', startMs: 0, endMs: 250 },
//   { text: 'world', startMs: 280, endMs: 600 },
// ]
```

```tsx
// Render with per-word highlight
const WordHighlight: React.FC<{ words: Word[] }> = ({ words }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  const currentMs = (frame / fps) * 1000;

  return (
    <div style={{ textAlign: 'center', fontSize: 48 }}>
      {words.map((word, i) => {
        const isActive = currentMs >= word.startMs && currentMs <= word.endMs;
        return (
          <span
            key={i}
            style={{
              color: isActive ? '#FFD700' : 'white',
              fontWeight: isActive ? 900 : 400,
              transition: 'all 0.1s',
              margin: '0 4px',
            }}
          >
            {word.text}
          </span>
        );
      })}
    </div>
  );
};
```

---

## Caption Styling Variants

### Clean White (Reels style)
```tsx
style={{
  color: 'white',
  fontSize: 64,
  fontWeight: 700,
  textShadow: '2px 4px 12px rgba(0,0,0,0.9)',
  letterSpacing: '-0.01em',
}}
```

### Bold Highlight (TikTok style)
```tsx
// Active word
style={{ color: '#FFD700', fontWeight: 900, transform: 'scale(1.1)' }}
// Inactive word
style={{ color: 'white', fontWeight: 600 }}
```

### Outline (High contrast)
```tsx
style={{
  color: 'white',
  WebkitTextStroke: '2px black',
  paintOrder: 'stroke fill',
  fontSize: 72,
  fontWeight: 900,
}}
```

### Background Box
```tsx
<span style={{
  background: 'rgba(0,0,0,0.7)',
  padding: '4px 12px',
  borderRadius: 8,
  color: 'white',
}}>
  {currentCaption.text}
</span>
```

---

## Full Example: Voice + Captions

```tsx
import { Audio, staticFile, useCurrentFrame, useVideoConfig } from 'remotion';

export const VoiceWithCaptions: React.FC<{
  audioFile: string;
  captions: Caption[];
}> = ({ audioFile, captions }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  const currentMs = (frame / fps) * 1000;

  const current = captions.find(
    (c) => currentMs >= c.startMs && currentMs <= c.endMs
  );

  return (
    <>
      <Audio src={staticFile(audioFile)} />
      <div style={{
        position: 'absolute',
        bottom: 80,
        width: '100%',
        textAlign: 'center',
        padding: '0 40px',
      }}>
        {current && (
          <span style={{
            background: 'rgba(0,0,0,0.75)',
            color: '#FFD700',
            fontSize: 60,
            fontWeight: 800,
            padding: '8px 24px',
            borderRadius: 12,
          }}>
            {current.text}
          </span>
        )}
      </div>
    </>
  );
};
```
