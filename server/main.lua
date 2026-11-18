local CLASS_PRICE = {
    compacts       = 22000,
    sedans         = 32000,
    suvs           = 52000,
    coupes         = 45000,
    muscle         = 55000,
    sportsclassics = 70000,
    sports         = 95000,
    super          = 250000,
    motorcycles    = 18000,
    offroad        = 62000,
    industrial     = 85000,
    utility        = 40000,
    vans           = 38000,
    boats          = 75000,
    helicopters    = 450000,
    planes         = 600000,
    service        = 35000,
    emergency      = 45000,
    military       = 120000,
    commercial     = 70000,
    trains         = 100000,
    openwheel      = 200000,
}

local DEFAULT_PRICE = 40000

Whip.register(function()
    local list = OnxVehicles
    if type(list) ~= 'table' or #list == 0 then
        print('^1[whip_onx_vehicles] vehicles.lua did not load a list^7')
        return
    end

    local ok, why = Whip.core:RegisterVehicles(list)
    if not ok then
        print(('^1[whip_onx_vehicles] RegisterVehicles failed: %s^7'):format(tostring(why)))
        return
    end

    local prices = {}
    for _, row in ipairs(list) do
        prices[row.model] = CLASS_PRICE[row.class] or DEFAULT_PRICE
    end
    local priced, priceWhy = Whip.core:SetVehiclePrices(prices)
    if not priced then
        print(('^1[whip_onx_vehicles] SetVehiclePrices failed: %s^7'):format(tostring(priceWhy)))
        return
    end

    print(('^2[whip_onx_vehicles] registered %d ONX vehicles into the WHIP catalog^7'):format(#list))
end)

Whip.sayStarted()
