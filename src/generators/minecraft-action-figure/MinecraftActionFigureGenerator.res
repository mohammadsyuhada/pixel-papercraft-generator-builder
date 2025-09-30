let requireImage = id => Generator.requireImage("./images/" ++ id ++ ".png")
let requireTexture = id => Generator.requireImage("./textures/" ++ id ++ ".png")

// Scale factor for 300 DPI (2480x3508) vs 72 DPI (595x842)
let scaleFactor = 2480.0 /. 595.0 // ≈ 4.167

// Helper function to scale coordinates
let scale = (value: int): int => Belt.Float.toInt(Belt.Int.toFloat(value) *. scaleFactor)
let scaleFloat = (value: float): float => value *. scaleFactor

let id = "minecraft-action-figure"

let name = "Minecraft Action Figure"

let history = [
  "16 Aug 2020 NinjolasNJM - Initial script finished.",
  "03 Oct 2020 NinjolasNJM - Added Alex support and Hand Notches.",
  "09 Oct 2020 NinjolasNJM - Tweaked pelvis, bottom of body and leg height.",
  "24 Feb 2021 NinjolasNJM - Moved pelvis so that the leg's pivot point is accurate to the game, changed leg height accordingly.",
  "06 Jun 2021 NinjolasNJM - Converted to ReScript generator.",
]

let thumbnail: Generator.thumnbnailDef = {
  url: Generator.requireImage("./thumbnail/thumbnail-256.jpeg"),
}

let imageIds = ["Backgroundalex", "Backgroundsteve", "Foldsalex", "Foldssteve", "Labels", "Notch"]
let toImageDef = (id): Generator.imageDef => {id: id, url: requireImage(id)}
let images: array<Generator.imageDef> = imageIds->Js.Array2.map(toImageDef)

let textures: array<Generator.textureDef> = [
  {
    id: "Skin",
    url: requireTexture("Skin64x64Steve"),
    standardWidth: 64,
    standardHeight: 64,
  },
]

let script = () => {
  // Define user inputs
  Generator.defineSelectInput("Skin Model Type", ["Steve", "Alex"])
  Generator.defineTextureInput("Skin", {standardWidth: 64, standardHeight: 64, choices: []})

  // Define user variables
  Generator.defineBooleanInput("Hand Notches", false)
  //Generator.defineBooleanInput("Show Overlay", true)
  Generator.defineBooleanInput("Show Folds", true)
  Generator.defineBooleanInput("Show Labels", true)

  // Get user variable values
  let alexModel = Generator.getSelectInputValue("Skin Model Type") === "Alex"

  let handNotches = Generator.getBooleanInputValue("Hand Notches")

  let showFolds = Generator.getBooleanInputValue("Show Folds")
  let showLabels = Generator.getBooleanInputValue("Show Labels")
  //let showOverlay = Generator.getBooleanInputValue("Show Overlay")

  let hideHelmet = Generator.getBooleanInputValue("Hide Helmet")
  let hideJacket = Generator.getBooleanInputValue("Hide Jacket")
  let hideLeftSleeve = Generator.getBooleanInputValue("Hide Left Sleeve")
  let hideRightSleeve = Generator.getBooleanInputValue("Hide Right Sleeve")
  let hideLeftPant = Generator.getBooleanInputValue("Hide Left Pant")
  let hideRightPant = Generator.getBooleanInputValue("Hide Right Pant")

  // Define regions
  Generator.defineRegionInput((scale(10), scale(534), scale(192), scale(256)), () => {
    Generator.setBooleanInputValue("Hide Helmet", !hideHelmet)
  })
  Generator.defineRegionInput((scale(35), scale(50), scale(192), scale(144)), () => {
    Generator.setBooleanInputValue("Hide Jacket", !hideJacket)
  })
  Generator.defineRegionInput((scale(265), scale(211), scale(128), scale(160)), () => {
    Generator.setBooleanInputValue("Hide Left Sleeve", !hideLeftSleeve)
  })
  Generator.defineRegionInput((scale(425), scale(587), scale(128), scale(160)), () => {
    Generator.setBooleanInputValue("Hide Right Sleeve", !hideRightSleeve)
  })
  Generator.defineRegionInput((scale(425), scale(162), scale(128), scale(208)), () => {
    Generator.setBooleanInputValue("Hide Left Pant", !hideLeftPant)
  })
  Generator.defineRegionInput((scale(265), scale(538), scale(128), scale(208)), () => {
    Generator.setBooleanInputValue("Hide Right Pant", !hideRightPant)
  })

  // Head
  Generator.drawTextureLegacy(
    "Skin",
    {x: 0, y: 8, w: 8, h: 8},
    {x: scale(74), y: scale(790), w: scale(64), h: scale(64)},
    ~rotateLegacy=-90.0,
    (),
  ) // Right
  Generator.drawTextureLegacy(
    "Skin",
    {x: 8, y: 8, w: 8, h: 8},
    {x: scale(74), y: scale(726), w: scale(64), h: scale(64)},
    ~rotateLegacy=-90.0,
    (),
  ) // Face
  Generator.drawTextureLegacy(
    "Skin",
    {x: 16, y: 8, w: 8, h: 8},
    {x: scale(74), y: scale(662), w: scale(64), h: scale(64)},
    ~rotateLegacy=-90.0,
    (),
  ) // Left
  Generator.drawTextureLegacy(
    "Skin",
    {x: 24, y: 8, w: 8, h: 8},
    {x: scale(74), y: scale(598), w: scale(64), h: scale(64)},
    ~rotateLegacy=-90.0,
    (),
  ) // Back
  Generator.drawTextureLegacy(
    "Skin",
    {x: 8, y: 0, w: 8, h: 8},
    {x: scale(10), y: scale(726), w: scale(64), h: scale(64)},
    ~rotateLegacy=-90.0,
    (),
  ) // Top
  Generator.drawTextureLegacy(
    "Skin",
    {x: 16, y: 0, w: 8, h: 8},
    {x: scale(138), y: scale(726), w: scale(64), h: scale(64)},
    ~rotateLegacy=-90.0,
    ~flip=#Vertical,
    (),
  ) // Bot

  //Neck
  Generator.drawTextureLegacy("Skin", {x: 16, y: 0, w: 8, h: 8}, {x: scale(36), y: scale(414), w: scale(64), h: scale(96)}, ()) // Bot

  //Pelvis
  Generator.drawTextureLegacy(
    "Skin",
    {x: 20, y: 48, w: 4, h: 4},
    {x: scale(163), y: scale(380), w: scale(32), h: scale(130)},
    (),
  ) // Left Pelvis
  Generator.drawTextureLegacy(
    "Skin",
    {x: 4, y: 16, w: 4, h: 4},
    {x: scale(131), y: scale(380), w: scale(32), h: scale(130)},
    (),
  ) // Right Pelvis

  //Body
  Generator.drawTextureLegacy(
    "Skin",
    {x: 16, y: 16, w: 24, h: 16},
    {x: scale(35), y: scale(50), w: scale(192), h: scale(128)},
    (),
  ) // Body
  Generator.drawTextureLegacy("Skin", {x: 0, y: 20, w: 4, h: 4}, {x: scale(35), y: scale(178), w: scale(32), h: scale(32)}, ()) // Right hip
  Generator.drawTextureLegacy(
    "Skin",
    {x: 24, y: 52, w: 4, h: 4},
    {x: scale(131), y: scale(178), w: scale(32), h: scale(32)},
    (),
  ) // Left hip
  Generator.drawTextureLegacy(
    "Skin",
    {x: 28, y: 16, w: 8, h: 4},
    {x: scale(67), y: scale(178), w: scale(64), h: scale(32)},
    ~flip=#Vertical,
    (),
  ) // Bot

  // Arms

  if alexModel {
    //Left Arm
    Generator.drawTextureLegacy(
      "Skin",
      {x: 39, y: 48, w: 3, h: 4},
      {x: scale(329), y: scale(338), w: scale(24), h: scale(32)},
      ~flip=#Vertical,
      (),
    ) //Left Hand
    Generator.drawTextureLegacy(
      "Skin",
      {x: 32, y: 48, w: 11, h: 16},
      {x: scale(297), y: scale(211), w: scale(88), h: scale(128)},
      (),
    ) //Left arm
    Generator.drawTextureLegacy(
      "Skin",
      {x: 43, y: 52, w: 3, h: 12},
      {x: scale(273), y: scale(243), w: scale(24), h: scale(96)},
      (),
    ) //Back Left Arm
    Generator.drawTextureLegacy(
      "Skin",
      {x: 32, y: 52, w: 4, h: 4},
      {x: scale(297), y: scale(121), w: scale(32), h: scale(32)},
      (),
    ) //Left Shoulder
    Generator.drawTextureLegacy(
      "Skin",
      {x: 32, y: 52, w: 4, h: 4},
      {x: scale(297), y: scale(86), w: scale(32), h: scale(32)},
      (),
    ) //Left Shoulder Inside

    //Right Arm
    Generator.drawTextureLegacy(
      "Skin",
      {x: 47, y: 16, w: 3, h: 4},
      {x: scale(465), y: scale(714), w: scale(24), h: scale(32)},
      ~flip=#Vertical,
      (),
    ) //Right Hand
    Generator.drawTextureLegacy(
      "Skin",
      {x: 40, y: 16, w: 14, h: 16},
      {x: scale(433), y: scale(587), w: scale(112), h: scale(128)},
      (),
    ) //Right Arm
    Generator.drawTextureLegacy(
      "Skin",
      {x: 47, y: 20, w: 4, h: 4},
      {x: scale(489), y: scale(496), w: scale(32), h: scale(32)},
      (),
    ) //Right Shoulder
    Generator.drawTextureLegacy(
      "Skin",
      {x: 47, y: 20, w: 4, h: 4},
      {x: scale(489), y: scale(462), w: scale(32), h: scale(32)},
      (),
    ) //Right Shoulder Inside
  } else {
    //Left Arm
    Generator.drawTextureLegacy(
      "Skin",
      {x: 40, y: 48, w: 4, h: 4},
      {x: 329, y: 338, w: 32, h: 32},
      ~flip=#Vertical,
      (),
    ) //Left Hand
    Generator.drawTextureLegacy(
      "Skin",
      {x: 32, y: 48, w: 12, h: 16},
      {x: 297, y: 211, w: 96, h: 128},
      (),
    ) //Left arm
    Generator.drawTextureLegacy(
      "Skin",
      {x: 44, y: 52, w: 4, h: 12},
      {x: 265, y: 243, w: 32, h: 96},
      (),
    ) //Back Left Arm
    Generator.drawTextureLegacy(
      "Skin",
      {x: 32, y: 52, w: 4, h: 4},
      {x: 297, y: 121, w: 32, h: 32},
      (),
    ) //Left Shoulder
    Generator.drawTextureLegacy(
      "Skin",
      {x: 32, y: 52, w: 4, h: 4},
      {x: 297, y: 86, w: 32, h: 32},
      (),
    ) //Left Shoulder Inside

    //Right Arm
    Generator.drawTextureLegacy(
      "Skin",
      {x: 48, y: 16, w: 4, h: 4},
      {x: 457, y: 714, w: 32, h: 32},
      ~flip=#Vertical,
      (),
    ) //Right Hand
    Generator.drawTextureLegacy(
      "Skin",
      {x: 40, y: 16, w: 16, h: 16},
      {x: 425, y: 587, w: 128, h: 128},
      (),
    ) //Right Arm
    Generator.drawTextureLegacy(
      "Skin",
      {x: 48, y: 20, w: 4, h: 4},
      {x: 489, y: 496, w: 32, h: 32},
      (),
    ) //Right Shoulder
    Generator.drawTextureLegacy(
      "Skin",
      {x: 48, y: 20, w: 4, h: 4},
      {x: 489, y: 462, w: 32, h: 32},
      (),
    ) //Right Shoulder Inside
  }
  // Legs

  //Left Leg
  Generator.drawTextureLegacy(
    "Skin",
    {x: 16, y: 48, w: 12, h: 16},
    {x: scale(457), y: scale(210), w: scale(96), h: scale(128)},
    (),
  ) //Left Leg
  Generator.drawTextureLegacy(
    "Skin",
    {x: 28, y: 52, w: 4, h: 8},
    {x: scale(521), y: scale(210), w: scale(32), h: scale(64)},
    ~rotateLegacy=180.0,
    (),
  ) //Left Buttock
  Generator.drawTextureLegacy(
    "Skin",
    {x: 28, y: 52, w: 4, h: 12},
    {x: scale(425), y: scale(242), w: scale(32), h: scale(96)},
    (),
  ) //Back Left Leg
  Generator.drawTextureLegacy(
    "Skin",
    {x: 24, y: 48, w: 4, h: 4},
    {x: scale(489), y: scale(338), w: scale(32), h: scale(32)},
    ~flip=#Vertical,
    (),
  ) //Left foot

  //Right Leg
  Generator.drawTextureLegacy(
    "Skin",
    {x: 0, y: 16, w: 16, h: 16},
    {x: scale(265), y: scale(586), w: scale(128), h: scale(128)},
    (),
  ) //Right Leg
  Generator.drawTextureLegacy(
    "Skin",
    {x: 12, y: 20, w: 4, h: 8},
    {x: scale(329), y: scale(586), w: scale(32), h: scale(64)},
    ~rotateLegacy=180.0,
    (),
  ) //Right Buttock
  Generator.drawTextureLegacy(
    "Skin",
    {x: 8, y: 16, w: 4, h: 4},
    {x: scale(297), y: scale(714), w: scale(32), h: scale(32)},
    ~flip=#Vertical,
    (),
  ) //Right foot

  //Overlay
  if !hideHelmet {
    // Helmet
    Generator.drawTextureLegacy(
      "Skin",
      {x: 32, y: 8, w: 8, h: 8},
      {x: scale(74), y: scale(790), w: scale(64), h: scale(64)},
      ~rotateLegacy=-90.0,
      (),
    ) // Right
    Generator.drawTextureLegacy(
      "Skin",
      {x: 40, y: 8, w: 8, h: 8},
      {x: scale(74), y: scale(726), w: scale(64), h: scale(64)},
      ~rotateLegacy=-90.0,
      (),
    ) // Face
    Generator.drawTextureLegacy(
      "Skin",
      {x: 48, y: 8, w: 8, h: 8},
      {x: scale(74), y: scale(662), w: scale(64), h: scale(64)},
      ~rotateLegacy=-90.0,
      (),
    ) // Left
    Generator.drawTextureLegacy(
      "Skin",
      {x: 56, y: 8, w: 8, h: 8},
      {x: scale(74), y: scale(598), w: scale(64), h: scale(64)},
      ~rotateLegacy=-90.0,
      (),
    ) // Back
    Generator.drawTextureLegacy(
      "Skin",
      {x: 40, y: 0, w: 8, h: 8},
      {x: scale(10), y: scale(726), w: scale(64), h: scale(64)},
      ~rotateLegacy=-90.0,
      (),
    ) // Top
    Generator.drawTextureLegacy(
      "Skin",
      {x: 48, y: 0, w: 8, h: 8},
      {x: scale(138), y: scale(726), w: scale(64), h: scale(64)},
      ~rotateLegacy=-90.0,
      ~flip=#Vertical,
      (),
    ) // Bot

    //Neck
    Generator.drawTextureLegacy(
      "Skin",
      {x: 48, y: 0, w: 8, h: 8},
      {x: scale(36), y: scale(414), w: scale(64), h: scale(96)},
      (),
    )
  } // Bot

  if !hideJacket {
    //Jacket
    Generator.drawTextureLegacy(
      "Skin",
      {x: 16, y: 32, w: 24, h: 16},
      {x: scale(35), y: scale(50), w: scale(192), h: scale(128)},
      (),
    ) // Jacket
    Generator.drawTextureLegacy(
      "Skin",
      {x: 28, y: 32, w: 8, h: 4},
      {x: scale(67), y: scale(178), w: scale(64), h: scale(32)},
      ~flip=#Vertical,
      (),
    )
  } // Bot

  // Sleeves

  if alexModel {
    if !hideLeftSleeve {
      //Left Sleeve
      Generator.drawTextureLegacy(
        "Skin",
        {x: 55, y: 48, w: 3, h: 4},
        {x: 329, y: 338, w: 24, h: 32},
        ~flip=#Vertical,
        (),
      ) //Left Glove
      Generator.drawTextureLegacy(
        "Skin",
        {x: 48, y: 48, w: 11, h: 16},
        {x: 297, y: 211, w: 88, h: 128},
        (),
      ) //Left Sleeve
      Generator.drawTextureLegacy(
        "Skin",
        {x: 59, y: 52, w: 3, h: 12},
        {x: 273, y: 243, w: 24, h: 96},
        (),
      ) //Back Left Sleeve
      Generator.drawTextureLegacy(
        "Skin",
        {x: 48, y: 52, w: 4, h: 4},
        {x: 297, y: 121, w: 32, h: 32},
        (),
      ) //Left Shoulder Sleeve
      Generator.drawTextureLegacy(
        "Skin",
        {x: 48, y: 52, w: 4, h: 4},
        {x: 297, y: 86, w: 32, h: 32},
        (),
      )
    } //Left Shoulder Sleeve Inside

    if !hideRightSleeve {
      //Right Sleeve
      Generator.drawTextureLegacy(
        "Skin",
        {x: 47, y: 32, w: 3, h: 4},
        {x: 465, y: 714, w: 24, h: 32},
        ~flip=#Vertical,
        (),
      ) //Right Glove
      Generator.drawTextureLegacy(
        "Skin",
        {x: 40, y: 32, w: 14, h: 16},
        {x: 433, y: 587, w: 112, h: 128},
        (),
      ) //Right Sleeve
      Generator.drawTextureLegacy(
        "Skin",
        {x: 47, y: 36, w: 4, h: 4},
        {x: 489, y: 496, w: 32, h: 32},
        (),
      ) //Right Shoulder Sleeve
      Generator.drawTextureLegacy(
        "Skin",
        {x: 47, y: 36, w: 4, h: 4},
        {x: 489, y: 462, w: 32, h: 32},
        (),
      ) //Right Shoulder Sleeve Inside
    }
  } else {
    if !hideLeftSleeve {
      //Left Sleeve
      Generator.drawTextureLegacy(
        "Skin",
        {x: 56, y: 48, w: 4, h: 4},
        {x: 329, y: 338, w: 32, h: 32},
        ~flip=#Vertical,
        (),
      ) //Left Glove
      Generator.drawTextureLegacy(
        "Skin",
        {x: 48, y: 48, w: 12, h: 16},
        {x: 297, y: 211, w: 96, h: 128},
        (),
      ) //Left Sleeve
      Generator.drawTextureLegacy(
        "Skin",
        {x: 60, y: 52, w: 4, h: 12},
        {x: 265, y: 243, w: 32, h: 96},
        (),
      ) //Back Left Sleeve
      Generator.drawTextureLegacy(
        "Skin",
        {x: 48, y: 52, w: 4, h: 4},
        {x: 297, y: 121, w: 32, h: 32},
        (),
      ) //Left Shoulder Sleeve
      Generator.drawTextureLegacy(
        "Skin",
        {x: 48, y: 52, w: 4, h: 4},
        {x: 297, y: 86, w: 32, h: 32},
        (),
      )
    } //Left Shoulder Sleeve Inside

    if !hideRightSleeve {
      //Right Sleeve
      Generator.drawTextureLegacy(
        "Skin",
        {x: 48, y: 32, w: 4, h: 4},
        {x: 457, y: 714, w: 32, h: 32},
        ~flip=#Vertical,
        (),
      ) //Right Glove
      Generator.drawTextureLegacy(
        "Skin",
        {x: 40, y: 32, w: 16, h: 16},
        {x: 425, y: 587, w: 128, h: 128},
        (),
      ) //Right Sleeve
      Generator.drawTextureLegacy(
        "Skin",
        {x: 48, y: 36, w: 4, h: 4},
        {x: 489, y: 496, w: 32, h: 32},
        (),
      ) //Right Shoulder Sleeve
      Generator.drawTextureLegacy(
        "Skin",
        {x: 48, y: 36, w: 4, h: 4},
        {x: 489, y: 462, w: 32, h: 32},
        (),
      )
    } //Right Shoulder Sleeve Inside
  }
  // Pants

  if !hideLeftPant {
    Generator.drawTextureLegacy(
      "Skin",
      {x: 4, y: 48, w: 4, h: 4},
      {x: 163, y: 380, w: 32, h: 130},
      (),
    ) // Left Pelvis

    //Left Leg Pant
    Generator.drawTextureLegacy(
      "Skin",
      {x: 0, y: 48, w: 12, h: 16},
      {x: 457, y: 210, w: 96, h: 128},
      (),
    ) //Left Leg Pant
    Generator.drawTextureLegacy(
      "Skin",
      {x: 12, y: 52, w: 4, h: 8},
      {x: 521, y: 210, w: 32, h: 64},
      ~rotateLegacy=180.0,
      (),
    ) //Left Buttock Pant
    Generator.drawTextureLegacy(
      "Skin",
      {x: 12, y: 52, w: 4, h: 12},
      {x: 425, y: 242, w: 32, h: 96},
      (),
    ) //Back Left Leg Pant
    Generator.drawTextureLegacy(
      "Skin",
      {x: 8, y: 48, w: 4, h: 4},
      {x: 489, y: 338, w: 32, h: 32},
      ~flip=#Vertical,
      (),
    ) //Left foot Shoe

    Generator.drawTextureLegacy(
      "Skin",
      {x: 8, y: 52, w: 4, h: 4},
      {x: 131, y: 178, w: 32, h: 32},
      (),
    ) // Left Hip Pant
  }

  if !hideRightPant {
    Generator.drawTextureLegacy(
      "Skin",
      {x: 4, y: 32, w: 4, h: 4},
      {x: 131, y: 380, w: 32, h: 130},
      (),
    ) // Right Pelvis

    //Right Leg Pant
    Generator.drawTextureLegacy(
      "Skin",
      {x: 0, y: 32, w: 16, h: 16},
      {x: 265, y: 586, w: 128, h: 128},
      (),
    ) //Right Leg
    Generator.drawTextureLegacy(
      "Skin",
      {x: 12, y: 36, w: 4, h: 8},
      {x: 329, y: 586, w: 32, h: 64},
      ~rotateLegacy=180.0,
      (),
    ) //Right Buttock
    Generator.drawTextureLegacy(
      "Skin",
      {x: 8, y: 32, w: 4, h: 4},
      {x: 297, y: 714, w: 32, h: 32},
      ~flip=#Vertical,
      (),
    ) //Right foot

    Generator.drawTextureLegacy(
      "Skin",
      {x: 0, y: 36, w: 4, h: 4},
      {x: 35, y: 178, w: 32, h: 32},
      (),
    ) // Right Hip Pant
  }

  // Background
  if alexModel {
    Generator.drawImage("Backgroundalex", (0, 0))
  } else {
    Generator.drawImage("Backgroundsteve", (0, 0))
  }

  // Folds
  if showFolds {
    if alexModel {
      Generator.drawImage("Foldsalex", (0, 0))
    } else {
      Generator.drawImage("Foldssteve", (0, 0))
    }
  }
  // Hand Notches
  if handNotches {
    if alexModel {
      Generator.drawImage("Notch", (scale(341), scale(307))) // Front Left Notch
      Generator.drawImage("Notch", (scale(285), scale(307))) // Back Left Notch
      Generator.drawImage("Notch", (scale(477), scale(683))) // Front Right Notch
      Generator.drawImage("Notch", (scale(533), scale(683))) // Back Right Notch
    } else {
      Generator.drawImage("Notch", (scale(345), scale(307))) // Front Left Notch
      Generator.drawImage("Notch", (scale(281), scale(307))) // Back Left Notch
      Generator.drawImage("Notch", (scale(473), scale(683))) // Front Right Notch
      Generator.drawImage("Notch", (scale(537), scale(683))) // Back Right Notch
    }
  }

  // Labels
  if showLabels {
    Generator.drawImage("Labels", (0, 0))
  }
}

let generator: Generator.generatorDef = {
  id: id,
  name: name,
  history: history,
  thumbnail: Some(thumbnail),
  video: None,
  instructions: None,
  images: images,
  textures: textures,
  script: script,
}
