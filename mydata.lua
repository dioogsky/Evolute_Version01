local M = {}
M.maxLevels = 12
M.settings = {}
M.settings.currentLevel = 1
M.settings.unlockedLevels = 4
M.settings.soundOn = true
M.settings.musicOn = true
M.settings.levels = {}

-- These lines are just here to pre-populate the table.
-- In reality, your app would likely create a level entry when each level is unlocked and the score/stars are saved.
-- Perhaps this happens at the end of your game level, or in a scene between game levels.
M.settings.levels[1] = {}
M.settings.levels[1].stars = 3
M.settings.levels[1].score = 0
M.settings.levels[2] = {}
M.settings.levels[2].stars = 0
M.settings.levels[2].score = 0
M.settings.levels[3] = {}
M.settings.levels[3].stars = 0
M.settings.levels[3].score = 0
M.settings.levels[4] = {}
M.settings.levels[4].stars = 0
M.settings.levels[4].score = 0
M.settings.levels[5] = {}
M.settings.levels[5].stars = 0
M.settings.levels[5].score = 0
M.settings.levels[6] = {}
M.settings.levels[6].stars = 0
M.settings.levels[6].score = 0

-- levels data members:
--      .stars -- Stars earned per level
--      .score -- Score for the level
return M
