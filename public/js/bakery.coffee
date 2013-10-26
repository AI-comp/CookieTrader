((define) ->
  define([], ->

    newBakeries =
      'Cursor':              0
      'Grandma':             0
      'Farm':                0
      'Factory':             0
      'Mine':                0
      'Shipment':            0
      'AlchemyLab':          0
      'Portal':              0
      'TimeMachine':         0
      'AntimatterCondenser': 0

    baseCPSs =
      'Cursor':              0.1
      'Grandma':             0.5
      'Farm':                2
      'Factory':             10
      'Mine':                40
      'Shipment':            100
      'AlchemyLab':          400
      'Portal':              6666
      'TimeMachine':         98765
      'AntimatterCondenser': 999999

    prices =
      'Cursor':              15
      'Grandma':             100
      'Farm':                500
      'Factory':             3000
      'Mine':                10000
      'Shipment':            40000
      'AlchemyLab':          200000
      'Portal':              1666666
      'TimeMachine':         123456789
      'AntimatterCondenser': 3999999999

    computeCps = (base,add,mult,bonus) ->
      bonus = 0 if !bonus
      ((base + add) * (Math.pow(2,mult) + bonus))

    calcCPS = (bakery, amount, bakeries, equips) ->
      cps =
        switch bakery
          when 'Cursor'
            add = if equips['ReinforcedIndexFinger'] then 0.1 else 0
            mult = 0
            mult += 1 if equips['CarpalTunnelPreventionCream']
            mult += 1 if equips['Ambidextrous']
            bonus = 0
            bonus += 0.1 if equips['ThousandFingers']
            bonus += 0.5 if equips['MillionFingers']
            bonus += 2 if equips['BillionFingers']
            bonus += 10 if equips['TrillionFingers']
            bonus += 20 if equips['QuadrillionFingers']
            bonus += 100 if equips['QuintillionFingers']
            bonus += 200 if equips['SextillionFingers']
            num = 0
            for name of bakeries
              if name != 'Cursor'
                num += bakeries[name]
            bonus *= num
            computeCps(baseCPSs[bakery], add, mult, bonus)
          when 'Grandma'
            add = 0
            add += 0.3 if equips['ForwardsFromGrandma']
            add += bakeries['Grandma'] * 0.02 if equips['OneMind']
            add += bakeries['Grandma'] * 0.02 if equips['CommunalBrainsweep']
            add += bakeries['Portal'] * 0.05 if equips['ElderPact']
            mult = 0
            mult += 1 if equips['SteelPlatedRollingPins']
            mult += 1 if equips['LubricatedDentures']
            mult += 1 if equips['PruneJuice']
            mult += 1 if equips['DoubleThickGlasses']
            mult += 1 if equips['FarmerGrandmas']
            mult += 1 if equips['WorkerGrandmas']
            mult += 1 if equips['MinerGrandmas']
            mult += 1 if equips['CosmicGrandmas']
            mult += 1 if equips['TransmutedGrandmas']
            mult += 1 if equips['AlteredGrandmas']
            mult += 1 if equips['GrandmasGrandmas']
            mult += 1 if equips['Antigrandmas']
            mult += 2 if equips['BingocenterResearchFacility']
            mult += 1 if equips['RitualRollingPins']
            computeCps(baseCPSs[bakery], add, mult)
          when 'Farm'
            add = 0
            add += 1 if equips['CheapHoes']
            mult = 0
            mult += 1 if equips['Fertilizer']
            mult += 1 if equips['CookieTrees']
            mult += 1 if equips['GeneticallyModifiedCookies']
            mult += 1 if equips['GingerbreadScareclows']
            computeCps(baseCPSs[bakery], add, mult)
          when 'Factory'
            add = 0
            add += 4 if equips['SturdierConveyorBelts']
            mult = 0
            mult += 1 if equips['ChildLabor']
            mult += 1 if equips['Sweatshop']
            mult += 1 if equips['RadiumReactors']
            mult += 1 if equips['Recombobulators']
            computeCps(baseCPSs[bakery], add, mult)
          when 'Mine'
            add = 0
            add += 10 if equips['SugarGas']
            mult = 0
            mult += 1 if equips['Megadrill']
            mult += 1 if equips['Ultradrill']
            mult += 1 if equips['Ultimadrill']
            mult += 1 if equips['HBombMining']
            computeCps(baseCPSs[bakery], add, mult)
          when 'Shipment'
            add = 0
            add += 1666 if equips['VanillaNebulae']
            mult = 0
            mult += 1 if equips['Wormholes']
            mult += 1 if equips['FrequentFlyer']
            mult += 1 if equips['WarpDrive']
            mult += 1 if equips['ChocolateMonoliths']
            computeCps(baseCPSs[bakery], add, mult)
          when 'AlchemyLab'
            add = 0
            add += 100 if equips['Antimony']
            mult = 0
            mult += 1 if equips['EssenceOfDough']
            mult += 1 if equips['TrueChocolate']
            mult += 1 if equips['Ambrosia']
            mult += 1 if equips['AquaCrustulae']
            computeCps(baseCPSs[bakery], add, mult)
          when 'Portal'
            add = 0
            add += 1666 if equips['AncientTablet']
            mult = 0
            mult += 1 if equips['InsaneOatlingWorkers']
            mult += 1 if equips['SoulBond']
            mult += 1 if equips['SanityDance']
            mult += 1 if equips['BraneTransplant']
            computeCps(baseCPSs[bakery], add, mult)
          when 'TimeMachine'
            add = 0
            add += 9876 if equips['FluxCapacitors']
            mult = 0
            mult += 1 if equips['TimeParadoxResolver']
            mult += 1 if equips['QuantumConundrum']
            mult += 1 if equips['CausalityEnforcer']
            mult += 1 if equips['YestermorrowComparators']
            computeCps(baseCPSs[bakery], add, mult)
          when 'AntimatterCondenser'
            add = 0
            add += 99999 if equips['SugarBosons']
            mult = 0
            mult += 1 if equips['StringTheory']
            mult += 1 if equips['LargeMacaronCollider']
            mult += 1 if equips['BigBangBake']
            mult += 1 if equips['ReverseCyclotrons']
            computeCps(baseCPSs[bakery], add, mult)
          else
            console.log 'invalid bakery'
      cps * amount

    priceOf = (bakery) -> prices[bakery]

    raisePrice = (bakery) -> prices[bakery] *= 1.1

    reducePrice = (bakery) -> prices[bakery] /= 1.1

    {
      newBakeries: newBakeries
      calcCPS: calcCPS
      priceOf: priceOf
      raisePrice: raisePrice
      reducePrice: reducePrice
    }
  )
)(define ? if module? then (deps, factory) -> module.exports = factory() else (deps, factory) -> @['Bakery'] = factory())
