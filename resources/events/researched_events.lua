exports('DataViewNativeGetEventData', (eventGroup, index, argStructSize) => {
	let buffer = new ArrayBuffer(256);
	let view = new DataView(buffer);
	Citizen.invokeNative("0x57EC5FA4D4D6AFCA", eventGroup, index, view, argStructSize, Citizen.returnResultAnyway());
	let out = new Int32Array(buffer);
	return out;
});
while true do
	Citizen.Wait(100)
	-- Might support a higher wait time, haven't tested!
	local size = GetNumberOfEvents(0)
	if size > 0 then
		for index = 0, size - 1 do
			local event = GetEventAtIndex(0, index)
			--[[
				Triggered when a ped whistles hearing range
			]]
			if event == 1327216456 then
				local view = exports["myresourcename"]:DataViewNativeGetEventData(0, index, 2)
				local pedWhistling = view[0]
				local whistleType = view[2] -- Short or Long, haven't looked which one is which
			end
			--[[
				Triggered when a ped is using a animal interaction task
			]]
			if event == -1246119244 then
				local view = exports["myresourcename"]:DataViewNativeGetEventData(0, index, 3)
				local pedInteracting = view[0] -- Mostly of the time it is the one interacting
				local animalInteracting = view[2] -- Mostly of the time it is the animal
				local interactionType = view[4] -- INTERACTION_FEED, INTERACTION_POSITIVELONG, INTERACTION_BRUSH, etc
			end
			--[[
				Triggered when a ped interacts(opening, closing) with a ransack scenario (chests, cabinets, etc)
			]]
			if event == 1352063587 then
				local view = exports["myresourcename"]:DataViewNativeGetEventData(0, index, 4)
				local pedInteracting = view[0]
				local containerEntity = view[2] -- Containers are chests/cabinets/etcs
				local containerScenario = view[4] -- Ransack scenario attached to containerEntity
				local justClosed = view[6] -- Whether the ped just closed or opened the conainer
			end
			--[[
				Triggered when a ped starts carrying
			]]
			if event == -687266558 then
				local view = exports["myresourcename"]:DataViewNativeGetEventData(0, index, 4)
				local pedCarrier = view[0]
				local pedCarried = view[2]
			end
			--[[
				Triggered when a ped finishs gathering a ped (Skinning or Looting)
			]]
			if event == 1376140891 then
				local view = exports["myresourcename"]:DataViewNativeGetEventData(0, index, 3)
				local ped = view[0]
				local pedGathered = view[2]
				local bool_unk = view[4]
			end
		end
	end
end