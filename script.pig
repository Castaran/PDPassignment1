data = LOAD 'data.csv' USING PigStorage(',') AS (
    QueryID: int,
    ResponseID: int,
    QueryName: chararray,
    ResponseName: chararray,
    ReleaseDate: chararray,
    RequiredAge: int,
    DemoCount: int,
    DeveloperCount: int,
    DLCCount: int,
    Metacritic: int,
    MovieCount: int,
    PackageCount: int,
    RecommendationCount: int,
    PublisherCount: int,
    ScreenshotCount: int,
    SteamSpyOwners: int,
    SteamSpyOwnersVariance: int,
    SteamSpyPlayersEstimate: int,
    SteamSpyPlayersVariance: int,
    AchievementCount: int,
    AchievementHighlightedCount: int,
    ControllerSupport: chararray,
    IsFree: int,
    FreeVerAvail: int,
    PurchaseAvail: int,
    SubscriptionAvail: int,
    PlatformWindows: int,
    PlatformLinux: int,
    PlatformMac: int,
    PCReqsHaveMin: int,
    PCReqsHaveRec: int,
    LinuxReqsHaveMin: int,
    LinuxReqsHaveRec: int,
    MacReqsHaveMin: int,
    MacReqsHaveRec: int,
    CategorySinglePlayer: chararray,
    CategoryMultiplayer: chararray,
    CategoryCoop: chararray,
    CategoryMMO: chararray,
    CategoryInAppPurchase: chararray,
    CategoryIncludeSrcSDK: chararray,
    CategoryIncludeLevelEditor: chararray,
    CategoryVRSupport: chararray
);

-- Selecteer specifieke kolommen
selected_data = FOREACH data GENERATE 	
					CategorySinglePlayer, 
					CategoryMultiplayer, 
                    CategoryCoop, 
                    CategoryMMO, 
                  	CategoryInAppPurchase,
                    CategoryIncludeSrcSDK,
                    CategoryIncludeLevelEditor,
                    CategoryVRSupport;

-- Tel hoe vaak elke kolom True is
single_player_true_list = FILTER selected_data BY CategorySinglePlayer == 'True';
multiplayer_true_list = FILTER selected_data BY CategoryMultiplayer == 'True';
coop_true_list = FILTER selected_data BY CategoryCoop == 'True';
mmo_true_list = FILTER selected_data BY CategoryMMO == 'True';
in_app_purchase_true_list = FILTER selected_data BY CategoryInAppPurchase == 'True';
include_src_sdk_true_list = FILTER selected_data BY CategoryIncludeSrcSDK == 'True';
include_level_editor_true_list = FILTER selected_data BY CategoryIncludeLevelEditor == 'True';
vr_support_true_list = FILTER selected_data BY CategoryVRSupport == 'True';

single_player_true_count = FOREACH (GROUP single_player_true_list ALL) GENERATE 'single_player' AS label, (long)COUNT(single_player_true_list) AS count;
multiplayer_true_count = FOREACH (GROUP multiplayer_true_list ALL) GENERATE 'multiplayer' AS label, (long)COUNT(multiplayer_true_list) AS count;
coop_true_count = FOREACH (GROUP coop_true_list ALL) GENERATE 'coop' AS label, (long)COUNT(coop_true_list) AS count;
mmo_true_count = FOREACH (GROUP mmo_true_list ALL) GENERATE 'mmo' AS label, (long)COUNT(mmo_true_list) AS count;
in_app_purchase_true_count = FOREACH (GROUP in_app_purchase_true_list ALL) GENERATE 'in_app_purchase' AS label, (long)COUNT(in_app_purchase_true_list) AS count;
include_src_sdk_true_count = FOREACH (GROUP include_src_sdk_true_list ALL) GENERATE 'include_src_sdk' AS label, (long)COUNT(include_src_sdk_true_list) AS count;
include_level_editor_true_count = FOREACH (GROUP include_level_editor_true_list ALL) GENERATE 'include_level_editor' AS label, (long)COUNT(include_level_editor_true_list) AS count;
vr_support_true_count = FOREACH (GROUP vr_support_true_list ALL) GENERATE 'vr_support' AS label, (long)COUNT(vr_support_true_list) AS count;

counts = UNION 
    single_player_true_count,
    multiplayer_true_count, 
    coop_true_count, 
    mmo_true_count, 
    in_app_purchase_true_count, 
    include_src_sdk_true_count, 
    include_level_editor_true_count, 
    vr_support_true_count;
    
sorted_counts = ORDER counts BY count DESC;

DUMP sorted_counts;








