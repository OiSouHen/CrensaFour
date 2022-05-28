$(document).ready(function(){
	window.addEventListener("message",function(event){
		switch(event.data.action){
			case "showMenu":
				requestChest();
				$(".inventory").css("display","flex");
			break;

			case "hideMenu":
				$(".inventory").css("display","none");
				$(".ui-tooltip").hide();
			break;
		}
	});

	document.onkeyup = data => {
		if (data["key"] === "Escape"){
			$.post("http://inspect/invClose");
			$(".invRight").html("");
			$(".invLeft").html("");
		}
	};

	$('body').mousedown(e => {
		if(e.button == 1) return false;
	});
});

const updateDrag = () => {
	$(".populated").tooltip({
		create: function(event,ui){
			var max = $(this).attr("data-max");
			var name = $(this).attr("data-name-key");
			var economy = $(this).attr("data-economy");
			var description = $(this).attr("data-description");

			$(this).tooltip({
				content: `<item>${name}</item>${description !== "undefined" ? "<br><description>"+description+"</description>":""}<br><legenda>Economia: <r>$${economy}</r> <s>|</s> Máximo: <r>${max !== "undefined" ? max:"S/L"}</r></legenda>`,
				position: { my: "center top+10", at: "center bottom", collision: "flipfit" },
				show: { duration: 10 },
				hide: { duration: 10 }
			});
		}
	});
}

const colorPicker = (percent) => {
	var colorPercent = "#2e6e4c";

	if (percent >= 100)
		colorPercent = "rgba(255,255,255,0)";

	if (percent >= 51 && percent <= 75)
		colorPercent = "#fcc458";

	if (percent >= 26 && percent <= 50)
		colorPercent = "#fc8a58";

	if (percent <= 25)
		colorPercent = "#fc5858";

	return colorPercent;
}

const requestChest = () => {
	$.post("http://inspect/requestChest",JSON.stringify({}),(data) => {
		$("#weightTextLeft").html(`${(data["invPeso"]).toFixed(2)}   /   ${(data["invMaxpeso"]).toFixed(2)}`);
		$("#weightTextRight").html(`${(data["chestPeso"]).toFixed(2)}   /   ${(data["chestMaxpeso"]).toFixed(2)}`);

		$("#weightBarLeft").html(`<div id="weightContent" style="width: ${data["invPeso"] / data["invMaxpeso"] * 100}%"></div>`);
		$("#weightBarRight").html(`<div id="weightContent" style="width: ${data["chestPeso"] / data["chestMaxpeso"] * 100}%"></div>`);

		$(".invLeft").html("");
		$(".invRight").html("");

		if (data["invMaxpeso"] > 100)
			data["invMaxpeso"] = 100;

		for (let x = 1; x <= data["invMaxpeso"]; x++){
			const slot = x.toString();

			if (data.myInventory[slot] !== undefined){
				const v = data.myInventory[slot];
				var maxDurability = 86400 * v["days"];
				var newDurability = (maxDurability - v["durability"]) / maxDurability;
				var actualPercent = newDurability * 100;

				if (v["charges"] !== undefined)
					actualPercent = v["charges"];

				if (actualPercent <= 1)
					actualPercent = 1;

				const item = `<div class="item populated" title="" data-max="${v["max"]}" data-economy="${v["economy"]}" data-description="${v["desc"]}" style="background-image: url('nui://inventory/web-side/images/${v.index}.png'); background-position: center; background-repeat: no-repeat;" data-amount="${v.amount}" data-peso="${v.peso}" data-item-key="${v.key}" data-name-key="${v.name}" data-slot="${slot}">
					<div class="top">
						<div class="itemWeight">${(v.peso * v.amount).toFixed(2)}</div>
						<div class="itemAmount">${formatarNumero(v.amount)}x</div>
					</div>

					<div class="durability" style="width: ${actualPercent == 1 ? "100":actualPercent}%; background: ${actualPercent == 1 ? "#fc5858":colorPicker(actualPercent)};"></div>
					<div class="nameItem">${v.name}</div>
				</div>`;

				$(".invLeft").append(item);
			} else {
				const item = `<div class="item empty" data-slot="${slot}"></div>`;

				$(".invLeft").append(item);
			}
		}

		for (let x = 1; x <= data["chestMaxpeso"]; x++){
			const slot = x.toString();

			if (data.myChest[slot] !== undefined){
				const v = data.myChest[slot];
				var maxDurability = 86400 * v["days"];
				var newDurability = (maxDurability - v["durability"]) / maxDurability;
				var actualPercent = newDurability * 100;

				if (v["charges"] !== undefined)
					actualPercent = v["charges"];

				if (actualPercent <= 1)
					actualPercent = 1;

				const item = `<div class="item populated" title="" data-max="${v["max"]}" data-economy="${v["economy"]}" data-description="${v["desc"]}" style="background-image: url('nui://inventory/web-side/images/${v.index}.png'); background-position: center; background-repeat: no-repeat;" data-amount="${v.amount}" data-peso="${v.peso}" data-item-key="${v.key}" data-name-key="${v.name}" data-slot="${slot}">
					<div class="top">
						<div class="itemWeight">${(v.peso * v.amount).toFixed(2)}</div>
						<div class="itemAmount">${formatarNumero(v.amount)}x</div>
					</div>

					<div class="durability" style="width: ${actualPercent == 1 ? "100":actualPercent}%; background: ${actualPercent == 1 ? "#fc5858":colorPicker(actualPercent)};"></div>
					<div class="nameItem">${v.name}</div>
				</div>`;

				$(".invRight").append(item);
			} else {
				const item = `<div class="item empty" data-slot="${slot}"></div>`;

				$(".invRight").append(item);
			}
		}

		updateDrag();
	});
}

const formatarNumero = n => {
	var n = n.toString();
	var r = '';
	var x = 0;

	for (var i = n.length; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}

	return r.split('').reverse().join('');
}