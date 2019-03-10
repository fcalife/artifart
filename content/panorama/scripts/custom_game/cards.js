(function () {
	InitializeUI()
})();

function InitializeUI() {
	CustomNetTables.SubscribeNetTableListener("player_cards", OnPlayerCardsChanged);
	
}

function OnPlayerCardsChanged(table, key, data) {
	var key_parts = key.split("_")
	var player_id = key_parts[1];
	if ( player_id == Game.GetLocalPlayerID() ) {
		RefreshPlayerCards(data);
	}
}

function RefreshPlayerCards(data) {
	if ( data[1] == "blank" ) {
		$("#CardPanel1").style.visibility = 'collapse';
	} else {
		var panel = $("#CardPanel1");
		panel.SetPanelEvent("onmouseover", function () {
			$.DispatchEvent("DOTAShowAbilityTooltip", panel, "card_" + data[1]);
		})
		panel.style.visibility = 'visible';
		$("#CardButton1").SetImage("file://{images}cards/" + data[1] + ".png");
	}

	if ( data[2] == "blank" ) {
		$("#CardPanel2").style.visibility = 'collapse';
	} else {
		var panel = $("#CardPanel2");
		panel.SetPanelEvent("onmouseover", function () {
			$.DispatchEvent("DOTAShowAbilityTooltip", panel, "card_" + data[2]);
		})
		panel.style.visibility = 'visible';
		$("#CardButton2").SetImage("file://{images}cards/" + data[2] + ".png");
	}

	if ( data[3] == "blank" ) {
		$("#CardPanel3").style.visibility = 'collapse';
	} else {
		var panel = $("#CardPanel3");
		panel.SetPanelEvent("onmouseover", function () {
			$.DispatchEvent("DOTAShowAbilityTooltip", panel, "card_" + data[3]);
		})
		panel.style.visibility = 'visible';
		$("#CardButton3").SetImage("file://{images}cards/" + data[3] + ".png");
	}

	if ( data[4] == "blank" ) {
		$("#CardPanel4").style.visibility = 'collapse';
	} else {
		var panel = $("#CardPanel4");
		panel.SetPanelEvent("onmouseover", function () {
			$.DispatchEvent("DOTAShowAbilityTooltip", panel, "card_" + data[4]);
		})
		panel.style.visibility = 'visible';
		$("#CardButton4").SetImage("file://{images}cards/" + data[4] + ".png");
	}

	if ( data[5] == "blank" ) {
		$("#CardPanel5").style.visibility = 'collapse';
	} else {
		var panel = $("#CardPanel5");
		panel.SetPanelEvent("onmouseover", function () {
			$.DispatchEvent("DOTAShowAbilityTooltip", panel, "card_" + data[5]);
		})
		panel.style.visibility = 'visible';
		$("#CardButton5").SetImage("file://{images}cards/" + data[5] + ".png");
	}
}

function UseCard(slot) {
	var player_cards = CustomNetTables.GetTableValue("player_cards", "player_" + Game.GetLocalPlayerID() + "_cards")
	if ( player_cards[slot] !== "blank" ) {
		var hero_index = Players.GetPlayerHeroEntityIndex(Game.GetLocalPlayerID())
		var ability_index = Entities.GetAbilityByName(hero_index, "card_" + player_cards[slot])
		Abilities.ExecuteAbility(ability_index, hero_index, false)
	}
}

function DiscardCard(slot) {
	GameEvents.SendCustomGameEventToServer("player_discarded_card", {player_id: Players.GetLocalPlayer(), card_slot: slot})
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