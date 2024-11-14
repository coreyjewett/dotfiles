local settings = require("settings")
local colors = require("colors")

-- Padding item required because of bracket
sbar.add("item", { position = "right", width = settings.group_paddings })

local cal = sbar.add("item", {
  icon = {
    color = colors.white,
    padding_left = 8,
    font = {
      style = settings.font.style_map["Black"],
      size = 12.0,
    },
  },
  label = {
    color = colors.white,
    padding_right = 8,
    width = 49,
    align = "right",
    font = { family = settings.font.numbers },
  },
  position = "right",
  update_freq = 30,
  padding_left = 1,
  padding_right = 1,
  background = {
    color = colors.bg2,
    border_color = colors.black,
    border_width = 1
  },
})

-- Double border for calendar using a single item bracket
sbar.add("bracket", { cal.name }, {
  background = {
    color = colors.transparent,
    height = 30,
    border_color = colors.grey,
  }
})

-- Padding item required because of bracket
sbar.add("item", { position = "right", width = settings.group_paddings })

local function get_day_suffix(day)
    if day == 1 or day == 21 or day == 31 then
        return "st"
    elseif day == 2 or day == 22 then
        return "nd"
    elseif day == 3 or day == 23 then
        return "rd"
    else
        return "th"
    end
end

cal:subscribe({ "forced", "routine", "system_woke" }, function(env)
  local day = os.date("%d")
  cal:set({ icon = day .. get_day_suffix(day), label = os.date("%H:%M") })
end)
