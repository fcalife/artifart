(function () {
	InitializeUI()
})();

function InitializeUI() {
	var is_host = CheckForHostPrivileges();
	if (is_host === undefined) {
		$.Schedule(1, InitializeUI);
		$.Msg("waiting")
		return;
	} else if (is_host) {
		FindDotaHudElement('GameOptionsContainer').style.visibility = 'visible';
		var player_count = 0
		var radiant_count = 0
		var dire_count = 0
		for (var i = 0; i < 10; i++) {
			if (Players.IsValidPlayerID(i)) {
				player_count = player_count +1;
				if (Players.GetTeam(i) == DOTATeam_t.DOTA_TEAM_GOODGUYS) {
					radiant_count = radiant_count + 1
				} else if (Players.GetTeam(i) == DOTATeam_t.DOTA_TEAM_BADGUYS) {
					dire_count = dire_count + 1
				}
			}
		}
		if (player_count < 10) {
			FindDotaHudElement('BotOptionsContainer').style.visibility = 'visible';
			if (radiant_count > 0 && dire_count > 0) {
				$("#FillEnemyButton").style.visibility = 'collapse';
				$("#BotOptionsContainer").style.height = '200px';
			}
		}

	}
}

function ChangeGameSpeed(speed) {
	GameEvents.SendCustomGameEventToServer('increase_game_speed', {speed: speed});
	FindDotaHudElement('GameOptionsContainer').style.visibility = 'collapse';
}

function SetBotOptions(option) {
	GameEvents.SendCustomGameEventToServer('set_bot_options', {option: option});
	FindDotaHudElement('BotOptionsContainer').style.visibility = 'collapse';
}

// Utility functions
function FindDotaHudElement (id) {
	return GetDotaHud().FindChildTraverse(id);
}

function GetDotaHud () {
	var p = $.GetContextPanel();
	while (p !== null && p.id !== 'Hud') {
		p = p.GetParent();
	}
	if (p === null) {
		throw new HudNotFoundException('Could not find Hud root as parent of panel with id: ' + $.GetContextPanel().id);
	} else {
		return p;
	}
}

// Checks if the local player has local privileges
function CheckForHostPrivileges() {
	var player_info = Game.GetLocalPlayerInfo();
	if ( !player_info ) {
		return undefined;
	} else {
		return player_info.player_has_host_privileges;
	}
}