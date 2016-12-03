#version 150
// Copyright 2015, Christopher J. Foster and the other displaz contributors.
// Use of this code is governed by the BSD-style license found in LICENSE.txt

// Draws billboards, which are textured quads that always face the camera,
// arent't obscured by other objects, and don't shrink when they're further
// away.

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform mat4 modelViewProjectionMatrix;
uniform vec2 billboardSize; // In pixels
uniform vec2 viewportSize; // In pixels

//------------------------------------------------------------------------------
#if defined(VERTEX_SHADER)

in vec2 position;
in vec2 texCoord;

out vec2 ftexCoord;

void main()
{
    gl_Position = modelViewProjectionMatrix * vec4(0, 0, 0, 1.0);
    gl_Position /= gl_Position.w;
    gl_Position.xy += position * billboardSize / viewportSize * 2;
    ftexCoord = texCoord;
}


//------------------------------------------------------------------------------
#elif defined(FRAGMENT_SHADER)

uniform sampler2D texture0;

in vec2 ftexCoord;

// Output fragment color
out vec4 fragColor;

void main()
{
    fragColor = texture(texture0, vec2(ftexCoord));
}

#endif
