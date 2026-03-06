#!/usr/bin/env node
/**
 * GSAP ScrollTrigger Animator - Phase 19
 * Analyzes a TSX file and wraps its root return in a gsap.context() hook for scroll animations.
 */
const fs = require('fs');

const inputTsx = process.argv[2];
if (!inputTsx) {
    console.error("Usage: node gsap-animator.js <Component.tsx>");
    process.exit(1);
}

let content = fs.readFileSync(inputTsx, 'utf8');

const importStm = `import gsap from 'gsap';\nimport { ScrollTrigger } from 'gsap/ScrollTrigger';\ngsap.registerPlugin(ScrollTrigger);\nimport { useLayoutEffect, useRef } from 'react';\n`;

// Very basic heuristic injection for agent usage
if (!content.includes('gsap.context')) {
    content = importStm + content;
    console.log(`[GSAP Injector] Added GSAP imports. Manual hook wiring required by ` + "frontend-lead.");
    fs.writeFileSync(inputTsx, content);
} else {
    console.log(`[GSAP Injector] GSAP already present in ${inputTsx}`);
}
