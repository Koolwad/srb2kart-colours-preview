----------------------------------------------------------------------
-- Preview a sprite in the colours available in SRB2Kart's palette.
-- By Pepperdork, 2020
----------------------------------------------------------------------

--**************** 
--	GLOBAL VARIABLES 
--****************
local dlg = Dialog{title="SRB2Kart (v1) Colours Preview"}
local kartpal 

-- Format: {Name, {Palette Values}}
local paletteTable = {
	{"White", {120, 120, 120, 120,   1,   2,   5,   8,   9,  11,  14,  17,  20,  22,  25,  28}}, 
	{"Silver", {  0,   1,   2,   3,   5,   7,   9,  12,  13,  15,  18,  20,  23,  25,  27,  30}},
	{"Gray",{  1,   3,   5,   7,   9,  11,  13,  15,  17,  19,  21,  23,  25,  27,  29,  31}},
	{"Nickel",{  3,   5,   8,  11,  15,  17,  19,  21,  23,  24,  25,  26,  27,  29,  30,  31}},
	{"Black",{  4,   7,  11,  15,  20,  22,  24,  27,  28,  28,  28,  29,  29,  30,  30,  31}},
	{"Skunk", {120, 120,   0,   2,   4,  10,  16,  22,  23,  24,  25,  26,  27,  28,  29,  31}},
	{"Fairy", {120, 120, 121, 121, 122, 123,  10,  14,  16,  18,  20,  22,  24,  26,  28,  31}},
	{"Popcorn", {120,  96,  97,  98,  99,  71,  32,  11,  13,  16,  18,  21,  23,  26,  28,  31}},
	{"Artichoke", { 97, 176, 177, 162, 163, 179,  12,  14,  16,  18,  20,  22,  24,  26,  28,  31}},
	{"Pigeon", {  0, 208, 209, 211, 226, 202,  14,  15,  17,  19,  21,  23,  25,  27,  29,  31}},
	{"Sepia", {  0,   1,   3,   5,   7,   9,  34,  36,  38,  40,  42,  44,  60,  61,  62,  63}},
	{"Beige", {120,  65,  67,  69,  32,  34,  36,  38,  40,  42,  44,  45,  46,  47,  62,  63}},
	{"Walnut", {  3,   6,  32,  33,  35,  37,  51,  52,  54,  55,  57,  58,  60,  61,  63,  30}},
	{"Brown", { 67,  70,  73,  76,  48,  49,  51,  53,  54,  56,  58,  59,  61,  63,  29,  30}},
	{"Leather", { 72,  76,  48,  51,  53,  55,  57,  59,  61,  63,  28,  28,  29,  29,  30,  31}},
	{"Salmon", {120, 120, 120, 121, 121, 122, 123, 124, 126, 127, 129, 131, 133, 135, 137, 139}},
	{"Pink",{120, 121, 121, 122, 144, 145, 146, 147, 148, 149, 150, 151, 134, 136, 138, 140}},
	{"Rose", {144, 145, 146, 147, 148, 149, 150, 151, 134, 135, 136, 137, 138, 139, 140, 141}},
	{"Brick",{ 64,  67,  70,  73, 146, 147, 148, 150, 118, 118, 119, 119, 156, 159, 141, 143}},
	{"Cinnamon",{ 68,  75,  48,  50,  52,  94, 152, 136, 137, 138, 139, 140, 141, 142, 143,  31}},
	{"Ruby", {120, 121, 144, 145, 147, 149, 132, 133, 134, 136, 198, 198, 199, 255,  30,  31}},
	{"Raspberry", {120, 121, 122, 123, 124, 125, 126, 127, 128, 130, 131, 134, 136, 137, 139, 140}},
	{"Cherry", {120,  65,  67,  69,  71, 124, 125, 127, 132, 133, 135, 136, 138, 139, 140, 141}},
	{"Red",{122, 123, 124, 126, 129, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142}},
	{"Crimson",{123, 125, 128, 131, 133, 135, 136, 138, 140, 140, 141, 141, 142, 142, 143,  31}},
	{"Maroon", {123, 124, 126, 128, 132, 135, 137,  27,  28,  28,  28,  29,  29,  30,  30,  31}},
	{"Lemonade", {120,  96,  97,  98,  99,  65, 122, 144, 123, 124, 147, 149, 151, 153, 156, 159}},
	{"Flame", {120,  97, 112, 113, 113,  85,  87, 126, 149, 150, 151, 252, 253, 254, 255,  29}},
	{"Scarlet", { 99, 113, 113,  84,  85,  87, 126, 128, 130, 196, 197, 198, 199, 240, 243, 246}},
	{"Ketchup", {103, 113, 113,  84,  85,  88, 127, 130, 131, 133, 134, 136, 138, 139, 141, 143}},
	{"Dawn",{120, 121, 122, 123, 124, 147, 148,  91,  93,  95, 152, 154, 156, 159, 141, 143}},
	{"Sunset", { 98, 112, 113,  84,  85,  87,  89, 149, 150, 251, 251, 205, 206, 207,  29,  31}},
	{"Creamsicle", {120, 120,  80,  80,  81,  82,  83,  83,  84,  85,  86,  88,  89,  91,  93,  95}},
	{"Orange", { 80,  81,  82,  83,  84,  85,  86,  88,  89,  91,  94,  95, 154, 156, 158, 159}},
	{"Pumpkin", { 82,  83,  84,  85,  87,  89,  90,  92,  94, 152, 153, 155, 157, 159, 141, 142}},
	{"Rosewood", { 83,  85,  88,  90,  92,  94, 152, 153, 154, 156, 157, 159, 140, 141, 142, 143}},
	{"Burgundy", { 84,  86,  89,  91, 152, 154, 155, 157, 158, 159, 140, 141, 142, 143,  31,  31}},
	{"Tangerine", { 98,  98, 112, 112, 113, 113,  84,  85,  87,  89,  91,  93,  95, 153, 156, 159}},
	{"Peach", {120,  80,  66,  70,  72,  76, 148, 149, 150, 151, 153, 154, 156,  61,  62,  63}},
	{"Caramel", { 64,  66,  68,  70,  72,  74,  76,  78,  48,  50,  52,  54,  56,  58,  60,  62}},
	{"Cream", {120,  96,  96,  97,  98,  82,  84,  77,  50,  54,  57,  59,  61,  63,  29,  31}},
	{"Gold", { 96,  97,  98, 112, 113, 114, 115, 116, 117, 151, 118, 119, 157, 159, 140, 143}},
	{"Royal", { 97, 112, 113, 113, 114,  78,  53, 252, 252, 253, 253, 254, 255,  29,  30,  31}},
	{"Bronze",{112, 113, 114, 115, 116, 117, 118, 119, 156, 157, 158, 159, 141, 141, 142, 143}},
	{"Copper", {120,  99, 113, 114, 116, 117, 119,  61,  63,  28,  28,  29,  29,  30,  30,  31}},
	{"Quarry", { 96,  97,  98,  99, 104, 105, 106, 107, 117, 152, 154, 156, 159, 141, 142, 143}},
	{"Yellow", { 96,  97,  98, 100, 101, 102, 104, 113, 114, 115, 116, 117, 118, 119, 156, 159}},
	{"Mustard", {96,  98,  99, 112, 113, 114, 114, 106, 106, 107, 107, 108, 108, 109, 110, 111}},
	{"Crocodile", {120,  96,  97,  98, 176, 113, 114, 106, 115, 107, 108, 109, 110, 174, 175,  31}},
	{"Olive",{ 98, 101, 104, 105, 106, 115, 107, 108, 182, 109, 183, 110, 174, 111,  30,  31}},
	{"Vomit", {  0, 121, 122, 144,  71,  84, 114, 115, 107, 108, 109, 183, 223, 207,  30, 246}},
	{"Garden", { 98,  99, 112, 101, 113, 114, 106, 179, 180, 180, 181, 182, 183, 173, 174, 175}},
	{"Lime", {120,  96,  97,  98,  99, 176, 177, 163, 164, 166, 168, 170, 223, 207, 243,  31}},
	{"Handheld", { 98, 104, 105, 105, 106, 167, 168, 169, 170, 171, 172, 173, 174, 175,  30,  31}},
	{"Tea", {120, 120, 176, 176, 176, 177, 177, 178, 178, 179, 179, 180, 180, 181, 182, 183}},
	{"Pistachio", {120, 120, 176, 176, 177, 177, 178, 179, 165, 166, 167, 168, 169, 170, 171, 172}},
	{"Moss", {178, 178, 178, 179, 179, 180, 181, 182, 183, 172, 172, 173, 173, 174, 174, 175}},
	{"Camouflage", { 64,  66,  69,  32,  34,  37,  40, 182, 171, 172, 172, 173, 173, 174, 174, 175}},
	{"Robohood", {120, 176, 160, 165, 167, 168, 169, 182, 182, 171,  60,  61,  63,  29,  30,  31}},
	{"Mint", {120, 176, 176, 176, 177, 163, 164, 165, 167, 221, 221, 222, 223, 207, 207,  31}},
	{"Green", {160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175}},
	{"Pinetree", {161, 163, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175,  30,  30,  31}},
	{"Emerald", {160, 184, 184, 185, 185, 186, 186, 187, 187, 188, 188, 189, 189, 190, 191, 175}},
	{"Swamp", {160, 184, 185, 186, 187, 188, 189, 190, 191, 191,  29,  29,  30,  30,  31,  31}},
	{"Dream", {120, 120,  80,  80,  81, 177, 162, 164, 228, 228, 204, 204, 205, 205, 206, 207}},
	{"Plague", { 97, 176, 160, 184, 185, 186, 187, 229, 229, 205, 206, 207,  28,  29,  30,  31}},
	{"Algae", {208, 209, 210, 211, 213, 220, 216, 167, 168, 188, 188, 189, 190, 191,  30,  31}},
	{"Caribbean", {120, 176, 177, 160, 185, 220, 216, 217, 229, 229, 204, 205, 206, 254, 255,  31}},
	{"Azure", {120,  96,  97,  98, 177, 220, 216, 217, 218, 204, 252, 253, 254, 255,  30,  31}},
	{"Aqua", {120, 208, 208, 210, 212, 214, 220, 220, 220, 221, 221, 222, 222, 223, 223, 191}},
	{"Teal", {210, 213, 220, 220, 220, 216, 216, 221, 221, 221, 222, 222, 223, 223, 191,  31}},
	{"Cyan", {120, 120, 208, 208, 209, 210, 211, 212, 213, 215, 216, 217, 218, 219, 222, 223}},
	{"Jawz", {120, 120, 208, 209, 210, 226, 215, 216, 217, 229, 229, 205, 205, 206, 207,  31}},
	{"Cerulean", {208, 209, 211, 213, 215, 216, 216, 217, 217, 218, 218, 219, 205, 206, 207, 207}},
	{"Navy", {211, 212, 213, 215, 216, 218, 219, 205, 206, 206, 207, 207,  28,  29,  30,  31}},
	{"Platinum", {120,   0,   0, 200, 200, 201,  11,  14,  17, 218, 222, 223, 238, 240, 243, 246}},
	{"Slate", {120, 120, 200, 200, 200, 201, 201, 201, 202, 202, 202, 203, 204, 205, 206, 207}},
	{"Steel", {120, 200, 200, 201, 201, 202, 202, 203, 203, 204, 204, 205, 205, 206, 207,  31}},
	{"Thunder", { 96,  97,  98, 112, 113, 114,  11, 203, 204, 205, 205, 237, 239, 241, 243, 246}},
	{"Rust", { 64,  66,  68,  70,  32,  34,  36, 203, 204, 205,  24,  25,  26,  28,  29,  31}},
	{"Wristwatch", { 81,  72,  76,  48,  51,  55, 252, 205, 205, 206, 240, 241, 242, 243, 244, 246}},
	{"Jet", {225, 226, 227, 228, 229, 205, 205, 206, 207, 207,  28,  28,  29,  29,  30,  31}},
	{"Sapphire", {208, 209, 211, 213, 215, 217, 229, 230, 232, 234, 236, 238, 240, 242, 244, 246}},
	{"Periwinkle", {120, 120, 224, 225, 226, 202, 227, 228, 229, 230, 231, 233, 235, 237, 239, 241}},
	{"Blue", {224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 235, 236, 238, 242, 244, 246}},
	{"Blueberry", {226, 228, 229, 230, 232, 233, 235, 237, 239, 240, 242, 244, 246,  31,  31,  31}},
	{"Nova", {120, 112,  82,  83,  84, 124, 248, 228, 228, 204, 205, 206, 207,  29,  30,  31}},
	{"Pastel", {120, 208, 209, 210, 211, 226, 202, 249, 194, 195, 196, 197, 198, 199, 255,  30}},
	{"Moonslam", {120, 224, 201, 226, 202, 249, 250, 196, 197, 198, 199, 140, 141, 142, 143,  31}},
	{"Ultraviolet", {120,  64,  81, 122, 192, 249, 203, 221, 221, 219, 219, 223, 223, 191, 191,  31}},
	{"Dusk", {121, 145, 192, 249, 250, 251, 204, 204, 205, 205, 206, 206, 207,  29,  30,  31}},
	{"Bubblegum", {120,  96,  64, 121,  67, 144, 123, 192, 193, 194, 195, 196, 197, 198, 199,  30}},
	{"Purple", {121, 145, 192, 192, 193, 194, 195, 196, 196, 197, 197, 198, 198, 199,  30,  31}},
	{"Fuchsia", {120, 122, 124, 125, 126, 150, 196, 197, 198, 198, 199, 199, 240, 242, 244, 246}},
	{"Toxic", {120, 120, 176, 176, 177,   6,   8,  10, 249, 250, 196, 197, 198, 199, 143,  31}},
	{"Mauve", { 96,  97,  98, 112, 113,  73, 146, 248, 249, 251, 205, 205, 206, 207,  29,  31}},
	{"Lavender", {121, 145, 192, 248, 249, 250, 251, 252, 252, 253, 253, 254, 254, 255,  30,  31}},
	{"Byzantium", {201, 248, 249, 250, 251, 252, 253, 254, 255, 255,  29,  29,  30,  30,  31,  31}},
	{"Pomegranate", {144, 145, 146, 147, 148, 149, 150, 251, 251, 252, 252, 253, 254, 255,  29,  30}},
	{"Lilac", {120, 120, 120, 121, 121, 122, 122, 123, 192, 248, 249, 250, 251, 252, 253, 254}}
}
--------------------------------------

--**************** 
-- FUNCTIONS
--****************

----- HELPER FUNCTIONS
function alertUser(title, text)
	return app.alert{
		title=title,
		text=text
	}
end

function findColorInTable(index, table)  
    for i=1, #table do 
        if(table[i] == index) then return i end
    end 
    return nil
end

function validateFile(choice)
	local spr = app.activeSprite

	if #spr.cels == 0 then 
		alertUser("Warning", "This sprite has no cels.")
		return false 
	end

	if app.activeCel.image:isEmpty() then 
		alertUser("Warning", "The cel is empty.")
		return false 
	end

	if(choice == "SELECTION") then 
		if spr.selection.isEmpty then 
			alertUser("Warning", "You're not selecting anything.")
			return false
		end

	else
		if spr.colorMode ~= ColorMode.INDEXED then
			alertUser("Warning", "Make sure the sprite's color mode is set to Indexed. (Sprite -> Color Mode)")
			return false
		end
	end

	return true
end

function hasGreenPixels(image, pixels)

	local tempImage = image:clone()
	local foundPixel = false 

	for it in tempImage:pixels() do 
		if(findColorInTable(it(), pixels)) then
			foundPixel = true 
		end
	end
	return foundPixel
	
end

function parsePaletteFile() 
    -- Check the file and validate the palette.
    local tempPal = Palette{fromFile=dlg.data.kartpal}

    -- Kart has 256 colours by default. 
    -- 256-1 = 255
    if(#tempPal ~= 256) then 
		alertUser("Warning","Please select a SRB2Kart palette.")
		dlg:modify {
            id="ok",
            enabled=false
        }
        dlg:show()
    else 
        -- app.activeSprite:setPalette(tempPal)
        kartpal = temp
        dlg:modify {
            id="ok",
            enabled=true
        }
        dlg:show()
    end
end
-------------------------

----- MAIN FUNCTION
function applyPalette(choice)

	-- Validate the sprite based off of the user's choice. 
	-- For example, using current selection. Are you even selecting anything?
	-- Or, using the current sprite, is the sprite empty?
	if(not validateFile(choice)) then 
		return
	end

    -- Close the dialog and let's do the thing.
	dlg:close()
	
	-- Range of colours in palette that are recolourable
	local greenArray = {160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175}
	
	-- Get the first frame (assuming its a green version of the character) and use this as a base.
	local baseImage = app.activeCel.image:clone()

	-- Selection? Or the whole sprite?
	if(choice == "SELECTION") then 
		local selection = app.activeSprite.selection
		app.command.Copy()
		
		local nSprite = Sprite(selection.bounds.width, selection.bounds.height, ColorMode.INDEXED)
		nSprite:setPalette(Palette{fromFile=dlg.data.kartpal})
		
		app.command.Paste()
		app.command.Cancel()

		baseImage = app.activeSprite.cels[1].image:clone()
	else
		app.activeSprite:setPalette(Palette{fromFile=dlg.data.kartpal})
	end

	-- Does the current image (selection/sprite) have ANY green pixels?
	if(not hasGreenPixels(baseImage, greenArray)) then 
		alertUser("Warning", "The selected sprite doesn't have any green pixels (Range 160 - 175). Please edit your sprite and try again.")
		return
	end
		
	-- Loop through all the colours, make a new frame, recolour the pixels and repeat.
	for i=1, #paletteTable do 
				
        local colorName = paletteTable[i][1]
        local colorTable = paletteTable[i][2]

        local cel = app.activeSprite.cels[i]
        local tempImage = baseImage:clone()

        for it in tempImage:pixels() do
            local matchingColour = findColorInTable(it(), greenArray)
			if(matchingColour) then 
                it(colorTable[matchingColour])
            end
        end
		cel.image = tempImage

		if(paletteTable[i+1]) then
			app.command.MaskAll()
			app.command.Copy()

			app.activeSprite:newEmptyFrame()
			app.activeSprite:newCel(app.activeLayer, i+1)

			app.command.Paste()
			app.command.Cancel()

		end
	end

	-- And jump back to the beginning.
	app.command.GotoFirstFrame()

	alertUser("Notification", "And we're done!")
    app.refresh()
end
------------

if not app.activeSprite then 
	return alertUser("Warning", "There's no active sprite. Create a new one first.")
end
--------------------------------------

--**************** 
--	DIALOG SETUP
--****************

-- Path entry
dlg:file {
    id="kartpal",
    label="Palette File",
    title="Open Kart Palette",
    open=true,
    filename="Open file..",
    filetypes={"png","pal"},
    onchange=parsePaletteFile
}

-- Dropdown list
dlg:combobox {
	id="typelist",
	label="Selection",
	options={"Current Selection", "Whole Sprite"}
}

-- Description labels
dlg:label {
	id="currentsel",
	label="",
	text="Current Selection - Uses whatever you're selecting"
}
dlg:label {
	id="wholesprite",
	label="",
	text="Whole Sprite - Uses the entire sprite"
}
dlg:label {
	id="importantnote",
	label="",
	text="NOTE: The script will use the current cel/frame that you're on."
}

-- OK
dlg:button {
    id="ok",
    text="OK",
	onclick=(function()
		local choice = dlg.data.typelist == "Whole Sprite" and "SPRITE" or "SELECTION"
        app.transaction(
			function()
				applyPalette(choice)
		end)
    end)
}

-- Cancel
dlg:button {
    id="cancel",
	text="Cancel"
}

-- OK (Disable by default.)
dlg:modify {
    id="ok",
    enabled=false
}

-- And show.
dlg:show()
-- ****************
