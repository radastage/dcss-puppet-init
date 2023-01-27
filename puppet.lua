
{
local playercolor
local start = 0
local where = string
local wallset = 0
use_appearance = false
use_bonus = false
max_bonus_level = 4
max_bonus_floor = 4
max_bonus_int = 10
max_bonus_str = 10
max_bonus_dex = 10
max_bonus_faith = 50
max_bonus_gold = 200
use_polymorph = false

function handle_safety()
local hp, max_hp = you.hp()
if (hp < max_hp * 0.20) then
crawl.sendkeys(string.char(string.byte("z") - string.byte("a") + 1))
end
end

function is_ending_vocable(name)
if string.ends(name, "a") or string.ends(name, "e") or string.ends(name, "i") or string.ends(name, "o") or string.ends(name, "u") or
string.ends(name, "y") then
crawl.mpr("female")
return true
end
end

function menu()
crawl.mpr("Enter Command (? - help):")
crawl.flush_prev_message()
local res = string.char(crawl.getch())
if (res == "?") then
crawl.mpr("1 - Colour Inscribe")
crawl.more()
crawl.mpr("2 - Colour Inscribe Alt")
crawl.more()
crawl.mpr("3 - Dungeon Site")
crawl.more()
crawl.mpr("4 - Random Follower <13>(&)</13>")
crawl.more()
crawl.mpr("5 - Random Number (1-100)")
crawl.more()
crawl.mpr("6 - Random Number (1-Custom)")
crawl.more()
crawl.mpr("7 - Persist Note Default")
crawl.more()
crawl.mpr("8 - Persist Note Players")
crawl.more()
crawl.mpr("9 - Enchanting <13>(&)</13>")
crawl.more()
crawl.mpr("P - Polymorph")
crawl.more()
crawl.mpr("F - Feature Placement <13>(&)</13>")
crawl.more()
crawl.mpr("J - Char Describe Macro (Misc)")
crawl.more()
crawl.mpr("D - Drop Everything")
crawl.more()
crawl.mpr("b - Build <13>(&)</13>")
crawl.more()
crawl.mpr("O - Freeplay <13>(&)</13>")
crawl.more()
crawl.mpr("C - Spawn Random <13>(&)</13>")
crawl.more()
crawl.mpr("V - Make Randart <13>(&)</13>")
crawl.more()
crawl.mpr("a - Modify Amount <13>(&)</13>")
crawl.more()
crawl.mpr("Z - Console")
crawl.more()
crawl.mpr("B - Pseudobuy")
crawl.more()
crawl.mpr("K - Pseudonotice")
crawl.more()
crawl.mpr("Q - Pseudoquest")
crawl.more()
crawl.mpr("S - Setup Character Appearance")
crawl.more()
crawl.mpr("W - Pseudo Near Death Message")
crawl.more()
crawl.mpr("I - Pseudoidentify")
crawl.more()
crawl.mpr("E - Embark Message (Reason)")
crawl.more()
end
if (res == "1") then
randitem()
end
if (res == "2") then
randinscribe()
end
if (res == "3") then
randlocation()
end
if (res == "4") then
rand_follower()
end
if (res == "5") then
random()
end
if (res == "6") then
random_custom()
end
if (res == "7") then
persist_note_default()
end
if (res == "8") then
persist_note_players()
end
if (res == "9") then
rand_enchant()
end
if (res == "P") then
polymorph()
end
if (res == "F") then
feature_placement()
end
if (res == "J") then
char_describe_mod()
end
if (res == "D") then
drop_everything()
end
if (res == "b") then
build()
end
if (res == "O") then
freeplay()
end
if (res == "C") then
spawn_random()
end
if (res == "V") then
randartize()
end
if (res == "A") then
mod_amount()
end
if (res == "Z") then
console()
end
if (res == "B") then
pseudobuy()
end
if (res == "K") then
pseudofight()
end
if (res == "I") then
pseudoidentify()
end
if (res == "S") then
char_appearance(you.name())
end
if (res == "Q") then
pseudoquest()
end
if (res == "W") then
pseudosurvive()
end
if (res == "E") then
embark()
end

end

function ready()
setpcolor()
raceglyph()
randitem()
crawl.setopt("friend_brand = hi:" .. playercolor)
crawl.setopt("monster_list_colour += friendly:" .. playercolor)
if c_persist.poly_user == you.name() then
handle_polymorph()
end
if start == 0 and c_persist.note then
crawl.mpr(c_persist.note)
start = 1
end
if wallset == 0 then
random_wall_color()
random_floor_color()
wallset = 1
end
if not (you.race() == "Felid") and not (you.race() == "Octopode") and you.turns() == 0 and (use_appearance == true) then
use_appearance = false
local name = you.name()
char_appearance(name)
char_traits()
crawl.sendkeys(".")
--randlocation()
end
if use_bonus == true and you.turns() == 0 then
bonus()
use_bonus = false
end
end

function char_traits()
local fav_race = rand_race()
local hate_race = rand_race()
while fav_race == you.race() do
fav_race = rand_race()
end
while hate_race == you.race() do
hate_race = rand_race()
end
while fav_race == hate_race do
hate_race = rand_race()
end
crawl.take_note(you.name() .. " likes spending time with " .. fav_race .. ", but strongly dislikes " .. hate_race .. ".")
end

function setpcolor()
if you.class() == "Fighter" then
playercolor = "lightgrey"
end
if you.class() == "Gladiator" then
playercolor = "yellow"
end
if you.class() == "Monk" then
playercolor = "green"
end
if you.class() == "Hunter" then
playercolor = "brown"
end
if you.class() == "Assassin" then
playercolor = "darkgrey"
end
if you.class() == "Berserker" then
playercolor = "red"
end
if you.class() == "Abyssal Knight" then
playercolor = "blue"
end
if you.class() == "Chaos Knight" then
playercolor = "yellow"
end
if you.class() == "Skald" then
playercolor = "lightcyan"
end
if you.class() == "Warper" then
playercolor = "lightmagenta"
end
if you.class() == "Transmuter" then
playercolor = "magenta"
end
if you.class() == "Arcane Marksman" then
playercolor = "cyan"
end
if you.class() == "Enchanter" then
playercolor = "lightcyan"
end
if you.class() == "Wizard" then
playercolor = "magenta"
end
if you.class() == "Conjurer" then
playercolor = "magenta"
end
if you.class() == "Summoner" then
playercolor = "lightmagenta"
end
if you.class() == "Necromancer" then
playercolor = "darkgrey"
end
if you.class() == "Fire Elementalist" then
playercolor = "lightred"
end
if you.class() == "Ice Elementalist" then
playercolor = "lightblue"
end
if you.class() == "Air Elementalist" then
playercolor = "white"
end
if you.class() == "Earth Elementalist" then
playercolor = "brown"
end
if you.class() == "Venom Mage" then
playercolor = "lightgreen"
end
if you.class() == "Artificer" then
playercolor = "cyan"
end
if you.class() == "Wanderer" then
playercolor = "lightgrey"
end
if you.class() == "Delver" then
playercolor = "lightgrey"
end
if you.class() == "Hedge Wizard" then
playercolor = "magenta"
end
if you.class() == "Brigand" then
playercolor = "darkgrey"
end
if you.race() == "Draconian" then
crawl.setopt("mon_glyph += player : d brown")
end
if you.race() == "Red Draconian" then
crawl.setopt("mon_glyph += player : d red")
end
if you.race() == "White Draconian" then
crawl.setopt("mon_glyph += player : d white")
end
if you.race() == "Green Draconian" then
crawl.setopt("mon_glyph += player : d green")
end
if you.race() == "Yellow Draconian" then
crawl.setopt("mon_glyph += player : d yellow")
end
if you.race() == "Grey Draconian" then
crawl.setopt("mon_glyph += player : d lightgrey")
end
if you.race() == "Black Draconian" then
crawl.setopt("mon_glyph += player : d darkgrey")
end
if you.race() == "Purple Draconian" then
crawl.setopt("mon_glyph += player : d magenta")
end
if you.race() == "Pale Draconian" then
crawl.setopt("mon_glyph += player : d cyan")
end
crawl.setopt("tc_excluded = " .. playercolor)
--crawl.setopt("colour.brown = " .. playercolor)
end

function bonus()
if you.wizard() then
crawl.sendkeys("&k" .. crawl.random2(max_bonus_level)+1)
crawl.sendkeys("\r")
if you.where():find("Abyss") then
crawl.sendkeys("aa")
crawl.sendkeys("\r")
end
crawl.sendkeys("&$99999")
crawl.sendkeys("\r")
crawl.sendkeys("&(ecum")
crawl.sendkeys("\r")
crawl.sendkeys(">")
crawl.sendkeys("Y")
crawl.sendkeys("&(floor")
crawl.sendkeys("\r")
crawl.sendkeys("&(enter_shop")
crawl.sendkeys("\r")
crawl.sendkeys("any")
crawl.sendkeys("\r")
crawl.sendkeys(">abcdefghijklmnopqrstuvwxyz")
crawl.sendkeys("\r")
crawl.sendkeys("y")
crawl.sendkeys(string.char(string.byte("g") - string.byte("a") + 1))
crawl.sendkeys("&$0")
crawl.sendkeys("\r")
crawl.sendkeys("&(exit_dungeon")
crawl.sendkeys("\r")
crawl.sendkeys("&w")
crawl.sendkeys("&~D" .. crawl.random2(max_bonus_floor)+1)
crawl.sendkeys("\r")
crawl.sendkeys("&@" .. crawl.random2(max_bonus_str)+you.strength() .. " " .. crawl.random2(max_bonus_dex)+you.dexterity() .. " " .. crawl.random2(max_bonus_int)+you.intelligence())
crawl.sendkeys("\r")
crawl.sendkeys("&^" .. crawl.random2(max_bonus_faith)+1)
crawl.sendkeys("\r")
crawl.sendkeys("\r")
crawl.sendkeys("&y")
crawl.sendkeys("&$" .. crawl.random2(max_bonus_gold))
crawl.sendkeys("\r")
--crawl.sendkeys("&!" .. crawl.random2(361)+1)
--crawl.sendkeys("\r")
--crawl.sendkeys("y")
end
end

function num_to_col(num)
local col
if not num then
return
end
if num == 0 then
col = "black"
end
if num == 1 then
col = "blue"
end
if num == 2 then
col = "green"
end
if num == 3 then
col = "cyan"
end
if num == 4 then
col = "red"
end
if num == 5 then
col = "magenta"
end
if num == 6 then
col = "brown"
end
if num == 7 then
col = "lightgrey"
end
if num == 8 then
col = "darkgrey"
end
if num == 9 then
col = "lightblue"
end
if num == 10 then
col = "lightgreen"
end
if num == 11 then
col = "lightcyan"
end
if num == 12 then
col = "lightred"
end
if num == 13 then
col = "lightmagenta"
end
if num == 14 then
col = "yellow"
end
if num == 15 then
col = "white"
end
return col
end

function raceglyph()
--if not string.find(you.race(), "Draconian") then
--playercolor = num_to_col(string.len(you.name()))
--end
if you.race() == "Hill Orc" then
crawl.setopt("mon_glyph += player : o " .. playercolor)
end
if you.race() == "Minotaur" then
crawl.setopt("mon_glyph += player : H " .. playercolor)
end
if you.race() == "Merfolk" then
crawl.setopt("mon_glyph += player : m " .. playercolor)
end
if you.race() == "Gargoyle" then
crawl.setopt("mon_glyph += player : 9 " .. playercolor)
end
if you.race() == "Halfling" then
crawl.setopt("mon_glyph += player : p " .. playercolor)
end
if you.race() == "Troll" then
crawl.setopt("mon_glyph += player : T " .. playercolor)
end
if you.race() == "Ghoul" then
crawl.setopt("mon_glyph += player : n " .. playercolor)
end
if you.race() == "Human" then
crawl.setopt("mon_glyph += player : p " .. playercolor)
end
if you.race() == "Kobold" then
crawl.setopt("mon_glyph += player : k " .. playercolor)
end
if you.race() == "Demonspawn" then
crawl.setopt("mon_glyph += player : 6 " .. playercolor)
end
if you.race() == "Centaur" then
crawl.setopt("mon_glyph += player : c " .. playercolor)
end
if you.race() == "Spriggan" then
crawl.setopt("mon_glyph += player : i " .. playercolor)
end
if you.race() == "Tengu" then
crawl.setopt("mon_glyph += player : Q " .. playercolor)
end
if you.race() == "Deep Elf" then
crawl.setopt("mon_glyph += player : e " .. playercolor)
end
if you.race() == "Ogre" then
crawl.setopt("mon_glyph += player : O " .. playercolor)
end
if you.race() == "Deep Dwarf" then
crawl.setopt("mon_glyph += player : g " .. playercolor)
end
if you.race() == "Gnoll" then
crawl.setopt("mon_glyph += player : g " .. playercolor)
end
if you.race() == "Vine Stalker" then
crawl.setopt("mon_glyph += player : f " .. playercolor)
end
if you.race() == "Vampire" then
crawl.setopt("mon_glyph += player : V " .. playercolor)
end
if you.race() == "Demigod" then
crawl.setopt("mon_glyph += player : & " .. playercolor)
end
if you.race() == "Formicid" then
crawl.setopt("mon_glyph += player : a " .. playercolor)
end
if you.race() == "Naga" then
crawl.setopt("mon_glyph += player : N " .. playercolor)
end
if you.race() == "Octopode" then
crawl.setopt("mon_glyph += player : x " .. playercolor)
end
if you.race() == "Felid" then
crawl.setopt("mon_glyph += player : h " .. playercolor)
end
if you.race() == "Barachi" then
crawl.setopt("mon_glyph += player : F " .. playercolor)
end
if you.race() == "Mummy" then
crawl.setopt("mon_glyph += player : M " .. playercolor)
end
if you.race() == "Palentonga" then
crawl.setopt("mon_glyph += player : Y " .. playercolor)
end
end

function random()
local rand = crawl.random2(100)+1
local color = randcol()
crawl.mpr("<" .. color .. ">" .. rand .. "</" .. color .. ">")
rand_name()
end

function rand_letter()
local letter = string.char(string.byte("a")+crawl.random2(26))
return letter
end

function rand_syllables()
local syl = util.random_from({"b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "z", "", " "})
while syl == " " do
syl = " " .. string.upper(string.char(string.byte("a")+crawl.random2(26)))
end
return syl
end

function rand_vocables()
local voc = util.random_from({"a", "e", "i", "o", "u", "y"})
return voc
end

function rand_name()
local name = string.upper(rand_letter())
while string.len(name) < crawl.random2(8)+4 do
name = name .. rand_syllables() .. rand_vocables() .. rand_letter()
end
return name
end

function random_custom()
local color = randcol()
crawl.mpr("<" .. color .. ">" .. crawl.random2(crawl.c_input_line())+1 .. "</" .. color .. ">")
end

function prefgod()
local rcol = crawl.random2(26)+1
if you.class() == "Berserker" then
rcol = 18
end
if you.class() == "Chaos Knight" then
rcol = 22
end
if you.class() == "Abyssal Knight" then
rcol = 11
end
if you.race() == "Demigod" then
rcol = 26
end
if not(you.race() == "Hill Orc") and rcol == 2 then
rcol = 26
end
if rcol == 1 then
crawl.take_note("Preferred God: Ashenzari.")
end
if rcol == 2 then
crawl.take_note("Preferred God: Beogh")
end
if rcol == 3 then
crawl.take_note("Preferred God: Cheibriados.")
end
if rcol == 4 then
crawl.take_note("Preferred God: Dithmenos.")
end
if rcol == 5 then
crawl.take_note("Preferred God: Elyvilon.")
end
if rcol == 6 then
crawl.take_note("Preferred God: Fedhas.")
end
if rcol == 7 then
crawl.take_note("Preferred God: Gozag.")
end
if rcol == 8 then
crawl.take_note("Preferred God: Hepliaklqana.")
end
if rcol == 9 then
crawl.take_note("Preferred God: Jiyva.")
end
if rcol == 10 then
crawl.take_note("Preferred God: Kikubaaqudgha.")
end
if rcol == 11 then
crawl.take_note("Preferred God: Lugonu.")
end
if rcol == 12 then
crawl.take_note("Preferred God: Makhleb.")
end
if rcol == 13 then
crawl.take_note("Preferred God: Nemelex Xobeh.")
end
if rcol == 14 then
crawl.take_note("Preferred God: Okawaru.")
end
if rcol == 15 then
crawl.take_note("Preferred God: Qazlal.")
end
if rcol == 16 then
crawl.take_note("Preferred God: Ru.")
end
if rcol == 17 then
crawl.take_note("Preferred God: Sif Muna.")
end
if rcol == 18 then
crawl.take_note("Preferred God: Trog.")
end
if rcol == 19 then
crawl.take_note("Preferred God: Uskayaw.")
end
if rcol == 20 then
crawl.take_note("Preferred God: Vehumet.")
end
if rcol == 21 then
crawl.take_note("Preferred God: Wu Jian.")
end
if rcol == 22 then
crawl.take_note("Preferred God: Xom.")
end
if rcol == 23 then
crawl.take_note("Preferred God: Yredelemnul.")
end
if rcol == 24 then
crawl.take_note("Preferred God: Zin.")
end
if rcol == 25 then
crawl.take_note("Preferred God: The Shining One.")
end
if rcol == 26 then
crawl.take_note("Preferred God: No God.")
end
end

function char_appearance(name, hairstyle, body, haircolorstring, hairlengthstring, gender, eyebrows, eyes, voice, beard, tattoo, tattoo_placement)
if (tattoo == nil) or (tattoo == "") and (crawl.random2(100) > 75) or (tattoo == "random") then
tattoo = randcol() .. " " .. util.random_from({"arrow", "arbalest", "spear", "shield", "fireball", "potion", "goblet", "axe", "sword", "dagger", "hammer", "skull", "skeleton", "spikes", "meaningless", "butterfly", "flower", "horn", "hoof", "snake", "wolf", "hound", "star", "triangle", "circle", "letter", "man", "woman", "dragon", "heart", "wings", "spikes", "roses", "unicorn"})
end
if (tattoo_placement == nil) or (tattoo_placement == "") then
tattoo_placement = util.random_from({"groin", "shoulder", "thigh", "butt", "neck", "chest", "hand", "arm", "leg", "face", "stomach", "foot"})
end

if (you.race() == "Draconian" or you.race() == "Merfolk" or you.race() == "Naga" or you.race() == "Barachi")and(hairstyle == nil or hairstyle == "") then
hairstyle = util.random_from({"frills", "spikes", "decorated spikes"})
beard = util.random_from({"tentacles", "shaved beard"})
end

if (you.race() == "Demonspawn")and(hairstyle == nil or hairstyle == "") then
hairstyle = util.random_from({"horns", "horn", "spikes", "decorated spikes"})
beard = util.random_from({"chin horns", "chin spikes"})
end

if (you.race() == "Vine Stalker" or you.race() == "Spriggan")and(hairstyle == nil or hairstyle == "") then
hairstyle = "" .. util.random_from({"leaves", "branches", "thorns", "mushrooms", "flowers", "tangles", "berries"}) .. " all over their body"
beard = util.random_from({"leaves", "branches", "thorns", "mushrooms", "flowers", "tangles", "berries"}) .. " all over their face"
hairlengthstring = util.random_from({"small", "medium-sized", "large", "huge", "colossal"})
end

if (you.race() == "Deep Dwarf") and (beard == nil or beard == "") then
beard = util.random_from({"beard", "long beard", "short beard"})
end

if (you.race() == "Tengu") and(hairstyle == nil or hairstyle == "") then
hairlengthstring = util.random_from({"small", "medium-sized", "large", "huge", "colossal"})
hairstyle = util.random_from({"flight feathers", "contour feathers", "down feathers", "bristle feathers", "plumed feathers"})
beard = util.random_from({"hooked beak", "cone shaped beak", "curved beak", "straight beak", "thin beak", "wide beak", "strong beak"})
end

if (you.race() == "Formicid") and(hairstyle == nil or hairstyle == "") then
hairlengthstring = util.random_from({"small", "medium-sized", "large", "huge", "colossal"})
hairstyle = util.random_from({"thread-like antennae", "beaded antennae", "sawtoothed antennae", "bristle-like antennae", "comb-like antennae"})
beard = util.random_from({"pair of chewing mandibles", "pair of stylets", "pair of long mandibles", "pair of hardened mandibles", "pair of large mandibles", "pair of piercing mandibles", "pair of strong mandibles"})
end

if you.race() == "Felid" then
hairlengthstring = util.random_from({"short", "short striped", "short spotted", "medium-length striped", "medium-length", "medium-length spotted", "long", "long striped", "long spotted"})
hairstyle = util.random_from({"fur", "hairless skin"})
beard = util.random_from({"pair of whiskers", "pair of short whiskers", "pair of broken whiskers"})
if (tattoo == nil) or (tattoo == "") and (crawl.random2(100) > 75) then
tattoo = randcol() .. " " .. util.random_from({"solid cat marking", "point cat marking", "van cat marking", "tabby cat marking", "tortie cat marking"})
tattoo_placement = util.random_from({"body", "feet"})
end
end

if (you.race() == "Deep Elf")and(beard == nil or beard == "") then
beard = "shaved beard"
end

if (hairstyle == "") or (hairstyle == nil) then
hairstyle = util.random_from({"ponytail", "mohawk", "twintail", "topknot", "curly hair", "wavy hair", "straight hair", "dreadlock", "pompadour", "afro", "braid", "hair", "spiky hair", "bun", "double buns hair", "pigtail", "mullet", "reverse mohawk", "combed hair", "tonsure"})
end

if (beard == nil) or (beard == "") then
beard = util.random_from({"moustache", "beard", "goatee", "long beard", "short beard", "shaved beard", "sideburns beard", "whiskers beard", "neckbeard"})
end

if you.race() == "Gargoyle" or you.race() == "Ghoul" or you.race() == "Spriggan" or you.race() == "Vine Stalker" or you.race() == "Demigod" or you.race() == "Mummy" then
eyes = "" .. util.random_from({"glowing ", "glimmering ", "shimmering ", "shining ", "sparkling "}) .. randcol() .. ""
end
if (body == "") or (body == nil) then
body = util.random_from({"fat", "muscular", "slender", "emaciated", "obese", "average"})
end
if (haircolorstring == "") or (haircolorstring == nil) then
haircolorstring = randcol()
end
if (hairlengthstring == "") or (hairlengthstring == nil) then
hairlengthstring = util.random_from({"bald", "short", "medium-length", "long", "very long"})
end
if (gender == "") or (gender == nil) then
gender = util.random_from({"masculine", "feminine", "ambiguous"})
end
if (eyebrows == "") or (eyebrows == nil) then
eyebrows = util.random_from({"thick", "bushy", "thin"})
end
if (eyes == "") or (eyes == nil) then
eyes = "" .. util.random_from({"round ", "broad ", "narrow ", ""}) .. randcol() .. ""
end
if (voice == "") or (voice == nil) then
voice = util.random_from({"low", "high", "clear"})
end
if hairlengthstring == "bald" then
hairstyle = "hair"
end
if you.race() == "Ogre" then
body = "fat"
end
if you.race() == "Troll" then
body = "muscular"
end
if you.race() == "Ghoul" then
body = "emaciated"
end
crawl.mpr("" .. name .. " has ".. crawl.article_a("" ..   haircolorstring .. " " .. hairlengthstring .. " " .. hairstyle .. "") .. ".")

if (gender == "masculine") or you.race() == "Tengu" then
crawl.mpr("" .. name .. " has " .. crawl.article_a("" .. haircolorstring .. " " .. beard .. "") .. ".")
crawl.more()
end

crawl.more()
crawl.mpr("" .. name .. " has " .. eyebrows .. " " .. haircolorstring .. " eyebrows.")
crawl.more()
crawl.mpr("" .. name .. " has " .. eyes .. " eyes.")
crawl.more()
crawl.mpr("" .. name .. " has " .. crawl.article_a("" .. body .. " " .. gender .. "") .. " body.")
crawl.more()
if not(tattoo == "empty") and not(tattoo == "") and not(tattoo == nil) then
crawl.mpr("" .. name .. " has a tattoo of " .. tattoo .. " on their " .. tattoo_placement .. ".")
crawl.more()
end
crawl.mpr("" .. name .. " has " .. crawl.article_a(voice) .. " voice.")
local res =crawl.yesno("Is this you?")
if not (res == true) then
crawl.clear_messages()
crawl.mpr("What would you like to change?")
crawl.more()
crawl.mpr("a) - hairstyle")
crawl.mpr("b) - body")
crawl.mpr("c) - hair color")
crawl.mpr("d) - hair length")
crawl.mpr("e) - gender")
crawl.mpr("f) - eyebrows")
crawl.mpr("g) - eyes")
crawl.mpr("h) - voice")
crawl.mpr("j) - beard")
crawl.mpr("k) - tattoo")
crawl.mpr("l) - tattoo placement")
crawl.mpr("m) - everything ")
res = crawl.c_input_line()
if (res == "a") then
crawl.clear_messages()
crawl.mpr("Current hairstyle: " .. hairstyle)
crawl.mpr("Please, enter new hairstyle (leave blank for random)")
hairstyle = crawl.c_input_line()
end
if (res == "b") then
crawl.clear_messages()
crawl.mpr("Current body: " .. body)
crawl.mpr("Please, enter new body shape (leave blank for random)")
body = crawl.c_input_line()
end
if (res == "c") then
crawl.clear_messages()
crawl.mpr("Current hair color: " .. haircolorstring)
crawl.mpr("Please, enter new hair color (leave blank for random)")
haircolorstring = crawl.c_input_line()
end
if (res == "d") then
crawl.clear_messages()
crawl.mpr("Current hair length: " .. hairlengthstring)
crawl.mpr("Please, enter new hair length (leave blank for random)")
hairlengthstring = crawl.c_input_line()
end
if (res == "e") then
crawl.clear_messages()
crawl.mpr("Current gender: " .. gender)
crawl.mpr("Please, enter new gender (leave blank for random)")
gender = crawl.c_input_line()
end
if (res == "f") then
crawl.clear_messages()
crawl.mpr("Current eyebrows: " .. eyebrows)
crawl.mpr("Please, enter new eyebrows (leave blank for random)")
eyebrows = crawl.c_input_line()
end
if (res == "g") then
crawl.clear_messages()
crawl.mpr("Current eyes: " .. eyes)
crawl.mpr("Please, enter new eyes (leave blank for random)")
eyes = crawl.c_input_line()
end
if (res == "h") then
crawl.clear_messages()
crawl.mpr("Current voice: " .. voice)
crawl.mpr("Please, enter new voice (leave blank for random)")
voice = crawl.c_input_line()
end
if (res == "j") then
crawl.clear_messages()
crawl.mpr("Current beard: " .. beard)
crawl.mpr("Please, enter new beard (leave blank for random)")
beard = crawl.c_input_line()
end
if (res == "k") then
crawl.clear_messages()
crawl.mpr("Current tattoo: " .. tattoo)
crawl.mpr("Please, enter new tattoo (type 'random' for random, type 'empty' to remove)")
tattoo = crawl.c_input_line()
end
if (res == "l") then
crawl.clear_messages()
crawl.mpr("Current tattoo location: " .. tattoo_placement)
crawl.mpr("Please, enter new tattoo placement (leave blank for random)")
tattoo_placement = crawl.c_input_line()
end
if (res == "m") then
crawl.clear_messages()
hairstyle = ""
body = ""
haircolorstring = ""
hairlengthstring = ""
gender = ""
eyebrows = ""
eyes = ""
voice = ""
beard = ""
tattoo = ""
tattoo_placement = ""
end
char_appearance(name, hairstyle, body, haircolorstring, hairlengthstring, gender, eyebrows, eyes, voice, beard, tattoo, tattoo_placement)
end
if (res == true) then
crawl.take_note("+++========================+++")
crawl.take_note("" .. name .. " has ".. crawl.article_a("" ..   haircolorstring .. " " .. hairlengthstring .. " " .. hairstyle .. "") .. ".")
if gender == "masculine" then
crawl.take_note("" .. name .. " has " .. crawl.article_a("" .. haircolorstring .. " " .. beard .. "") .. ".")
end
crawl.take_note("" .. name .. " has " .. eyebrows .. " " .. haircolorstring .. " eyebrows.")
crawl.take_note("" .. name .. " has " .. eyes .. " eyes.")
crawl.take_note("" .. name .. " has " .. crawl.article_a("" .. body .. " " .. gender .. "") .. " body.")
crawl.take_note("" .. name .. " has " .. crawl.article_a(voice) .. " voice.")
if not(tattoo == "empty") and not(tattoo == "") and not(tattoo == nil) then
crawl.take_note("" .. name .. " has a tattoo of " .. tattoo .. " on their " .. tattoo_placement .. ".")
end
crawl.take_note("+++========================+++")
end
end

function length()
local length = string
local rand = crawl.random2(100)+1
if rand < 34 then
length = "short "
end
if rand > 65 then
length = "long "
end
if rand > 33 and rand < 66 then
length = ""
end
return length
end

function randcol()
local rand = crawl.random2(15)+1
local color = string
if rand == 1 then
color = "red"
end
if rand == 2 then
color = "lightred"
end
if rand == 3 then
color = "blue"
end
if rand == 4 then
color = "lightblue"
end
if rand == 5 then
color = "green"
end
if rand == 6 then
color = "lightgreen"
end
if rand == 7 then
color = "white"
end
if rand == 8 then
color = "yellow"
end
if rand == 9 then
color = "brown"
end
if rand == 10 then
color = "magenta"
end
if rand == 11 then
color = "lightmagenta"
end
if rand == 12 then
color = "lightgrey"
end
if rand == 13 then
color = "darkgrey"
end
if rand == 14 then
color = "cyan"
end
if rand == 15 then
color = "lightcyan"
end
return color
end

function randlocation()
local site = util.random_from({"Cave", "Underground", "Town", "Ruins", "Fortress", "Cove", "Tower", "Jail", "Camp", "Graveyard", "Mine", "Mountains", "Plains", "Manor", "Basement", "Cellar", "Village", "Tavern", "Inn", "Forge", "Keep", "Forest", "Swamp", "Hideout", "Prison", "Temple", "Crucible", "Garden", "Market", "Mound", "Hall"})
local color = crawl.random2(15)+1
local natives = rand_race()
local site_name = rand_name()
local rank = util.random_from({"Weakling", "Amateur", "Novice", "Journeyman", "Adept", "Veteran", "Master", "Legendary"})
local job = util.random_from({"Noble", "Peasant", "Slave", "Guard", "Cook", "Wood Cutter", "Digger", "Thief", "Scout", "Warrior", "Soldier", "Smuggler", "Farmer", "Builder", "Mason", "Jeweller", "Blacksmith", "Carpenter",  "Merchant", "Gambler", "Trader", "Dancer", "Comedian", "Keeper", "Healer", "Priest", "Speaker", "Bandit", "Observer", "Ambusher", "Tracker", "Butcher", "Tailor", "Poet", "Musician", "Singer", ""})
if job == "" or crawl.random2(100) > 70 then
job = you.class()
end
crawl.sendkeys("!<" .. color .. ">" .. site_name .. ", " .. natives .. " " .. site .. "</" .. color .. ">")
crawl.sendkeys("\r")
crawl.mpr("You have found <" .. color .. ">" .. site_name .. ", " .. natives .. " " .. site .. "</" .. color .. ">.")
--crawl.take_note("Noticed " .. string.lower(crawl.article_a(natives)) .. "")
if you.race() == natives or (crawl.random2(100)+you.xl() > crawl.random2(85)) then
--crawl.take_note("Joined " .. site_name)
--crawl.take_note("Job: " .. rank .. " " .. job)
end
end

function rand_race()
local race = util.random_from({"Hill Orc", "Minotaur", "Merfolk", "Gargoyle", "Draconian", "Halfling", "Troll", "Ghoul", "Human", "Kobold", "Demonspawn", "Centaur", "Spriggan", "Tengu", "Deep Elf", "Ogre", "Deep Dwarf", "Gnoll", "Vine Stalker", "Vampire", "Demigod", "Formicid", "Naga", "Octopode", "Felid", "Barachi", "Mummy"})
return race
end

function randitem()
local color = crawl.random2(15)+1
local armor = items.equipped_at("Armour")
local weap = items.equipped_at("Weapon")
local shield = items.equipped_at("Shield")
local helm = items.equipped_at("Helmet")
local gloves = items.equipped_at("Gloves")
local boots = items.equipped_at("Boots")
local cloak = items.equipped_at("Cloak")
if armor and string.find(armor.name(), "pearl dragon") then color = "lightgrey"
end
if armor and string.find(armor.name(), "storm dragon") then color = "lightblue"
end
if armor and string.find(armor.name(), "iron dragon") then color = "cyan"
end
if armor and string.find(armor.name(), "gold dragon") then color = "yellow"
end
if armor and string.find(armor.name(), "ice dragon") then color = "white"
end
if armor and string.find(armor.name(), "quicksilver dragon") then color = "lightcyan"
end
if armor and string.find(armor.name(), "steam dragon") then color = "blue"
end
if armor and string.find(armor.name(), "acid dragon") then color = "green"
end
if armor and string.find(armor.name(), "fire dragon") then color = "lightred"
end
if armor and string.find(armor.name(), "swamp dragon") then color = "brown"
end
if armor and string.find(armor.name(), "shadow dragon") then color = "magenta"
end
if armor and armor.inscription == "" then
local armor_name = armor.name("base")
if string.find(armor:name(), "robe") then
armor_name = "" .. util.random_from({"robe", "sleeveless robe", "collared robe", "collared shirt", "jumpsuit", "suit", "tunic", "vest", "coat", "doublet", "apron", "tank top", "harness", "long shirt", "shirt", "cloth rags", "wound dressing", "waistcoat", "bra", "dress", "sweater", "hooded robe"}) .. ", " .. util.random_from({"kilt", "skirt", "panties", "tight pants", "baggy pants", "shorts", "chonglers", "thong", "boxers", "loincloth", "pants", "socks", "high socks", "long socks", "stockings", "fishnet stockings", "pantyhose", "tie"})
end
if string.find(armor:name(), "leather armour") then
armor_name = util.random_from({"leather armour", "studded armour", "quilted armour", "leather coat", "trellised armour"})
end
if string.find(armor:name(), "ring mail") then
armor_name = util.random_from({"ring mail", "breast plate", "cuirass", "light mail", "linked mail"})
end
if string.find(armor:name(), "scale mail") then
armor_name = util.random_from({"scale mail", "splint mail", "hauberk", "laced mail", "tigulated mail", "loricated mail"})
end
if string.find(armor:name(), "chain mail") then
armor_name = util.random_from({"chain mail", "field plate", "brigandine mail", "mesh armour", "russet armour"})
end
if string.find(armor:name(), "plate armour") then
armor_name = util.random_from({"plate armour", "ornate armour", "gothic plate", "full plate mail", "templar coat", "embossed plate", "lacquered plate"})
end
if not armor.branded == nil or armor.plus > 0 and not string.find(armor:name(), "robe") then
armor_name = rand_material() .. " " .. armor_name
end
if not armor.branded == nil or armor.plus > 0 and string.find(armor:name(), "robe") then
armor_name = util.random_from({"striped", "spotted", "checkered", "plaid"}) .. " " .. armor_name
end
crawl.sendkeys("{" .. items.index_to_letter(armor.slot) .. "<" .. color .. ">" .. armor_name .. "</" .. color .. ">")
crawl.sendkeys("\r")
end
if weap and weap.inscription == "" then
color = crawl.random2(15)+1
local weapon_name = weap.name("base")
if string.find(weap:name(), "dagger") then
weapon_name = util.random_from({"kris", "blade", "dagger", "claws", "knife", "dirk", "stiletto", "dual blade", "balanced knife", "tanto", "wrist spike", "poignard", "rondel", "jambiya", "quhab", "fascia", "cestus", "katar", "hand scythe", "war fist", "scissors"})
end
if string.find(weap:name(), "short sword") then
weapon_name = util.random_from({"gladius", "short sword", "cutlass", "saber", "war sword", "ataghan", "falcata", "wakizashi"})
end
if string.find(weap:name(), "long sword") then
weapon_name = util.random_from({"long sword", "katana", "broad sword", "daikatana"})
end
if string.find(weap:name(), "falchion") then
weapon_name = util.random_from({"falchion", "machete", "shamshir", "tulwar"})
end
if string.find(weap:name(), "great sword") then
weapon_name = util.random_from({"great sword", "claymore", "flamberge", "zweihander", "espadon"})
end
if string.find(weap:name(), "mace") then
weapon_name = util.random_from({"mace", "hammer", "maul", "scepter", "cudgel", "truncheon"})
end
if string.find(weap:name(), "hand axe") then
weapon_name = util.random_from({"hand axe", "hatchet", "axe", "pickaxe", "francisca", "tomahawk", "cleaver"})
end
if string.find(weap:name(), "war axe") then
weapon_name = util.random_from({"war axe", "double axe", "balanced axe", "tabar"})
end
if string.find(weap:name(), "giant spiked club") then
weapon_name = util.random_from({"giant spiked club", "nail board", "dragon tail"})
end
if string.find(weap:name(), "giant club") then
weapon_name = util.random_from({"giant club", "rebar club", "dragon tooth", "monstrous maul"})
end
if string.find(weap:name(), "club") then
weapon_name = util.random_from({"club", "spiked club", "shovel", "torch"})
end
if string.find(weap:name(), "whip") then
weapon_name = util.random_from({"whip", "chain", "hook", "rope"})
end
if string.find(weap:name(), "spear") then
weapon_name = util.random_from({"spear", "pike", "harpoon", "spetum", "brandistock", "lance", "war spear", "yari"})
end
if string.find(weap:name(), "halberd") then
weapon_name = util.random_from({"halberd", "voulge", "poleaxe", "partizan", "bill"})
end
if string.find(weap:name(), "scythe") then
weapon_name = util.random_from({"scythe", "war scythe", "battle scythe", "thresher"})
end
if string.find(weap:name(), "shortbow") then
weapon_name = util.random_from({"shortbow", "hunter bow", "razor bow", "rune bow"})
end
if string.find(weap:name(), "longbow") then
weapon_name = util.random_from({"longbow", "composite bow"})
end
if string.find(weap:name(), "dart") then
weapon_name = util.random_from({"dart", "throwing dagger", "throwing star", "shuriken", "needle"})
end
if string.find(weap:name(), "javelin") then
weapon_name = util.random_from({"javelin", "pilum", "short spear", "throwing spear", "simbilan", "spiculum"})
end
if string.find(weap:name(), "throwing net") then
weapon_name = util.random_from({"throwing net", "hand net", "cast net", "butterfly net"})
end
if not(weap.plus == nil) and (weap.plus > 0) then
weapon_name = rand_material() .. " " .. weapon_name
end
crawl.sendkeys("{" .. items.index_to_letter(weap.slot) .. "<" .. color .. ">" .. weapon_name .. "</" .. color .. ">")
crawl.sendkeys("\r")
end
if shield and shield.inscription == "" then
color = crawl.random2(15)+1
local shield_name = shield.name("base")
if string.find(shield:name(), "buckler") then
shield_name = util.random_from({"buckler", "small shield", "defender", "heater"})
end
if string.find(shield:name(), "shield") then
shield_name = util.random_from({"shield", "spiked shield", "triangular shield", "round shield", "hyperion"})
end
if string.find(shield:name(), "large shield") or string.find(shield:name(), "kite shield") or string.find(shield:name(), "tower shield") then
shield_name = util.random_from({"large shield", "tower shield", "gothic shield", "kite shield", "pavise", "aegis"})
end
if not shield.branded == nil or shield.plus > 0 then
shield_name = rand_material() .. " " .. shield_name
end
crawl.sendkeys("{" .. items.index_to_letter(shield.slot) .. "<" .. color .. ">" .. shield_name .. "</" .. color .. ">")
crawl.sendkeys("\r")
end
if helm and helm.inscription == "" then
color = crawl.random2(15)+1
local helm_name = helm.name("base")
if string.find(helm:name(), "helmet") then
helm_name = util.random_from({"winged helmet", "horned helmet", "crested helmet", "plumed helmet", "spiked helmet", "visored helmet", "basinet", "crown", "helm", "full helm", "helmet", "casque"})
end
if string.find(helm:name(), "hat") then
helm_name = util.random_from({"hat", "cap", "hood", "mask", "bandana", "headband", "tiara", "circlet", "diadem", "fedora", "tricorne hat", "bowler hat", "cowboy hat", "feathered hat", "wizard hat"})
end
if not helm.branded == nil or helm.plus > 0 and not string.find(helm:name(), "hat") then
helm_name = rand_material() .. " " .. helm_name
end
if not helm.branded == nil or helm.plus > 0 and string.find(helm:name(), "hat") then
helm_name = util.random_from({"striped", "spotted", "checkered", "plaid"}) .. " " .. helm_name
end
crawl.sendkeys("{" .. items.index_to_letter(helm.slot) .. "<" .. color .. ">" .. helm_name .. "</" .. color .. ">")
crawl.sendkeys("\r")
end
if gloves and gloves.inscription == "" then
color = crawl.random2(15)+1
local gloves_name = util.random_from({"gloves", "gauntlets", "handwraps", "bracers", "armbands", "shackles", "cuffs"})
if not gloves.branded == nil or gloves.plus > 0 then
gloves_name = rand_material() .. " " .. gloves_name
end
crawl.sendkeys("{" .. items.index_to_letter(gloves.slot) .. "<" .. color .. ">" .. gloves_name .. "</" .. color .. ">")
crawl.sendkeys("\r")
end
if cloak and cloak.inscription == "" then
color = crawl.random2(15)+1
local cloak_name = util.random_from({"cloak", "cape", "mantle", "shoulderpads", "epaulets", "pauldrons", "scarf", "tabard"})
if not cloak.branded == nil or cloak.plus > 0 then
cloak_name = rand_material() .. " " .. cloak_name
end
crawl.sendkeys("{" .. items.index_to_letter(cloak.slot) .. "<" .. color .. ">" .. cloak_name .. "</" .. color .. ">")
crawl.sendkeys("\r")
end
if boots and boots.inscription == "" then
color = crawl.random2(15)+1
local boots_name = util.random_from({"boots", "shoes", "sandals", "sabatons", "greaves"})
if not boots.branded == nil or boots.plus > 0 then
boots_name = rand_material() .. " " .. boots_name
end
crawl.sendkeys("{" .. items.index_to_letter(boots.slot) .. "<" .. color .. ">" .. boots_name .. "</" .. color .. ">")
crawl.sendkeys("\r")
end
end

function randinscribe()
crawl.mpr("Inscribe which item?")
crawl.flush_prev_message()
local res = string.char(crawl.getch())
local slot = items.letter_to_index(res)
local item = items.inslot(slot)
crawl.flush_prev_message()
crawl.mpr("Which color? (<1>1</1>,<2>2</2>,<3>3</3>,<4>4</4>,<5>5</5>,<6>6</6>,<7>7</7>,<8>8</8>,<9>9</9>,<10>10</10>,<11>11</11>,<12>12</12>,<13>13</13>,<14>14</14>,<15>15</15>)")
local color = crawl.c_input_line()
if (color == "") or (color == nil) then
color = crawl.random2(15)+1
end
if item and not (item.inscription == "") then
crawl.sendkeys("{" .. res)
crawl.sendkeys(string.char(string.byte("u") - string.byte("a") + 1))
crawl.sendkeys("<" .. color .. ">" .. item.inscription .. "</" .. color .. ">")
crawl.sendkeys("\r")
end
if item and item.inscription == "" then
crawl.sendkeys("{" .. res)
crawl.sendkeys(string.char(string.byte("u") - string.byte("a") + 1))
crawl.sendkeys("<" .. color .. ">" .. item.name() .. "</" .. color .. ">")
crawl.sendkeys("\r")
end
end

function rand_material()
local mat_suffix = util.random_from({"wood", "ivory", "bone", "silver", "gold", "platinum", "iron", "steel", "bronze", "brass",  "copper", "tin", "lead", "pewter", "granite", "marble", "jade", "glass", "emerald", "diamond", "sapphire", "amethyst", "ruby", "ebony", "topaz"})
return mat_suffix
end

function rand_enchant()
crawl.mpr("<magenta>Enchant which item?</magenta>")
crawl.flush_prev_message()
local res = string.char(crawl.getch())
local slot = items.letter_to_index(res)
local item = items.inslot(slot)
if item and ((item.plus == nil) or (item.plus == 0)) then
crawl.sendkeys("&t" .. res)
crawl.sendkeys("c" .. crawl.random2(25))
crawl.sendkeys("\r")
crawl.sendkeys("a" .. (crawl.random2(20)-10))
crawl.sendkeys("\r")
crawl.sendkeys("\r")
end
end

function persist_note_players()
if not c_persist.note or c_persist.note == "" then
c_persist.note = "Other players online: " .. you.name()
end
if not string.find(c_persist.note, you.name()) then
c_persist.note = c_persist.note .. "; " .. you.name()
end
crawl.mpr(c_persist.note)
end

function persist_note_default()
if c_persist.note then
crawl.mpr("Current note: " .. c_persist.note)
crawl.more()
crawl.mpr("Enter new note: ")
c_persist.note = crawl.c_input_line()
return
end
if not c_persist.note or c_persist.note == "" then
crawl.mpr("Enter new note: ")
c_persist.note = crawl.c_input_line()
return
end
end

function random_wall_color()
local wallcolour = util.random_from({"brown", "blue", "lightblue", "darkgrey", "lightgrey", "green", "lightgreen", "red", "lightred", "cyan", "lightcyan", "white", "yellow", "magenta", "lightmagenta"})
if wallcolour == "brown" then crawl.setopt("feature += rock wall { , , brown }")
end
if wallcolour == "blue" then crawl.setopt("feature += rock wall { , , blue }")
end
if wallcolour == "lightblue" then crawl.setopt("feature += rock wall { , , lightblue }")
end
if wallcolour == "darkgrey" then crawl.setopt("feature += rock wall { , , darkgrey }")
end
if wallcolour == "lightgrey" then crawl.setopt("feature += rock wall { , , lightgrey }")
end
if wallcolour == "green" then crawl.setopt("feature += rock wall { , , green }")
end
if wallcolour == "lightgreen" then crawl.setopt("feature += rock wall { , , lightgreen }")
end
if wallcolour == "red" then crawl.setopt("feature += rock wall { , , red }")
end
if wallcolour == "lightred" then crawl.setopt("feature += rock wall { , , lightred }")
end
if wallcolour == "cyan" then crawl.setopt("feature += rock wall { , , cyan }")
end
if wallcolour == "lightcyan" then crawl.setopt("feature += rock wall { , , lightcyan }")
end
if wallcolour == "white" then crawl.setopt("feature += rock wall { , , white }")
end
if wallcolour == "yellow" then crawl.setopt("feature += rock wall { , , yellow }")
end
if wallcolour == "magenta" then crawl.setopt("feature += rock wall { , , magenta }")
end
if wallcolour == "lightmagenta" then crawl.setopt("feature += rock wall { , , lightmagenta }")
end
end

function random_floor_color()
local floorcolour = util.random_from({"brown", "blue", "lightblue", "darkgrey", "lightgrey", "green", "lightgreen", "red", "lightred", "cyan", "lightcyan", "white", "yellow", "magenta", "lightmagenta"})
if floorcolour == "brown" then crawl.setopt("feature += floor { , , brown }")
end
if floorcolour == "blue" then crawl.setopt("feature += floor { , , blue }")
end
if floorcolour == "lightblue" then crawl.setopt("feature += floor { , , lightblue }")
end
if floorcolour == "darkgrey" then crawl.setopt("feature += floor { , , darkgrey }")
end
if floorcolour == "lightgrey" then crawl.setopt("feature += floor { , , lightgrey }")
end
if floorcolour == "green" then crawl.setopt("feature += floor { , , green }")
end
if floorcolour == "lightgreen" then crawl.setopt("feature += floor { , , lightgreen }")
end
if floorcolour == "red" then crawl.setopt("feature += floor { , , red }")
end
if floorcolour == "lightred" then crawl.setopt("feature += floor { , , lightred }")
end
if floorcolour == "cyan" then crawl.setopt("feature += floor { , , cyan }")
end
if floorcolour == "lightcyan" then crawl.setopt("feature += floor { , , lightcyan }")
end
if floorcolour == "white" then crawl.setopt("feature += floor { , , white }")
end
if floorcolour == "yellow" then crawl.setopt("feature += floor { , , yellow }")
end
if floorcolour == "magenta" then crawl.setopt("feature += floor { , , magenta }")
end
if floorcolour == "lightmagenta" then crawl.setopt("feature += floor { , , lightmagenta }")
end
end

function rand_follower()
local unit_type = util.random_from({"orc", "orc wizard", "orc priest", "orc warrior", "orc knight", "orc warlord", "orc sorcerer", "demigod", "human", "halfling", "necromancer", "wizard", "death knight", "elf", "deep elf mage", "deep elf knight", "deep elf high priest", "deep elf archer", "deep elf demonologist", "deep elf sorcerer", "deep elf elementalist", "deep elf death mage", "deep elf annihilator", "deep elf master archer", "deep elf blademaster", "spriggan", "spriggan druid", "spriggan berserker", "spriggan air mage", "spriggan rider", "spriggan defender", "iron troll", "troll", "deep troll", "deep troll earth mage", "deep troll shaman", "kobold", "big kobold", "kobold demonologist", "barachi", "dwarf", "deep dwarf", "gnoll", "gnoll shaman", "gnoll sergeant", "demonspawn", "torturous demonspawn", "infernal demonspawn", "gelid demonspawn", "iron imp", "quasit", "shadow imp", "crimson imp", "guardian golem", "crystal guardian", "iron golem", "centaur", "centaur warrior", "naga", "naga ritualist", "naga mage", "naga warrior", "merfolk", "merfolk siren", "merfolk impaler", "merfolk javelineer", "merfolk aquamancer", "tengu reaver", "tengu", "tengu conjurer", "tengu warrior", "minotaur", "vine stalker", "octopode", "felid", "mummy", "ghoul", "draconian", "draconian monk", "draconian scorcher", "draconian knight", "draconian shifter", "draconian annihilator", "draconian stormcaller", "slave"})
crawl.sendkeys("&mpand")
crawl.sendkeys("\r")
crawl.sendkeys("x=F~" .. unit_type)
crawl.sendkeys("\r")
crawl.sendkeys("x")
end

function polymorph()
c_persist.poly_user = you.name()
crawl.mpr("Enter your custom glyph: ")
c_persist.poly_glyph = crawl.c_input_line()
crawl.more()
crawl.mpr("Enter your custom color: ")
c_persist.poly_color = crawl.c_input_line()
handle_polymorph()
end

function handle_polymorph()
crawl.setopt("mon_glyph += player : " .. c_persist.poly_glyph .. " " .. c_persist.poly_color)
end

function feature_placement()
crawl.sendkeys("&(")
end

function char_describe_mod()
crawl.sendkeys(":" .. you.name())
end

function drop_everything()
crawl.sendkeys("dabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
crawl.sendkeys("\r")
end

function build()
crawl.sendkeys("d1(")
crawl.sendkeys("\r")
crawl.sendkeys("xeex")
end

function freeplay()
crawl.sendkeys("&~R")
crawl.sendkeys("\r")
crawl.sendkeys("&" .. string.char(string.byte("r") - string.byte("a") + 1))
crawl.sendkeys("&G")
crawl.sendkeys("\r")
crawl.sendkeys("&Rc0")
crawl.sendkeys("\r")
end

function spawn_random()
crawl.sendkeys("&Woka")
crawl.sendkeys("\r")
crawl.sendkeys("&cdeg")
crawl.sendkeys("\r")
crawl.sendkeys("&aa")
crawl.sendkeys("&ab")
crawl.sendkeys("&ac")
crawl.sendkeys("&ad")
crawl.sendkeys("&ae")
crawl.sendkeys("&af")
crawl.sendkeys("&ag")
crawl.sendkeys("&ah")
crawl.sendkeys("&Xtele")
crawl.sendkeys("\r")
crawl.sendkeys("&k" .. you.xl()+1)
crawl.sendkeys("\r")
end

function randartize()
crawl.mpr("<lightcyan>Artificate which item?</lightcyan>")
crawl.flush_prev_message()
local res = string.char(crawl.getch())
local slot = items.letter_to_index(res)
local item = items.inslot(slot)
if item and ((item.artefact == nil) or (item.artefact == false)) then
crawl.sendkeys("&+" .. res)
crawl.sendkeys("\r")
end
end

function mod_amount()
crawl.mpr("<green>Dupe what item? (probably consumables?)</green>")
crawl.flush_prev_message()
local res = string.char(crawl.getch())
local slot = items.letter_to_index(res)
local item = items.inslot(slot)
if item then
crawl.sendkeys("&t" .. res)
crawl.sendkeys("d" .. (crawl.random2(20)+1))
crawl.sendkeys("\r")
crawl.sendkeys("\r")
end
end

function pseudobuy()
crawl.mpr("<lightgrey>Buy what?</lightgrey>")
crawl.flush_prev_message()
local buyitem = crawl.c_input_line()
crawl.take_note("Bought " .. buyitem .. " for " .. crawl.random2(100)+1 .. " gold pieces")
end

function pseudofight()
crawl.mpr("<lightred>Who do you want to notice?</lightred>")
crawl.flush_prev_message()
local enemyname = crawl.c_input_line()
crawl.take_note("Noticed " .. enemyname)
crawl.mpr("<lightred>Do you wanna kill it?</lightred>")
crawl.flush_prev_message()
local res = string.char(crawl.getch())
if res == "Y" or res == "y" then
crawl.take_note("Killed " .. enemyname)
end
end

function pseudoquest()
local obj = util.random_from({"mob", "obj"})
local mob_verb = util.random_from({"kill", "enslave", "paralyze", "charm",  "banish", "notice", "put to sleep", "capture (with a throwing net)"})
local obj_verb = util.random_from({"use", "obtain", "inscribe", "locate", "buy", "identify"})

local mob_list = util.random_from({"acid blob", "acid dragon", "adder", "air elemental", "alligator", "alligator snapping turtle", "anaconda", "ancestor", "ancient champion", "ancient lich", "ancient zyme", "angel", "apis", "apocalypse crab", "azure jelly", "ball lightning", "ball python", "ballistomycete", "ballistomycete spore", "balrug", "barachi", "basilisk", "bat", "battlemage", "battlesphere", "bennu", "big kobold", "black bear", "black draconian", "black mamba", "black sun", "blink frog", "blizzard demon", "block of ice", "blood saint", "bog body", "boggart", "bone dragon", "briar patch", "burning bush", "bush", "bullfrog", "butterfly", "cacodemon", "catoblepas", "caustic shrike", "centaur", "centaur warrior", "chaos spawn", "cherub", "corrupter", "<demonspawn>", "crawling corpse", "crimson imp", "crocodile", "crystal guardian", "curse skull", "curse toe", "cyclops", "daeva", "dart slug", "deathcap", "death cob", "death drake", "death knight", "death ooze", "death scarab", "death yak", "deep elf annihilator", "deep elf archer", "deep elf blademaster", "deep elf death mage", "deep elf demonologist", "deep elf elementalist", "deep elf high priest", "deep elf knight", "deep elf mage", "deep elf master archer", "deep elf sorcerer", "deep dwarf", "deep troll", "deep troll earth mage", "deep troll shaman", "demigod", "demonic crawler", "demonspawn", "diamond obelisk", "dire elephant", "doom hound", "draconian", "draconian annihilator", "draconian knight", "draconian monk", "draconian scorcher", "draconian shifter", "draconian stormcaller", "dream sheep", "drowned soul", "dryad", "dwarf", "earth elemental", "efreet", "eidolon", "eldritch tentacle", "eldritch tentacle segment", "electric golem", "electric eel", "elemental wellspring", "elephant", "elf", "emperor scorpion", "entropy weaver", "ettin", "eye of devastation", "eye of draining", "faun", "felid", "fire bat", "fire crab", "fire dragon", "fire elemental", "fire giant", "fire vortex", "flayed ghost", "floating eye", "flying skull", "freed slave", "frilled lizard", "formicid", "foxfire", "freezing wraith", "frost giant", "fulminant prism", "fungus", "gargoyle", "ghost crab", "ghost moth", "ghoul", "gelid demonspawn", "giant cockroach", "glowing orange brain", "glowing shapeshifter", "gnoll", "gnoll sergeant", "gnoll shaman", "goblin", "golden dragon", "golden eye", "great orb of eyes", "greater mummy", "green death", "green draconian", "grey draconian", "guardian golem", "guardian mummy", "guardian serpent", "halazid warlock", "halfling", "harpy", "hell beast", "hell hog", "hell hound", "hell knight", "hell rat", "hellephant", "hellion", "hellwing", "hexer", "hippogriff", "hobgoblin", "hog", "holy swine", "hound", "howler monkey", "hungry ghost", "hydra", "hyperactive ballistomycete", "ice beast", "ice devil", "ice dragon", "ice statue", "iguana", "imperial myrmidon", "infernal demonspawn", "insubstantial wisp", "iron dragon", "iron elemental", "iron giant", "iron golem", "iron imp", "iron troll", "ironbrand convoker", "ironheart preserver", "jackal", "jelly", "jiangshi", "juggernaut", "jumping spider", "killer bee", "knight", "kobold", "kobold demonologist", "komodo dragon", "kraken", "large abomination", "lava snake", "leopard gecko", "lich", "lightning spire", "lindwurm", "lorocyproca", "lost soul", "lurking horror", "macabre mass", "mana viper", "manticore", "meliai", "merfolk", "merfolk aquamancer", "merfolk avatar", "merfolk impaler", "merfolk javelineer", "merfolk siren", "minotaur", "molten gargoyle", "monstrous demonspawn", "moth of wrath", "mummy", "mummy priest", "mutant beast", "naga", "naga mage", "naga ritualist", "naga sharpshooter", "naga warrior", "nagaraja", "nameless horror", "necromancer", "necrophage", "neqoxec", "obsidian statue", "octopode", "ogre", "ogre mage", "oklob plant", "oklob sapling", "ooze", "ophan", "orange crystal statue", "orange demon", "orb of destruction", "orb of fire", "orb spider", "orc", "orc high priest", "orc knight", "orc priest", "orc sorcerer", "orc warlord", "orc warrior", "orc wizard", "pale draconian", "pandemonium lord", "peacekeeper", "pearl dragon", "phantasmal warrior", "phantom", "pillar of salt", "plant", "player ghost", "polar bear", "porcupine", "profane servitor", "program bug", "purple draconian", "quasit", "queen ant", "queen bee", "quicksilver dragon", "quokka", "ragged hierophant", "rakshasa", "rat", "raiju", "reaper", "red devil", "red draconian", "hornet", "redback", "revenant", "rime drake", "river rat", "the ", "rust devil", "salamander", "salamander mystic", "saltling", "satyr", "scorpion", "sea snake", "seraph", "servant of whispers", "shadow", "shadow demon", "shadow dragon", "shadow imp", "shadow wraith", "shambling mangrove", "shapeshifter", "shard shrike", "shining eye", "shock serpent", "silent spectre", "simulacrum", "sixfirhy", "skeletal warrior", "skeleton", "sky beast", "slave", "slime creature", "small abomination", "smoke demon", "snaplasher vine", "snaplasher vine segment", "snapping turtle", "soldier ant", "soul eater", "spark wasp", "spatial maelstrom", "spatial vortex", "spectral thing", "spectral weapon", "spellforged servitor", "sphinx", "spiny frog", "spriggan", "spriggan air mage", "spriggan berserker", "spriggan defender", "spriggan druid", "spriggan rider", "starcursed mass", "starspawn tentacle", "starspawn tentacle segment", "statue", "steam dragon", "stone giant", "storm dragon", "sun demon", "swamp dragon", "swamp drake", "swamp worm", "tarantella", "tengu", "tengu conjurer", "tengu reaver", "tengu warrior", "tentacle", "tentacle segment", "tentacled monstrosity", "tentacled starspawn", "thrashing horror", "titan", "thorn hunter", "toadstool", "toenail golem", "tormentor", "torpor snail", "torturous demonspawn", "training dummy", "troll", "twister", "two-headed ogre", "tyrant leech", "ufetubus", "ugly thing", "unseen horror", "ushabti", "vampire", "vampire bat", "vampire knight", "vampire mage", "vampire mosquito", "vault guard", "vault sentinel", "vault warden", "very ugly thing", "vine stalker", "wandering mushroom", "warg", "war gargoyle", "warmonger", "water elemental", "water moccasin", "water nymph", "white draconian", "white imp", "wight", "wind drake", "wizard", "wolf", "wolf spider", "worker ant", "worldbinder", "worm", "wraith", "wretched star", "wyvern", "yak", "yaktaur", "yaktaur captain", "yellow draconian", "ynoxinul", "zombie", "ghost", "moon troll", "lunar statue", "air elementalist statue", "antique lich", "archer statue", "bog mummy", "captured wizard", "charred statue", "conjurer statue", "deformed humanoid", "demonic plant", "dimme", "drunken dwarf", "earth elementalist statue", "fire elementalist statue", "flesh golem", "frost-covered statue", "ghost-faced bat", "giga bat", "greater air elemental", "ice bat", "kamikaze kobold", "mad acolyte of ", "malarious merfolk avatar", "master elementalist", "megabat", "microbat", "petrified plant", "phase bat", "phase spider", "pristine statue", "rotten bat", "sickly merfolk siren", "skeletal bat", "spriggan baker", "water elementalist statue", "witch", "withered plant", "zin angel", "zot statue", "giant anaconda", "greater orb of eyes", "naga warlord", "sulfuric acid blob", "vault guard captain", "large bag of meat", "meat berserker", "meat hydra", "meat beast", "sculptor of flesh", "destroyer", "accursed", "tyrant", "dread", "scourge", "observer", "wretched soul", "fleshlord", "vile"})

local item_list = util.random_from({"acid dragon scales", "amulet of faith", "amulet of guardian spirit", "amulet of inaccuracy", "amulet of magic regeneration", "amulet of nothing", "amulet of reflection", "amulet of regeneration", "amulet of the acrobat", "animal skin", "arbalest", "arrow", "bardiche", "battleaxe", "bolt", "book of air", "book of alchemy", "book of annihilations", "book of battle", "book of beasts", "book of burglary", "book of callings", "book of cantrips", "book of changes", "book of clouds", "book of conjurations", "book of death", "book of debilitation", "book of dreams", "book of fire", "book of fixed level", "book of fixed theme", "book of flames", "book of frost", "book of geomancy", "book of hexes", "book of ice", "book of maledictions", "book of minor magic", "book of misfortune", "book of necromancy", "book of party tricks", "book of power", "book of spatial translocations", "book of summonings", "book of the dragon", "book of the earth", "book of the sky", "book of the tempests", "book of the warp", "book of transfigurations", "book of unlife", "boomerang", "box of beasts ","broad axe", "buckler", "centaur barding", "chain mail", "chunk of flesh", "cloak", "club", "corpse", "crystal plate armour", "dagger", "dart", "decaying skeleton", "deck of destruction", "(or, if unlucky, at oneself).", "deck of escape", "deck of punishment", "deck of summoning", "demon blade", "demon trident", "demon whip", "dire flail", "double sword", "eggplant", "eudemon blade", "eveningstar", "executioner's axe", "falchion", "fen folio", "figurine of a ziggurat", "fire dragon scales", "flail", "fustibalus", "giant club", "giant spiked club", "glaive", "gold dragon scales", "gold piece", "grand grimoire", "great mace", "great sword", "halberd", "hand axe", "hand crossbow", "hat", "helmet", "horn of ","hunting sling", "ice dragon scales", "inedible chunk of flesh", "kite shield", "lajatang", "large rock", "leather armour", "lightning rod", "long sword", "longbow", "mace", "manual", "morningstar", "naga barding", "necronomicon", "orb of zot", "pair of boots", "pair of gloves", "pearl dragon scales", "phantom mirror", "phial of floods", "plate armour", "potion of ambrosia", "potion of berserk rage","potion of brilliance", "potion of cancellation", "potion of curing", "potion of degeneration", "potion of experience", "potion of flight", "potion of haste", "potion of heal wounds", "potion of invisibility", "potion of lignification", "potion of magic", "potion of might", "potion of mutation", "potion of resistance", "potion of stabbing", "quad damage", "quarterstaff", "quicksilver dragon scales", "quick blade", "rapier", "ration", "ring mail", "ring of dexterity", "ring of evasion", "ring of fire", "ring of flight", "ring of ice", "ring of intelligence", "ring of resist corrosion", "ring of attention", "ring of magical power", "ring of poison resistance", "ring of positive energy", "ring of protection", "ring of protection from cold", "ring of protection from fire", "ring of protection from magic", "ring of see invisible", "ring of slaying", "ring of stealth", "ring of strength", "ring of teleportation", "ring of wizardry", "robe", "rune of zot", "sacred scourge", "scale mail", "scarf", "scimitar", "scroll of acquirement", "scroll of amnesia", "scroll of blinking", "scroll of brand weapon", "scroll of enchant armour", "scroll of enchant weapon","scroll of fear", "scroll of fog", "scroll of holy word", "scroll of identify", "scroll of immolation", "scroll of magic mapping", "scroll of noise", "scroll of random uselessness", "scroll of remove curse", "scroll of silence", "scroll of summoning", "scroll of teleportation", "scroll of torment", "scroll of vulnerability", "scythe", "shortbow", "short sword", "sling bullet", "spear", "staff of air", "staff of cold", "staff of conjuration", "staff of death", "staff of earth", "staff of energy", "staff of fire", "staff of poison", "staff of summoning", "staff of wizardry", "steam dragon scales", "stone", "shadow dragon scales", "storm dragon scales", "swamp dragon scales", "throwing net", "tower shield", "tin of tremorstones", "trident", "triple crossbow", "triple sword", "trishula", "troll leather armour", "wand of acid", "wand of clouds", "wand of digging", "wand of disintegration", "wand of enslavement", "wand of flame", "wand of iceblast", "wand of paralysis", "wand of polymorph", "wand of random effects", "war axe", "whip", "young poisoner's handbook"})
local message = ""
if obj == "mob" then
message = "Gained Quest: " .. mob_verb .. " " .. mob_list .. ""
end
if obj == "obj" then
message = "Gained Quest: " .. obj_verb .. " " .. item_list .. ""
end
crawl.mpr(message)
local res =crawl.yesno("<blue>Do you want to write down this quest to your list of notes?</blue>")
if not(res == true) then
crawl.clear_messages()
end
if (res == true) then
crawl.take_note(message)
end
end

function pseudosurvive()
local hp, max_hp = you.hp()
local mob_list = util.random_from({"acid blob", "acid dragon", "adder", "air elemental", "alligator", "alligator snapping turtle", "anaconda", "ancestor", "ancient champion", "ancient lich", "ancient zyme", "angel", "apis", "apocalypse crab", "azure jelly", "ball lightning", "ball python", "ballistomycete", "ballistomycete spore", "balrug", "barachi", "basilisk", "bat", "battlemage", "battlesphere", "bennu", "big kobold", "black bear", "black draconian", "black mamba", "black sun", "blink frog", "blizzard demon", "block of ice", "blood saint", "bog body", "boggart", "bone dragon", "briar patch", "burning bush", "bush", "bullfrog", "butterfly", "cacodemon", "catoblepas", "caustic shrike", "centaur", "centaur warrior", "chaos spawn", "cherub", "corrupter", "<demonspawn>", "crawling corpse", "crimson imp", "crocodile", "crystal guardian", "curse skull", "curse toe", "cyclops", "daeva", "dart slug", "deathcap", "death cob", "death drake", "death knight", "death ooze", "death scarab", "death yak", "deep elf annihilator", "deep elf archer", "deep elf blademaster", "deep elf death mage", "deep elf demonologist", "deep elf elementalist", "deep elf high priest", "deep elf knight", "deep elf mage", "deep elf master archer", "deep elf sorcerer", "deep dwarf", "deep troll", "deep troll earth mage", "deep troll shaman", "demigod", "demonic crawler", "demonspawn", "diamond obelisk", "dire elephant", "doom hound", "draconian", "draconian annihilator", "draconian knight", "draconian monk", "draconian scorcher", "draconian shifter", "draconian stormcaller", "dream sheep", "drowned soul", "dryad", "dwarf", "earth elemental", "efreet", "eidolon", "eldritch tentacle", "eldritch tentacle segment", "electric golem", "electric eel", "elemental wellspring", "elephant", "elf", "emperor scorpion", "entropy weaver", "ettin", "eye of devastation", "eye of draining", "faun", "felid", "fire bat", "fire crab", "fire dragon", "fire elemental", "fire giant", "fire vortex", "flayed ghost", "floating eye", "flying skull", "freed slave", "frilled lizard", "formicid", "foxfire", "freezing wraith", "frost giant", "fulminant prism", "fungus", "gargoyle", "ghost crab", "ghost moth", "ghoul", "gelid demonspawn", "giant cockroach", "glowing orange brain", "glowing shapeshifter", "gnoll", "gnoll sergeant", "gnoll shaman", "goblin", "golden dragon", "golden eye", "great orb of eyes", "greater mummy", "green death", "green draconian", "grey draconian", "guardian golem", "guardian mummy", "guardian serpent", "halazid warlock", "halfling", "harpy", "hell beast", "hell hog", "hell hound", "hell knight", "hell rat", "hellephant", "hellion", "hellwing", "hexer", "hippogriff", "hobgoblin", "hog", "holy swine", "hound", "howler monkey", "hungry ghost", "hydra", "hyperactive ballistomycete", "ice beast", "ice devil", "ice dragon", "ice statue", "iguana", "imperial myrmidon", "infernal demonspawn", "insubstantial wisp", "iron dragon", "iron elemental", "iron giant", "iron golem", "iron imp", "iron troll", "ironbrand convoker", "ironheart preserver", "jackal", "jelly", "jiangshi", "juggernaut", "jumping spider", "killer bee", "knight", "kobold", "kobold demonologist", "komodo dragon", "kraken", "large abomination", "lava snake", "leopard gecko", "lich", "lightning spire", "lindwurm", "lorocyproca", "lost soul", "lurking horror", "macabre mass", "mana viper", "manticore", "meliai", "merfolk", "merfolk aquamancer", "merfolk avatar", "merfolk impaler", "merfolk javelineer", "merfolk siren", "minotaur", "molten gargoyle", "monstrous demonspawn", "moth of wrath", "mummy", "mummy priest", "mutant beast", "naga", "naga mage", "naga ritualist", "naga sharpshooter", "naga warrior", "nagaraja", "nameless horror", "necromancer", "necrophage", "neqoxec", "obsidian statue", "octopode", "ogre", "ogre mage", "oklob plant", "oklob sapling", "ooze", "ophan", "orange crystal statue", "orange demon", "orb of destruction", "orb of fire", "orb spider", "orc", "orc high priest", "orc knight", "orc priest", "orc sorcerer", "orc warlord", "orc warrior", "orc wizard", "pale draconian", "pandemonium lord", "peacekeeper", "pearl dragon", "phantasmal warrior", "phantom", "pillar of salt", "plant", "player ghost", "polar bear", "porcupine", "profane servitor", "program bug", "purple draconian", "quasit", "queen ant", "queen bee", "quicksilver dragon", "quokka", "ragged hierophant", "rakshasa", "rat", "raiju", "reaper", "red devil", "red draconian", "hornet", "redback", "revenant", "rime drake", "river rat", "the ", "rust devil", "salamander", "salamander mystic", "saltling", "satyr", "scorpion", "sea snake", "seraph", "servant of whispers", "shadow", "shadow demon", "shadow dragon", "shadow imp", "shadow wraith", "shambling mangrove", "shapeshifter", "shard shrike", "shining eye", "shock serpent", "silent spectre", "simulacrum", "sixfirhy", "skeletal warrior", "skeleton", "sky beast", "slave", "slime creature", "small abomination", "smoke demon", "snaplasher vine", "snaplasher vine segment", "snapping turtle", "soldier ant", "soul eater", "spark wasp", "spatial maelstrom", "spatial vortex", "spectral thing", "spectral weapon", "spellforged servitor", "sphinx", "spiny frog", "spriggan", "spriggan air mage", "spriggan berserker", "spriggan defender", "spriggan druid", "spriggan rider", "starcursed mass", "starspawn tentacle", "starspawn tentacle segment", "statue", "steam dragon", "stone giant", "storm dragon", "sun demon", "swamp dragon", "swamp drake", "swamp worm", "tarantella", "tengu", "tengu conjurer", "tengu reaver", "tengu warrior", "tentacle", "tentacle segment", "tentacled monstrosity", "tentacled starspawn", "thrashing horror", "titan", "thorn hunter", "toadstool", "toenail golem", "tormentor", "torpor snail", "torturous demonspawn", "training dummy", "troll", "twister", "two-headed ogre", "tyrant leech", "ufetubus", "ugly thing", "unseen horror", "ushabti", "vampire", "vampire bat", "vampire knight", "vampire mage", "vampire mosquito", "vault guard", "vault sentinel", "vault warden", "very ugly thing", "vine stalker", "wandering mushroom", "warg", "war gargoyle", "warmonger", "water elemental", "water moccasin", "water nymph", "white draconian", "white imp", "wight", "wind drake", "wizard", "wolf", "wolf spider", "worker ant", "worldbinder", "worm", "wraith", "wretched star", "wyvern", "yak", "yaktaur", "yaktaur captain", "yellow draconian", "ynoxinul", "zombie", "ghost", "moon troll", "lunar statue", "air elementalist statue", "antique lich", "archer statue", "bog mummy", "captured wizard", "charred statue", "conjurer statue", "deformed humanoid", "demonic plant", "dimme", "drunken dwarf", "earth elementalist statue", "fire elementalist statue", "flesh golem", "frost-covered statue", "ghost-faced bat", "giga bat", "greater air elemental", "ice bat", "kamikaze kobold", "mad acolyte of ", "malarious merfolk avatar", "master elementalist", "megabat", "microbat", "petrified plant", "phase bat", "phase spider", "pristine statue", "rotten bat", "sickly merfolk siren", "skeletal bat", "spriggan baker", "water elementalist statue", "witch", "withered plant", "zin angel", "zot statue", "giant anaconda", "greater orb of eyes", "naga warlord", "sulfuric acid blob", "vault guard captain", "large bag of meat", "meat berserker", "meat hydra", "meat beast", "sculptor of flesh", "destroyer", "accursed", "tyrant", "dread", "scourge", "observer", "wretched soul", "fleshlord", "vile"})
crawl.mpr("<red>You are being attacked by: " .. mob_list .. "</red>")
local res =crawl.yesno("<lightred>Do you want to be attacked by this enemy?</lightred>")
if not(res == true) then
crawl.clear_messages()
end
if (res == true) then
crawl.take_note("HP: 1/" .. max_hp .. " [" .. mob_list .. " (" .. crawl.random2(hp/2)+1 .. ")]")
end
end

function pseudoidentify()
crawl.mpr("<darkgrey>Please, type the name of 'item' you want to note, get and identify.</darkgrey>")
local item = crawl.c_input_line()
if item and not (item == "") then
crawl.take_note("Got " .. crawl.article_a(item))
crawl.sendkeys(".")
crawl.take_note("Identified the " .. item .. " (You found it on " .. you.where() .. ")")
end
end

function embark()
local background = util.random_from({"You grew up without any inconveniences.", "You were raised by a different race.", "You were used for experimentation.", "You have amnesia.", "You were a faithful servant.", "You destroyed your own hometown, for various reasons.", "For some reason, you were asleep for a long time.", "You were a local lord.", "You were brought up as a family heir.", "You actually come from the future.", "You were loved by everyone.", "You've been abused since childhood.", "You were detested and abandoned as a child.", "Your family line is that of famous mages.", "You were a prisoner for a long time.", "You were a member of a royal family.", "Your birth was a secret.", "You were a slave.", "You lost your parents early.", "You were poor, but grew up strongly.", "You lost your hometown in a war.", "You were found and raised by thieves.", "You were a powerful god.", "You grew up normally in an ordinary home.", "You were artificially created through an experiment.", "In the past you were a villain.", "You had no family.", "You spent your days in peace.", "You were incapacitated by disease for a long time."})

local reason = util.random_from({"You embark to find yourself.", "You embark on your journey lightheartedly.", "You embark to fulfill an important promise.", "You embark as an adventurer because you didn't like your situation.", "You embark in search of excitement.", "You embark in search of a missing person.", "You embark in search of romance.", "You embark to find better work.", "You embark in order to become stronger.", "You embark to travel the world.", "You embark to help forget a broken heart.", "You embark to work towards world peace.", "You embark to work towards world domination.", "You embark on adventure, guided by fate.", "You embark because you fear for your life.", "You embark due to a revelation from god.", "You embark due to being ousted from your hometown as a criminal.", "You embark due to admiring an adventurer, and wanting to be one yourself.", "You were summoned to this world.", "You became an adventurer because you heard it was profitable.", "You were involved in a conspiracy and banished.", "You embark to flee from your past.", "You became an adventurer to protect something precious.", "You became an adventurer to seek fame.", "You embark in search of atonement.", "You were loaded onto the ship while you slept.", "You embark in search of undiscovered treasures.", "You embark to pursue the mysteries of an ancient civilization."})

local quirk0 = "" .. util.random_from({"While", "Although", "Though"}) .. " " .. util.random_from({"knowing many things", "you are ordinary", "you are bold and daring", "you're the life of the party", "you are calm and collected", "you're always strict with yourself", "you have the brains of a genius", "friends with everyone", "you are passionate at heart", "you never give up", "gentle and merciful", "always polite", "you have a keen eye"}) .. ", "

local quirk1 = util.random_from({"You are insensitive to the goodwill of others.", "You have a bad habit of getting caught up in delusions.", "You look down on others.", "You are in enormous debt.", "Your fashion sense is weird.", "You worry about your body odor.", "Your personality changes when you hold a knife.", "You've experienced major trauma.", "You do not trust others.", "You are surprisingly servile.", "You suffer from a rare disease.", "You are cold to those you are not interested in.", "Your grasp of money is poor.", "You're not good at socializing.", "You easily get carried away.", "Your sense of taste is odd.", "You are undisciplined in your private life.", "You make lots of blunders.", "You fail at the essentials.", "You are undisciplined in your private life.", "You act terribly when drunk.", "You hate yourself.", "You have no confidence in yourself.", "You're actually a gigantic pervert.", "You have no sense of direction.", "You are in love with money.", "You are self conscious.", "You have no gag reflex.", "You are greedy.", "Your paintings are terrible.", "You make terrible misunderstandings.", "You don't have any friends worth mentioning.", "You make terrible misunderstandings.", "You're easy to read.", "You often misunderstand situations.", "You're bad with insects.", "You don't have much of a presence.", "You're very prideful.", "You love shady things.", "You hide your personality from others."})

local quirk2 = util.random_from({"Imprisonment is your hobby.", "Your hobby is stalking.", "You like to see people's faces distorted in pain.", "Gardening is your hobby.", "You like stuffed animals.", "You're a self-proclaimed sadist.", "You risk your life for creative activities.", "Hunting is your hobby.", "You're interesting in the clothes of the opposite sex.", "You love small animals.", "You yearn for your master.", "You have memories of your past life.", "You like to exercise.", "You yearn for your master.", "Your intuition is sharp.", "Your hobby is napping.", "You have a strong attachment to life.", "Your hobby is reading.", "You love using violence.", "You have a secret that you can't tell anyone.", "You're good at singing.", "You are gullible.", "You're bad at lying.", "You fall in love easily.", "You're a hard worker.", "You had a mission you failed to achieve.", "You like making fun of others.", "You have followers.", "You hold a powerful grudge against someone.", "You fear betrayal above everything else.", "You like to collect junk."})

crawl.mpr("<lightblue>" .. background .. "</lightblue>")
crawl.mpr("<green>" .. reason .. "</green>")
crawl.mpr("<cyan>" .. quirk0 .. "</cyan>")
crawl.mpr("<red>" .. quirk1 .. "</red>")
crawl.mpr("<cyan>" .. quirk2 .. "</cyan>")

local res =crawl.yesno("<yellow>Proceed with personal background?</yellow>")
if not(res == true) then
crawl.clear_messages()
embark()
end
if (res == true) then
crawl.take_note("+++========================+++")
crawl.take_note(background)
crawl.take_note(reason)
crawl.take_note(quirk0)
crawl.take_note(quirk1)
crawl.take_note(quirk2)
crawl.take_note("+++========================+++")
end

end

function console()
crawl.do_commands({"CMD_LUA_CONSOLE"})
end

}
