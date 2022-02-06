function ouResname ()
	local resources = getResources()
	for k,resource in ipairs(resources) do
		triggerClientEvent ("outResNameGui", root, getResourceName(resource))
	end
end
addEvent ("ouResname", true)
addEventHandler("ouResname", getRootElement(), ouResname)
