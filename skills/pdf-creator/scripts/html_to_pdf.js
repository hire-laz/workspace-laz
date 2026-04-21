#!/usr/bin/env node
/**
 * html_to_pdf.js — Convert a local HTML file to PDF using Playwright
 *
 * Usage:
 *   node html_to_pdf.js <input.html> <output.pdf> [--format A4] [--margin 12px] [--landscape]
 *
 * Spins up a local HTTP server so Google Fonts and relative assets load correctly,
 * then renders to PDF with Chrome's header/footer suppressed.
 *
 * ⚠️  GOTCHA: DO NOT use --print-to-pdf-no-header with google-chrome CLI —
 *     it still prints the localhost URL in the footer. Use this script instead,
 *     which uses playwright's page.pdf({ displayHeaderFooter: false }).
 */

const http = require("http");
const fs = require("fs");
const path = require("path");

// Dynamically detect playwright-core location
let playwrightPath;
try {
  // Try to find it via require.resolve (works if node_modules is properly linked)
  playwrightPath = require.resolve("playwright-core");
} catch (e) {
  // Fallback: check common OpenClaw installation paths
  const nvm = path.join(process.env.HOME || "/root", ".nvm/versions/node");
  const nodeVersions = fs.existsSync(nvm) ? fs.readdirSync(nvm) : [];
  const nodeVersion = nodeVersions.length > 0 ? nodeVersions[nodeVersions.length - 1] : null;
  
  if (nodeVersion) {
    playwrightPath = path.join(nvm, nodeVersion, "lib/node_modules/openclaw/node_modules/playwright-core");
  } else {
    console.error("Error: Could not find playwright-core. Make sure OpenClaw is installed.");
    process.exit(1);
  }
}

const { chromium } = require(playwrightPath);

const args = process.argv.slice(2);
const inputFile = args[0];
const outputFile = args[1] || inputFile.replace(/\.html$/, ".pdf");
const format = args.find((a) => a.startsWith("--format="))?.split("=")[1] || "A4";
const landscape = args.includes("--landscape");
const margin = args.find((a) => a.startsWith("--margin="))?.split("=")[1] || "12px";

if (!inputFile) {
  console.error("Usage: node html_to_pdf.js <input.html> [output.pdf] [--format A4] [--margin 12px] [--landscape]");
  process.exit(1);
}

const inputDir = path.dirname(path.resolve(inputFile));
const inputFilename = path.basename(inputFile);
const PORT = 19800 + Math.floor(Math.random() * 200); // avoid collisions

// Minimal static file server for the input directory
const server = http.createServer((req, res) => {
  const filePath = path.join(inputDir, decodeURIComponent(req.url.split("?")[0]));
  fs.readFile(filePath, (err, data) => {
    if (err) { res.writeHead(404); res.end(); return; }
    const ext = path.extname(filePath).toLowerCase();
    const mime = { 
      ".html": "text/html", 
      ".css": "text/css", 
      ".js": "application/javascript", 
      ".png": "image/png", 
      ".jpg": "image/jpeg", 
      ".jpeg": "image/jpeg",
      ".gif": "image/gif",
      ".svg": "image/svg+xml", 
      ".woff": "font/woff", 
      ".woff2": "font/woff2",
      ".ttf": "font/ttf",
      ".otf": "font/otf"
    }[ext] || "application/octet-stream";
    res.writeHead(200, { "Content-Type": mime });
    res.end(data);
  });
});

(async () => {
  await new Promise((r) => server.listen(PORT, "127.0.0.1", r));

  // Try system Chrome first, fallback to agent-browser
  let chromePath = "/usr/bin/google-chrome";
  if (!fs.existsSync(chromePath)) {
    chromePath = path.join(process.env.HOME || "/root", ".agent-browser/browsers/chrome-147.0.7727.57/chrome");
  }
  
  const browser = await chromium.launch({
    executablePath: chromePath,
    args: ["--no-sandbox", "--disable-setuid-sandbox"],
  });

  const page = await browser.newPage();
  await page.goto(`http://127.0.0.1:${PORT}/${inputFilename}`, {
    waitUntil: "networkidle",
    timeout: 30000,
  });

  await page.pdf({
    path: outputFile,
    format,
    landscape,
    printBackground: true,
    displayHeaderFooter: false,   // ← CRITICAL: kills the localhost URL footer
    margin: { top: margin, bottom: margin, left: margin, right: margin },
  });

  await browser.close();
  server.close();

  const size = (fs.statSync(outputFile).size / 1024).toFixed(0);
  console.log(`✓ PDF written: ${outputFile} (${size} KB)`);
})().catch((e) => {
  server.close();
  console.error("Error:", e.message);
  process.exit(1);
});
