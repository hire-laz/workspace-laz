---
name: remotion-video-toolkit
description: Build programmatic videos with React and Remotion. Use when creating animated marketing videos, social media clips, data visualizations, personalized video content, TikTok/Reels captions, or any MP4 output driven by code and data. Covers animations, timing, text effects, media embedding, captions (Whisper/SRT), 3D, charts, and serverless rendering via Lambda.
---

# Remotion Video Toolkit

Build real MP4 videos by writing React components. Every frame is a React render.

## Requirements

- Node.js 18+
- React 18+
- Remotion — scaffold: `npx create-video@latest`
- FFmpeg — ships with @remotion/renderer (no separate install)
- AWS (Lambda) or GCP (Cloud Run) for serverless rendering

## Quick Start

```bash
# Create new video project
npx create-video@latest my-video
cd my-video

# Preview in browser (hot reload)
npm start

# Render to MP4
npx remotion render src/index.ts MyComposition out/video.mp4

# Pass dynamic data as props
npx remotion render src/index.ts MyComposition out.mp4 --props '{"title":"Hello Cho"}'
```

## Core Concepts

**Composition** = one video (has width, height, fps, duration)
**Frame** = one snapshot of React components at time T
**useCurrentFrame()** = current frame number (0 → durationInFrames)
**useVideoConfig()** = fps, width, height, durationInFrames

```tsx
import { useCurrentFrame, useVideoConfig } from 'remotion';

export const MyVideo = () => {
  const frame = useCurrentFrame();
  const { fps, durationInFrames } = useVideoConfig();
  const progress = frame / durationInFrames; // 0 to 1
  return <div style={{ opacity: progress }}>Fading in</div>;
};
```

## Animation Patterns

```tsx
import { interpolate, spring, useCurrentFrame, useVideoConfig } from 'remotion';

const frame = useCurrentFrame();
const { fps } = useVideoConfig();

// Linear interpolation (0 → 1 over 30 frames)
const opacity = interpolate(frame, [0, 30], [0, 1], {
  extrapolateLeft: 'clamp',
  extrapolateRight: 'clamp',
});

// Spring physics (natural motion)
const scale = spring({ frame, fps, config: { damping: 12, stiffness: 180 } });

// Slide in from left
const x = interpolate(frame, [0, 30], [-200, 0], { extrapolateRight: 'clamp' });
```

## Text Effects

```tsx
// Typewriter effect — one character per 2 frames
const charCount = Math.floor(frame / 2);
const displayText = fullText.slice(0, charCount);

// Word-by-word highlight (TikTok captions style)
const words = text.split(' ');
const activeWord = Math.floor(frame / 8); // new word every 8 frames
```

## Sequencing

```tsx
import { Sequence } from 'remotion';

// Scene 1: frames 0-90 (3 seconds at 30fps)
// Scene 2: frames 90-180
// Scene 3: frames 180-270
export const Timeline = () => (
  <>
    <Sequence from={0} durationInFrames={90}><SceneOne /></Sequence>
    <Sequence from={90} durationInFrames={90}><SceneTwo /></Sequence>
    <Sequence from={180} durationInFrames={90}><SceneThree /></Sequence>
  </>
);
```

## Media Embedding

```tsx
import { Video, Audio, Img } from 'remotion';

// Video clip
<Video src={staticFile('clip.mp4')} startFrom={30} endAt={90} volume={0.5} />

// Audio with fade
<Audio src={staticFile('music.mp3')} volume={interpolate(frame, [0, 30], [0, 1])} />

// Image
<Img src="https://images.unsplash.com/photo-xxx?w=1280&h=720" />
```

## Captions (TikTok Style)

```bash
# Install whisper transcription
npm install @remotion/captions
```

```tsx
import { transcribe } from '@remotion/captions';

// Transcribe audio to captions
const captions = await transcribe({ audio: 'voice.mp3', model: 'base' });

// Render word-by-word highlight
const activeCaption = captions.find(c => frame >= c.startFrame && frame <= c.endFrame);
```

## Dynamic Data (Personalized Videos)

```tsx
// src/MyVideo.tsx — accepts props
type Props = { name: string; score: number; date: string };

export const MyVideo: React.FC<Props> = ({ name, score, date }) => (
  <div>
    <h1>Hey {name}!</h1>
    <p>Your score: {score}</p>
    <p>Date: {date}</p>
  </div>
);

// Render with data
// npx remotion render src/index.ts MyVideo out.mp4 --props '{"name":"Cho","score":95}'
```

## Rendering Options

```bash
# Local render (MP4)
npx remotion render src/index.ts Composition out/video.mp4

# Full-page screenshot (PNG)
npx remotion still src/index.ts Composition out/frame.png --frame=60

# Serverless (AWS Lambda)
npx remotion lambda render MyComposition --props '{"name":"Cho"}'
```

## Output Folder

Save rendered videos to `~/Documents/` per workspace rules.

```bash
npx remotion render src/index.ts MyComposition ~/Documents/video-output.mp4
```

## See Also

- `references/compositions.md` — compositions, metadata, dynamic duration
- `references/animations.md` — interpolation, springs, easing curves
- `references/captions.md` — whisper integration, SRT import, display
- `references/rendering.md` — CLI, Lambda, Cloud Run, Express API
- Remotion docs: https://www.remotion.dev/docs
