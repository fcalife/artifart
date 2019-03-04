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
	}
}

function ChangeGameSpeed(speed) {
	GameEvents.SendCustomGameEventToServer('increase_game_speed', {speed: speed});
	FindDotaHudElement('GameOptionsContainer').style.visibility = 'collapse';
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