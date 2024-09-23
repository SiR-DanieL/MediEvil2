state("LiveSplit") {}

startup {
    Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("PS1");
}

init {
    vars.Helper.Load = (Func<dynamic, bool>)(emu => {
        emu.Make<byte>("level_ID", 0x800EFF10);
        emu.Make<ushort>("hp_stored", 0x800F1532);
        emu.Make<ushort>("hp_bar", 0x800F152C);
        emu.Make<byte>("new_game", 0x800F05FC);
        emu.Make<ushort>("boss_hp", 0x800F3974);
        emu.Make<byte>("boss_presence", 0x800F3970);
        emu.Make<byte>("slugger_hp", 0x800EEF88);
        emu.Make<byte>("slugger_hp2", 0x800F39B0);
        return true;
    });
}

start {if (current.new_game == 3 && old.new_game == 0) return true;}
reset {if (current.hp_bar == 0 && current.hp_stored == 0 && current.new_game == 4) return true;}


split
{var cur_segname = timer.CurrentSplit.Name;
if(cur_segname == "The Museum") {return current.level_ID == 11 && old.level_ID == 10;}
else if(cur_segname == "Tyrannosaurus Wrecks") {return current.level_ID == 13 && old.level_ID == 11;}
else if(cur_segname == "Kensington") {return current.level_ID == 26 && old.level_ID == 18;}
else if(cur_segname == "Kensington, The Tomb") {return current.level_ID == 13 && old.level_ID == 26;}
else if(cur_segname == "The Freakshow") {return current.level_ID == 13 && old.level_ID == 6;}
else if(cur_segname == "Greenwich Observatory") {return current.level_ID == 27 && old.level_ID == 7;}
else if(cur_segname == "Greenwich, Naval Academy") {return current.level_ID == 13 && old.level_ID == 27;}
else if(cur_segname == "Kew Gardens") {return current.level_ID == 5 && old.level_ID == 8;}
else if(cur_segname == "Dankenstein") {return current.level_ID == 4 && old.level_ID == 5;}
else if(cur_segname == "Iron Slugger") {return current.level_ID == 13 && old.level_ID == 4 && current.slugger_hp != 0 && current.slugger_hp2 < 4;}
else if(cur_segname == "Wulfrum Hall") {return current.level_ID == 16 && old.level_ID == 17;}
else if(cur_segname == "The Count") {return current.level_ID == 13 && old.level_ID == 16 && current.boss_hp == 65526;}
else if(cur_segname == "Whitechapel") {return current.level_ID == 13 && old.level_ID == 9;}
else if(cur_segname == "The Sewers") {return current.level_ID == 13 && old.level_ID == 14;}
else if(cur_segname == "-Museum 2") {return current.level_ID == 28 && old.level_ID == 15;}
else if(cur_segname == "-Sewers 2") {return current.level_ID == 29 && old.level_ID == 28;}
else if(cur_segname == "{The Time Machine}The Ripper") {return current.level_ID == 13 && old.level_ID == 29;}
else if(cur_segname == "Cathedral Spires") {return current.level_ID == 30 && old.level_ID == 2;}
else if(cur_segname == "Cathedral Spires, The Descent") {return current.level_ID == 3 && old.level_ID == 30;}
else if(cur_segname == "The Demon") {return current.boss_hp == 75 && current.boss_presence == 0;}
}
