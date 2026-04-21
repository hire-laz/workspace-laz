# Remotion Rendering — CLI, Lambda, Express

## Local CLI Rendering

```bash
# Render full video
npx remotion render src/index.ts MyComposition out/video.mp4

# Render with props
npx remotion render src/index.ts MyComposition out/video.mp4 \
  --props '{"name":"Cho","score":95}'

# Render still (single frame)
npx remotion still src/index.ts MyComposition out/frame.png --frame=60

# Control quality
npx remotion render src/index.ts MyComposition out/video.mp4 \
  --crf=18 \          # Video quality (lower = better, 18 is excellent)
  --codec=h264 \      # Codec (h264, h265, vp8, vp9, prores)

# Render range of frames
npx remotion render src/index.ts MyComposition out/video.mp4 \
  --frames=0-90       # Only frames 0 to 90
```

---

## Node.js API (Programmatic)

```ts
import { renderMedia, selectComposition } from '@remotion/renderer';

const composition = await selectComposition({
  serveUrl: 'http://localhost:3000',
  id: 'MyComposition',
  inputProps: { name: 'Cho', score: 95 },
});

await renderMedia({
  composition,
  serveUrl: 'http://localhost:3000',
  codec: 'h264',
  outputLocation: '~/Documents/output.mp4',
  inputProps: { name: 'Cho', score: 95 },
  onProgress: ({ progress }) => console.log(`${Math.round(progress * 100)}%`),
});
```

---

## Express API (Render as a Service)

Build a simple HTTP endpoint that accepts JSON props and returns a video:

```ts
import express from 'express';
import { renderMedia, selectComposition, bundle } from '@remotion/renderer';
import path from 'path';

const app = express();
app.use(express.json());

let bundled: string;

app.post('/render', async (req, res) => {
  if (!bundled) {
    bundled = await bundle(path.join(__dirname, 'src/index.ts'));
  }

  const { compositionId, props } = req.body;
  const outputPath = `/tmp/${Date.now()}.mp4`;

  const composition = await selectComposition({
    serveUrl: bundled,
    id: compositionId,
    inputProps: props,
  });

  await renderMedia({
    composition,
    serveUrl: bundled,
    codec: 'h264',
    outputLocation: outputPath,
    inputProps: props,
  });

  res.sendFile(outputPath);
});

app.listen(3001, () => console.log('Render API on :3001'));
```

**Usage:**
```bash
curl -X POST http://localhost:3001/render \
  -H "Content-Type: application/json" \
  -d '{"compositionId":"MyVideo","props":{"name":"Cho","score":95}}'
```

---

## AWS Lambda (Serverless, Scalable)

```bash
# Install Lambda package
npm install @remotion/lambda

# Setup AWS credentials
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...
export AWS_REGION=us-east-1

# Deploy Lambda function (one time)
npx remotion lambda functions deploy --memory=3008 --timeout=120

# Deploy site to S3
npx remotion lambda sites create --site-name=my-video

# Render remotely
npx remotion lambda render my-video MyComposition \
  --props '{"name":"Cho"}' \
  --output-bucket=my-renders
```

**Programmatic Lambda render:**
```ts
import { renderMediaOnLambda, getRenderProgress } from '@remotion/lambda';

const { renderId, bucketName } = await renderMediaOnLambda({
  region: 'us-east-1',
  functionName: 'remotion-render',
  serveUrl: 'https://remotionlambda-xyz.s3.amazonaws.com/sites/my-video',
  composition: 'MyComposition',
  inputProps: { name: 'Cho', score: 95 },
  codec: 'h264',
});

// Poll for completion
while (true) {
  const progress = await getRenderProgress({ renderId, bucketName, region: 'us-east-1' });
  if (progress.done) break;
  console.log(`${progress.overallProgress * 100}%`);
  await new Promise(r => setTimeout(r, 2000));
}
```

---

## Output Formats

| Format | Extension | Use Case |
|--------|-----------|----------|
| H.264 | .mp4 | Universal, social media upload |
| H.265/HEVC | .mp4 | Smaller file, less compatible |
| VP8 | .webm | Web embedding (less supported) |
| VP9 | .webm | Better quality web video |
| ProRes | .mov | Editing in Final Cut/Premiere |
| GIF | .gif | Small animated loops |
| PNG sequence | .png | Post-processing in external tool |

---

## Quality Settings

```bash
# CRF (Constant Rate Factor) — lower = better quality, bigger file
# H.264 recommended: 18-28
npx remotion render ... --crf=18     # Near lossless
npx remotion render ... --crf=23     # Good quality (default)
npx remotion render ... --crf=28     # Smaller file, visible quality loss

# Resolution override
npx remotion render ... --scale=2    # 2x resolution (4K from 1080p composition)
npx remotion render ... --scale=0.5  # Half resolution (quick preview)
```

---

## Performance Tips

- Use `--concurrency=4` (or higher) for faster local renders
- Use Lambda for batch rendering (parallel renders)
- `--scale=0.5` for preview renders
- Pre-bundle once, render many times in Node API
- Keep compositions under 5 minutes when possible
- Static assets: use `staticFile()`, not raw paths
