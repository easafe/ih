module Renderer.Colors

import SDL.Types
import Data.Nat

%auto_implicit_depth 256
export
black : SDLColor
black = RGBA 0 0 0 255

export
gray : SDLColor
gray = RGBA 220 220 220 255

export
red : SDLColor
red = RGBA 225 0 0 255

export
blue : SDLColor
blue = RGBA 0 0 128 255

export
dimgray : SDLColor
dimgray = RGBA 105 105 105 255

export
green : SDLColor
green = RGBA 0 128 0 255

export
brown : SDLColor
brown = RGBA 210 105 30 255
%auto_implicit_depth 50