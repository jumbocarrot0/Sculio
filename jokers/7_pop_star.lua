SMODS.Joker {
  key = 'pop_star',

  config = { extra = { odds = 4 } },
  unlocked = true,
  discovered = false,
  rarity = 2, -- Uncommon
  atlas = 'Sculio',
  pos = { x = 6, y = 0 },
  cost = 7,
  loc_vars = function(self, info_queue, card)
    local displayed_numerator, displayed_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_Sculio_pop_star')
    return { vars = { displayed_numerator, displayed_denominator } }
  end,
  calculate = function(self, card, context)
    if context.before and not context.blueprint then
      for k, v in ipairs(context.scoring_hand) do
        if v.debuff == false and SMODS.pseudorandom_probability(card, 'pop_star', 1, card.ability.extra.odds, 'j_Sculio_pop_star') then
        --   math.randomseed(pseudorandom('pop_star'))
        --   enhancement_index = math.random(1, #G.P_CENTER_POOLS['Enhanced'])
        --   enhancement = G.P_CENTER_POOLS['Enhanced'][enhancement_index]
          enhancement = SMODS.poll_enhancement({
            key = "pop_star",
            guaranteed = true
          })
          v:set_ability(enhancement, nil, true)

          G.E_MANAGER:add_event(Event({
            func = function()
              v:juice_up()
              return true
            end
          }))
        end
      end
    end
  end
}
