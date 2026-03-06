#!/usr/bin/env node
/**
 * R3F Architect - Phase 19 Advanced 3D Web Integration
 * Automatically generates a React Three Fiber boilerplate for a given GLB.
 */
const fs = require('fs');
const path = require('path');

const args = process.argv.slice(2);
const glbPath = args[0];
const outputComponent = args[1];

if (!glbPath || !outputComponent) {
    console.error("Usage: node r3f-architect.js <path-to-input.glb> <OutputComponentName.tsx>");
    process.exit(1);
}

const componentName = path.basename(outputComponent, '.tsx');

const boilerplate = `
import React, { useRef } from 'react';
import { Canvas, useFrame } from '@react-three/fiber';
import { useGLTF, Environment, ContactShadows } from '@react-three/drei';

export function ${componentName}Model(props) {
  const { nodes, materials } = useGLTF('${glbPath}');
  const modelRef = useRef();

  useFrame((state) => {
    if (modelRef.current) {
      modelRef.current.rotation.y = state.clock.elapsedTime * 0.1;
    }
  });

  return (
    <group {...props} dispose={null} ref={modelRef}>
      {/* Auto-injected primitive hook. Ensure you log nodes/materials to map specific meshes if needed. */}
      <primitive object={Object.values(nodes).find(n => n.type === 'Group' || n.type === 'Mesh') || nodes.Scene} />
    </group>
  );
}

export default function ${componentName}Canvas() {
  return (
    <div className="w-full h-full min-h-screen">
      <Canvas camera={{ position: [0, 0, 5], fov: 50 }}>
        <ambientLight intensity={0.5} />
        <spotLight position={[10, 10, 10]} angle={0.15} penumbra={1} />
        <Environment preset="city" />
        <${componentName}Model />
        <ContactShadows position={[0, -1, 0]} opacity={0.4} scale={10} blur={2} far={4} />
      </Canvas>
    </div>
  );
}

useGLTF.preload('${glbPath}');
`;

fs.writeFileSync(outputComponent, boilerplate);
console.log(`✅ [R3F Architect] Successfully generated R3F component: ${outputComponent}`);
