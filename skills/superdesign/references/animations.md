# Animations & Micro-interactions

## Timing Reference

| Animation | Duration | Easing | Use Case |
|-----------|----------|--------|----------|
| Button press | 100-150ms | ease-out | Click feedback |
| Hover state | 150-200ms | ease | Color/shadow shifts |
| Element entry | 300-500ms | ease-out | Fade/slide in on load |
| Page transition | 300-400ms | ease-in-out | Route changes |
| Menu open | 200-300ms | ease-out | Dropdowns |
| Toast/notification | 350ms in, 250ms out | ease-out | Alerts |

---

## Micro-Syntax (Animation Planning)

Plan animations before coding:

```
button:    150ms [S1→0.95→1] press        ← scale effect on click
hover:     200ms [Y0→-2px, shadow↗]       ← lift on hover
fade-in:   400ms ease-out [α0→1]          ← opacity fade
slide-in:  350ms ease-out [X-100→0, α0→1] ← slide from left
bounce:    600ms [S0.95→1.05→1]           ← scale bounce
rotate:    200ms [R0→180deg]               ← icon rotation
```

---

## CSS Animations

### Fade In

```css
@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

.fade-in {
  animation: fadeIn 400ms ease-out forwards;
}
```

### Slide In from Bottom

```css
@keyframes slideUp {
  from { transform: translateY(20px); opacity: 0; }
  to { transform: translateY(0); opacity: 1; }
}

.slide-up {
  animation: slideUp 350ms ease-out forwards;
}
```

### Scale Pop (Elements entering)

```css
@keyframes scalePop {
  0% { transform: scale(0.8); opacity: 0; }
  70% { transform: scale(1.05); opacity: 1; }
  100% { transform: scale(1); }
}

.scale-pop {
  animation: scalePop 300ms cubic-bezier(0.34, 1.56, 0.64, 1) forwards;
}
```

### Shake (Error State)

```css
@keyframes shake {
  0%, 100% { transform: translateX(0); }
  25% { transform: translateX(-8px); }
  75% { transform: translateX(8px); }
}

.shake {
  animation: shake 400ms ease-in-out;
}
```

### Pulse (Attention)

```css
@keyframes pulse {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.05); }
}

.pulse {
  animation: pulse 2s ease-in-out infinite;
}
```

### Spinner

```css
@keyframes spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

.spinner {
  animation: spin 600ms linear infinite;
  border: 3px solid oklch(0.9 0 0);
  border-top-color: oklch(0.5 0.18 25);
  border-radius: 50%;
  width: 24px;
  height: 24px;
}
```

---

## CSS Transitions (Hover/Interactive)

### Button

```css
.button {
  background: var(--primary);
  transform: translateY(0);
  box-shadow: 0 2px 8px oklch(0.15 0.1 25 / 0.2);
  transition: all 150ms ease-out;
}

.button:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px oklch(0.15 0.1 25 / 0.3);
}

.button:active {
  transform: translateY(0) scale(0.97);
  box-shadow: 0 1px 4px oklch(0.15 0.1 25 / 0.2);
}
```

### Card Hover

```css
.card {
  box-shadow: 0 2px 8px rgba(0,0,0,0.08);
  transition: transform 200ms ease, box-shadow 200ms ease;
}

.card:hover {
  transform: translateY(-4px);
  box-shadow: 0 12px 32px rgba(0,0,0,0.12);
}
```

### Link Underline (Animated)

```css
.link {
  position: relative;
  text-decoration: none;
}

.link::after {
  content: '';
  position: absolute;
  bottom: -2px;
  left: 0;
  width: 0;
  height: 2px;
  background: var(--primary);
  transition: width 200ms ease;
}

.link:hover::after {
  width: 100%;
}
```

### Input Focus

```css
.input {
  border: 1px solid var(--border);
  outline: none;
  transition: border-color 150ms, box-shadow 150ms;
}

.input:focus {
  border-color: var(--primary);
  box-shadow: 0 0 0 3px oklch(0.6 0.18 25 / 0.15);
}
```

---

## JavaScript Animation (Intersection Observer)

Animate elements when they enter viewport:

```js
const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.classList.add('animate');
      observer.unobserve(entry.target); // Only animate once
    }
  });
}, { threshold: 0.1 });

document.querySelectorAll('.animate-on-scroll').forEach(el => observer.observe(el));
```

```css
.animate-on-scroll {
  opacity: 0;
  transform: translateY(20px);
  transition: opacity 400ms ease-out, transform 400ms ease-out;
}

.animate-on-scroll.animate {
  opacity: 1;
  transform: translateY(0);
}
```

---

## Stagger (Multiple Elements)

```css
/* Add delay to each child */
.list-item:nth-child(1) { animation-delay: 0ms; }
.list-item:nth-child(2) { animation-delay: 80ms; }
.list-item:nth-child(3) { animation-delay: 160ms; }
.list-item:nth-child(4) { animation-delay: 240ms; }
```

Or with JS:
```js
document.querySelectorAll('.list-item').forEach((el, i) => {
  el.style.animationDelay = `${i * 80}ms`;
});
```

---

## Rules

✅ Keep animations subtle and purposeful
✅ Use ease-out for entries (feels natural)
✅ Use ease-in for exits
✅ Use ease-in-out for transitions between states
✅ Respect `prefers-reduced-motion`

```css
@media (prefers-reduced-motion: reduce) {
  * { animation: none !important; transition: none !important; }
}
```

❌ Don't animate too many things at once
❌ Don't use linear easing (feels mechanical)
❌ Don't animate layout properties (width, height, top, left) — use transform
❌ Avoid animations > 600ms (feels sluggish)
