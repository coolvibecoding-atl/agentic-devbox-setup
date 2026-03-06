#!/usr/bin/env node
/**
 * GLTF Draco Compressor - Phase 19 Advanced 3D Web Integration
 * Wraps gltf-pipeline to automatically compress raw Blender GLBs.
 */
const { execSync } = require('child_process');
const path = require('path');
const fs = require('fs');

const inputPath = process.argv[2];
if (!inputPath) {
    console.error("Usage: node gltf-draco-compressor.js <input.glb>");
    process.exit(1);
}

const dir = path.dirname(inputPath);
const ext = path.extname(inputPath);
const base = path.basename(inputPath, ext);
const outputPath = path.join(dir, `${base}-draco${ext}`);

console.log(`[Draco Compression] Starting compression on ${inputPath}...`);
try {
    // Requires gltf-pipeline to be installed globally
    const out = execSync(`gltf-pipeline -i "${inputPath}" -o "${outputPath}" -d --draco.compressionLevel 7`);

    const originalSize = fs.statSync(inputPath).size / 1024 / 1024;
    const newSize = fs.statSync(outputPath).size / 1024 / 1024;

    console.log(out.toString());
    console.log(`✅ [Draco Compression] Success!`);
    console.log(`Original: ${originalSize.toFixed(2)} MB`);
    console.log(`Compressed: ${newSize.toFixed(2)} MB`);
    console.log(`Reduction: ${((1 - newSize / originalSize) * 100).toFixed(1)}%`);
} catch (e) {
    console.error(`❌ [Draco Compression] Failed: ${e.message}`);
}
