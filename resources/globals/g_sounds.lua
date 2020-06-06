-- CitizenFX Sound FX Constants

-- NOTE: see bottom for example usage

--[[
  Sound Sets (like 'packs'/'collections')
  Each entry contains the name of the set and enums for
  its known available effects
]]--
G_SOUNDSETS = {
    HUD_CAMP_STATUS = {
        name = "HUD_Camp_Status_Sounds",
        BACK = "Back",
        },
    HUD_DOMINOS = {
        name = "HUD_DOMINOS_SOUNDSET",
        MONEY = "MONEY",
        NAV_DOWN = "NAV_DOWN",
        NAV_LEFT = "NAV_LEFT",
        NAV_RIGHT = "NAV_RIGHT",
        NAV_UP = "NAV_UP",
        NO = "NO",
        YES = "YES",
        },
    HUD_DONATE = {
        name = "HUD_Donate_Sounds",
        AMOUNT_DECREASE = "Amount_Decrease",
        AMOUNT_INCREASE = "Amount_Increase",
        DONATE = "Donate",
        EXIT = "Exit",
        GIVE_ITEM_ENTER = "Give_Item_Enter",
        GIVE_MONEY_ENTER = "Give_Money_Enter",
        GIVE_TO_GANG = "Give_To_Gang",
        },
    HUD_DUEL = {
        name = "HUD_DUEL_SOUNDSET",
        DRAW = "HUD_DRAW",
        },
    HUD_MAIL = {
        name = "HUD_MAIL_SOUNDSET",
        MAIL = "MAIL",
        },
    HUD_POKER = {
        name = "HUD_POKER",
        BET_AMOUNT = "BET_AMOUNT",
        BET_MIN_MAX = "BET_MIN_MAX",
        BET_PROMPT = "BET_PROMPT",
        },
    HUD_REWARDS = {
        name = "HUD_REWARD_SOUNDSET",
        ITEM_TICKER_GENERIC = "ITEM_TICKER_GENERIC",
        MORALE = "REWARD_MORALE",
        NEW_GUN = "REWARD_NEW_GUN",
        },
    HUD_SHOP = {
        name = "HUD_SHOP_SOUNDSET",
        BACK = "BACK",
        INFO = "INFO",
        INFO_HIDE = "INFO_HIDE",
        PURCHASE = "PURCHASE",
        QUIT = "QUIT",
        READ = "READ",
        SELECT = "SELECT",
        SELL = "SELL",
        },
    CONSUMPTION = {
        name = "Consumption_Sounds",
        CORE_FILL_UP = "Core_Fill_Up",
        CORE_FULL = "Core_Full",
        },
    DEATH_FAIL_RESPAWN = {
        name = "DEATH_FAIL_RESPAWN_SOUNDS",
        EXIT = "EXIT",
        TITLE_SCREEN_EXIT = "TITLE_SCREEN_EXIT",
        TITLE_SCREEN_EXIT_OFF_MISSION = "TITLE_SCREEN_EXIT_OFF_MISSION",
        },
    FLEX_FIGHT = {
        name = "Flex_Fight_Sounds",
        HORN = "Horn",
        WHISTLE = "Whistle",
        },
    LEDGER = {
        name = "Ledger_Sounds",
        INFO_HIDE = "INFO_HIDE",
        INFO_SHOW = "INFO_SHOW",
        NAV_DOWN = "NAV_DOWN",
        NAV_LEFT = "NAV_LEFT",
        NAV_RIGHT = "NAV_RIGHT",
        NAV_UP = "NAV_UP",
        PURCHASE = "PURCHASE",
        UNAFFORDABLE = "UNAFFORDABLE",
        },
    SSCRFT = {
        name = "SSCRFT_Sounds",
        CRAFT_ITEMS_ENTER = "Craft_Items_Enter",
        },
    GNG3_CME = {
        name = "gng3_CME_SoundSet",
        PRISON_SHOT = "prison",
        WATCHTOWER_SHOT = "watchtower_shot",
        },
    RDCH3_CME = {
        name = "rdch3_CME_SoundSet",
        RIVER_FAST = "river_fast",
        RIVER_MED = "river_fast",
        },
    SAL1 = {
        name = "SAL1_Sounds",
        JUMP_CUT = "JumpCut",
        },
    TITHE_DONATION = {
        name = "Tithe_Donation_Sounds",
        LARGE = "Tithe_Donation_Large",
        MEDIUM = "Tithe_Donation_Medium",
        SMALL = "Tithe_Donation_Small",
        },
    WNT2_CME = {
        name = "wnt2_CME_SoundSet",
        LEAVING_COLTER6_GUST = "LeavingColter6_Gust",
        },
    OTHER = {
        name = 0,
        BATHING_DOOR_KNOCK_MASTER = "BATHING_DOOR_KNOCK_MASTER",
        },
};


--[[
 ===================
  EXAMPLES
 ===================

play_sound_frontend(
    G_SOUNDSETS.HUD_REWARDS.NEW_GUN,
    G_SOUNDSETS.HUD_REWARDS.name,
    1);
play_sound_frontend(
    G_SOUNDSETS.DEATH_FAIL_RESPAWN.TITLE_SCREEN_EXIT,
    G_SOUNDSETS.DEATH_FAIL_RESPAWN.name,
    1);
play_sound_frontend(
    G_SOUNDSETS.OTHER.BATHING_DOOR_KNOCK_MASTER,
    G_SOUNDSETS.OTHER.name,
    1);
local ptr = G_SOUNDSETS.CONSUMPTION;
play_sound_frontend(ptr.CORE_FULL, ptr.name, 1);
play_sound_frontend(ptr.CORE_FILL_UP, ptr.name, 1);

]]--
