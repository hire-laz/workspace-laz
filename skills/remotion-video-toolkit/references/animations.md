# Remotion Animations — Interpolation, Springs & Easing

## Core Hook: useCurrentFrame

```tsx
import { useCurrentFrame } from 'remotion';

const MyComp = () => {
  const frame = useCurrentFrame(); // 0 → durationInFrames
  return <div>{frame}</div>;
};
```

---

## interpolate() — Linear & Eased Animations

```tsx
import { interpolate } from 'remotion';

// Fade in over first 30 frames
const opacity = interpolate(frame, [0, 30], [0, 1], {
  extrapolateLeft: 'clamp',
  extrapolateRight: 'clamp',
});

// Slide in from left
const translateX = interpolate(frame, [0, 30], [-200, 0], {
  extrapolateRight: 'clamp',
});

// Scale up
const scale = interpolate(frame, [0, 20], [0.8, 1], {
  extrapolateRight: 'clamp',
});

// Apply to style
<div style={{ opacity, transform: `translateX(${translateX}px) scale(${scale})` }} />
```

### Easing Curves

```tsx
import { interpolate, Easing } from 'remotion';

// Ease in-out (natural)
const val = interpolate(frame, [0, 30], [0, 1], {
  easing: Easing.inOut(Easing.ease),
  extrapolateRight: 'clamp',
});

// Bounce
const val = interpolate(frame, [0, 30], [0, 1], {
  easing: Easing.bounce,
  extrapolateRight: 'clamp',
});

// Cubic bezier (custom)
const val = interpolate(frame, [0, 30], [0, 1], {
  easing: Easing.bezier(0.25, 0.1, 0.25, 1),
  extrapolateRight: 'clamp',
});
```

---

## spring() — Physics-Based Motion

```tsx
import { spring, useCurrentFrame, useVideoConfig } from 'remotion';

const frame = useCurrentFrame();
const { fps } = useVideoConfig();

// Default spring (bouncier)
const scale = spring({ frame, fps });

// Stiff, minimal bounce
const scale = spring({
  frame,
  fps,
  config: { damping: 50, stiffness: 400, mass: 1 },
});

// Wobbly
const scale = spring({
  frame,
  fps,
  config: { damping: 8, stiffness: 100 },
});

// Delay by N frames
const scale = spring({ frame: Math.max(0, frame - 15), fps });
```

### Spring Config Cheatsheet

| Feel | damping | stiffness |
|------|---------|-----------|
| Default | 10 | 100 |
| Snappy | 30 | 300 |
| Wobbly | 6 | 80 |
| Stiff | 50 | 500 |
| Gentle | 15 | 60 |

---

## Common Animation Patterns

### Fade In

```tsx
const opacity = interpolate(frame, [0, 30], [0, 1], {
  extrapolateRight: 'clamp',
});
```

### Slide In From Left

```tsx
const x = interpolate(frame, [0, 30], [-300, 0], {
  easing: Easing.out(Easing.cubic),
  extrapolateRight: 'clamp',
});
```

### Scale Pop

```tsx
const scale = spring({ frame, fps, config: { damping: 12, stiffness: 200 } });
```

### Stagger (Multiple Elements)

```tsx
const items = ['Item 1', 'Item 2', 'Item 3'];

items.map((item, i) => {
  const delayedFrame = Math.max(0, frame - i * 10); // 10-frame stagger
  const opacity = interpolate(delayedFrame, [0, 20], [0, 1], {
    extrapolateRight: 'clamp',
  });
  return <div style={{ opacity }}>{item}</div>;
});
```

### Count Up Number

```tsx
const targetNumber = 1000;
const currentNumber = Math.round(
  interpolate(frame, [0, 60], [0, targetNumber], {
    extrapolateRight: 'clamp',
    easing: Easing.out(Easing.cubic),
  })
);
return <div>{currentNumber.toLocaleString()}</div>;
```

### Pulsing / Breathing

```tsx
const scale = interpolate(
  Math.sin((frame / fps) * Math.PI * 2), // 1 full cycle per second
  [-1, 1],
  [0.95, 1.05]
);
```

### Typewriter Text

```tsx
const fullText = "Welcome to Kaizen.";
const charCount = Math.floor(interpolate(frame, [0, 60], [0, fullText.length], {
  extrapolateRight: 'clamp',
}));
return <div>{fullText.slice(0, charCount)}</div>;
```

---

## Timing Guide (at 30fps)

| Duration | Frames | Use For |
|----------|--------|---------|
| 100ms | 3 | Button press |
| 150ms | 5 | Hover state |
| 200ms | 6 | Fast transition |
| 300ms | 9 | Normal transition |
| 500ms | 15 | Element entry |
| 1s | 30 | Slow emphasis |

---

## Transitions Between Scenes

```tsx
import { Sequence, useCurrentFrame, interpolate } from 'remotion';

const SCENE_1_END = 90;
const FADE_DURATION = 15;

const TransitionDemo = () => {
  const frame = useCurrentFrame();
  
  // Fade out Scene 1 over last 15 frames
  const scene1Opacity = interpolate(
    frame,
    [SCENE_1_END - FADE_DURATION, SCENE_1_END],
    [1, 0],
    { extrapolateLeft: 'clamp', extrapolateRight: 'clamp' }
  );
  
  // Fade in Scene 2 from frame 90
  const scene2Opacity = interpolate(
    frame,
    [SCENE_1_END, SCENE_1_END + FADE_DURATION],
    [0, 1],
    { extrapolateLeft: 'clamp', extrapolateRight: 'clamp' }
  );

  return (
    <>
      <div style={{ opacity: scene1Opacity, position: 'absolute' }}>Scene 1</div>
      <div style={{ opacity: scene2Opacity, position: 'absolute' }}>Scene 2</div>
    </>
  );
};
```
