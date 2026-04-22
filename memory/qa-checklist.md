# QA Checklist — Before Delivering

**CRITICAL:** Always test work yourself before sending to Cho. Don't assume it works.

## For Websites (Next.js)
- [ ] **Port check** — Confirm running on the correct port (default is 3000, specify PORT=3001 if needed)
- [ ] **Images load** — Take a screenshot, verify images render (not broken links)
- [ ] **Form inputs work** — Fill out a test form, submit doesn't error
- [ ] **Links navigate** — Click 2-3 links, verify no 404s
- [ ] **Mobile responsive** — Screenshot on mobile viewport (1366x768 desktop, then test mobile)
- [ ] **No console errors** — Check browser console for JS errors
- [ ] **Load time** — Page should load in <3 seconds

## For Slides (PDF)
- [ ] **No cutoff** — Check last slide isn't cut off (margin:0 + page-break-after:always)
- [ ] **Images render** — All images should be visible, not broken
- [ ] **Typography readable** — Text should be readable at normal size
- [ ] **Fonts load** — Custom fonts should render correctly
- [ ] **Export works** — PDF should open in any PDF reader without errors

## For Design Work (Prototypes, Animations)
- [ ] **Functionality** — Test all interactive elements (buttons, forms, navigation)
- [ ] **Animation smooth** — Motion should be fluid, no janky frames
- [ ] **Export works** — Download/export files are correct format and size
- [ ] **Branding** — Verify colors, logos, fonts match the brief
- [ ] **No broken links** — Test all navigation paths

## General Rule
**Screenshot + test locally first. Catch issues before they reach Cho.** If Cho has to report broken images or forms, that's a miss on my side.

---

**Applied 2026-04-22 to nutrikaizen-waitlist site after Cho reported images not loading. Root cause: app was serving on port 3000, not 3001. Always use explicit PORT= when deploying.**
