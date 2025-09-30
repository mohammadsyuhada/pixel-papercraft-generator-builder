let requireImage = id => Generator.requireImage("./images/" ++ id ++ ".png")
let requireTexture = id => Generator.requireImage("./textures/" ++ id ++ ".png")

// Scale factor for 300 DPI (2480x3508) vs 72 DPI (595x842)
let scaleFactor = 2480.0 /. 595.0 // ≈ 4.167

// Helper function to scale coordinates
let scale = (value: int): int => Belt.Float.toInt(Belt.Int.toFloat(value) *. scaleFactor)
let scaleFloat = (value: float): float => value *. scaleFactor

let id = "minecraft-character"

let name = "Minecraft Character"

let history = [
  "01 Feb 2015 gootube2000 - First release.",
  "05 Feb 2015 gootube2000 - Fixed orientation of the hands, feet and under the head.",
  "13 Feb 2015 lostminer - Update to use new version of generator.",
  "20 Feb 2015 lostminer - Make background non-transparent.",
  "02 Oct 2020 NinjolasNJM - Combined Steve and Alex Generators into one.",
  "27 May 2021 lostminer - Convert to ReScript generator.",
  "17 Jul 2021 M16 - Updated generator photo.",
  "27 May 2022 NinjolasNJM - Made folds drawn using drawFolds, and parts drawn using drawCuboid, and added title",
  "12 Jun 2022 NinjolasNJM - Updated to use new Minecraft module",
]

let thumbnail: Generator.thumnbnailDef = {
  url: Generator.requireImage("./thumbnail/v2-thumbnail-256.jpeg"),
}

let instructions = `
## How to use the Minecraft Character Generator?

1. Select your Minecraft skin file.
2. Choose the your Minecraft skin file model type.
3. Download and print your character papercraft.
`

let images: array<Generator.imageDef> = [
  {id: "Background", url: requireImage("Background")},
  {id: "SteveTabs", url: requireImage("SteveTabs")},
  {id: "SteveFolds", url: requireImage("SteveFolds")},
  {id: "AlexTabs", url: requireImage("AlexTabs")},
  {id: "AlexFolds", url: requireImage("AlexFolds")},
  {id: "Labels", url: requireImage("Labels")},
]

let textures: array<Generator.textureDef> = [
  {
    id: "Skin",
    url: requireTexture("SkinSteve64x64"),
    standardWidth: 64,
    standardHeight: 64,
  },
  {
    id: "Steve",
    url: requireTexture("SkinSteve64x64"),
    standardWidth: 64,
    standardHeight: 64,
  },
  {
    id: "Alex",
    url: requireTexture("SkinAlex64x64"),
    standardWidth: 64,
    standardHeight: 64,
  },
]

let steve = Minecraft.Character.steve
let alex = Minecraft.Character.alex

let script = () => {
  // Inputs

  Generator.defineTextureInput(
    "Skin",
    {
      standardWidth: 64,
      standardHeight: 64,
      choices: ["Steve", "Alex"],
    },
  )
  Generator.defineSelectInput("Skin Model", ["Steve", "Alex"])
  Generator.defineBooleanInput("Show Folds", true)
  // Generator.defineBooleanInput("Show Labels", false)
  Generator.defineText(
    "Click in the papercraft template to turn on and off the overlay for each part.",
  )

  // Draw

  let isAlexModel = Generator.getSelectInputValue("Skin Model") === "Alex"

  let showFolds = Generator.getBooleanInputValue("Show Folds")
  // let showLabels = Generator.getBooleanInputValue("Show Labels")
  let showLabels = false

  let showHeadOverlay = Generator.getBooleanInputValueWithDefault("Show Head Overlay", true)
  let showBodyOverlay = Generator.getBooleanInputValueWithDefault("Show Body Overlay", true)
  let showLeftArmOverlay = Generator.getBooleanInputValueWithDefault("Show Left Arm Overlay", true)
  let showRightArmOverlay = Generator.getBooleanInputValueWithDefault(
    "Show Right Arm Overlay",
    true,
  )
  let showLeftLegOverlay = Generator.getBooleanInputValueWithDefault("Show Left Leg Overlay", true)
  let showRightLegOverlay = Generator.getBooleanInputValueWithDefault(
    "Show Right Leg Overlay",
    true,
  )

  let char = isAlexModel ? alex : steve

  let drawHead = ((ox, oy): Generator_Builder.position) => {
    let headScale = (scale(64), scale(64), scale(64))
    Minecraft.drawCuboid("Skin", char.base.head, (ox, oy), headScale, ())

    // Always draw head overlay below the base head
    // let overlayBelowY = oy + scale(192) + scale(10) // Add small gap
    // Minecraft.drawCuboid("Skin", char.overlay.head, (ox, overlayBelowY), headScale, ())

    // Conditionally draw additional overlay on top of the base head
    if showHeadOverlay {
      Minecraft.drawCuboid("Skin", char.overlay.head, (ox, oy), headScale, ())
    }
    /* if showFolds {
      Generator.drawFoldLineCuboid((ox, oy), headScale, ())
    } */
  }

  let drawBody = ((ox, oy): Generator_Builder.position) => {
    let scale = (scale(64), scale(96), scale(32))
    Minecraft.drawCuboid("Skin", char.base.body, (ox, oy), scale, ())
    if showBodyOverlay {
      Minecraft.drawCuboid("Skin", char.overlay.body, (ox, oy), scale, ())
    }
    /* if showFolds {
      Generator.drawFoldLineCuboid((ox, oy), scale, ())
    } */
  }

  let drawRightArm = ((ox, oy): Generator_Builder.position) => {
    let scale = char == alex ? (scale(24), scale(96), scale(32)) : (scale(32), scale(96), scale(32))
    Minecraft.drawCuboid("Skin", char.base.rightArm, (ox, oy), scale, ())
    if showRightArmOverlay {
      Minecraft.drawCuboid("Skin", char.overlay.rightArm, (ox, oy), scale, ())
    }
    /* if showFolds {
      Generator.drawFoldLineCuboid((ox, oy), scale, ())
    } */
  }
  let drawLeftArm = ((ox, oy): Generator_Builder.position) => {
    let scale = char == alex ? (scale(24), scale(96), scale(32)) : (scale(32), scale(96), scale(32))
    Minecraft.drawCuboid("Skin", char.base.leftArm, (ox, oy), scale, ~direction=#West, ())
    if showLeftArmOverlay {
      Minecraft.drawCuboid("Skin", char.overlay.leftArm, (ox, oy), scale, ~direction=#West, ())
    }
    /* if showFolds {
      Generator.drawFoldLineCuboid((ox, oy), scale, ~direction=#West, ())
    } */
  }
  let drawRightLeg = ((ox, oy): Generator_Builder.position) => {
    let scale = (scale(32), scale(96), scale(32))
    Minecraft.drawCuboid("Skin", char.base.rightLeg, (ox, oy), scale, ())
    if showRightLegOverlay {
      Minecraft.drawCuboid("Skin", char.overlay.rightLeg, (ox, oy), scale, ())
    }
    /* if showFolds {
      Generator.drawFoldLineCuboid((ox, oy), scale, ())
    } */
  }
  let drawLeftLeg = ((ox, oy): Generator_Builder.position) => {
    let scale = (scale(32), scale(96), scale(32))
    Minecraft.drawCuboid("Skin", char.base.leftLeg, (ox, oy), scale, ~direction=#West, ())
    if showLeftLegOverlay {
      Minecraft.drawCuboid("Skin", char.overlay.leftLeg, (ox, oy), scale, ~direction=#West, ())
    }
    /* if showFolds {
      Generator.drawFoldLineCuboid((ox, oy), scale, ~direction=#West, ())
    } */
  }

  let drawFolds = () => {
    if isAlexModel {
      Generator.drawImage("AlexFolds", (0, 0))
    } else {
      Generator.drawImage("SteveFolds", (0, 0))
    }

    // Later replace with drawLineFold functions
  }

  // Background

  Generator.drawImage("Background", (0, 0))

  if isAlexModel {
    Generator.drawImage("AlexTabs", (0, 0))
  } else {
    Generator.drawImage("SteveTabs", (0, 0))
  }

  // Head

  let (ox, oy) = (scale(85), scale(291))

  drawHead((ox, oy))

  // Define region input to cover base head and the always-visible overlay below
  let regionHeight = scale(192) // Base head + gap + overlay below
  Generator.defineRegionInput((ox, oy, scale(256), regionHeight), () => {
    Generator.setBooleanInputValue("Show Head Overlay", !showHeadOverlay)
  })

  // Body

  let (ox, oy) = (scale(116), scale(512))

  drawBody((ox, oy))
  Generator.defineRegionInput((ox, oy, scale(192), scale(160)), () => {
    Generator.setBooleanInputValue("Show Body Overlay", !showBodyOverlay)
  })

  // Arms

  // Right Arm

  let (ox, oy) = (isAlexModel ? scale(107) : scale(404), scale(68))

  drawRightArm((ox, oy))
  Generator.defineRegionInput((ox, oy, isAlexModel ? scale(112) : scale(128), scale(160)), () => {
    Generator.setBooleanInputValue("Show Right Arm Overlay", !showRightArmOverlay)
  })

  // Left Arm

  let (ox, oy) = (isAlexModel ? scale(400) : scale(379), scale(251))

  drawLeftArm((ox, oy))
  Generator.defineRegionInput((ox, oy, isAlexModel ? scale(112) : scale(128), scale(166)), () => {
    Generator.setBooleanInputValue("Show Left Arm Overlay", !showLeftArmOverlay)
  })

  // Right Leg

  let (ox, oy) = (scale(404), scale(434))

  drawRightLeg((ox, oy))
  Generator.defineRegionInput((ox, oy, scale(128), scale(160)), () => {
    Generator.setBooleanInputValue("Show Right Leg Overlay", !showRightLegOverlay)
  })

  // Left Leg

  let (ox, oy) = (scale(380), scale(616))

  drawLeftLeg((ox, oy))
  Generator.defineRegionInput((ox, oy, scale(128), scale(160)), () => {
    Generator.setBooleanInputValue("Show Left Leg Overlay", !showLeftLegOverlay)
  })

  // Folds

  if showFolds {
    drawFolds()
  }

  // Labels

  if showLabels {
    Generator.drawImage("Labels", (0, 0))
  }
}

let generator: Generator.generatorDef = {
  id,
  name,
  history,
  thumbnail: Some(thumbnail),
  video: None,
  instructions: Some(<Generator.Markdown> {instructions} </Generator.Markdown>),
  images,
  textures,
  script,
}
