SMODS.Joker {
  key = 'anatomy',
  loc_txt = {
    name = 'Anatomy',
    text = {
      'Scored {C:attention}number cards{} have',
      '{C:green}#1#% of their rank out of #2#{}',
      'to be retriggered once'
    }
  },

  config = { extra = { odds = 10 } },
  unlocked = true,
  discovered = false,
  rarity = 2, -- Uncommon
  atlas = 'Sculio',
  pos = { x = 9, y = 0 },
  cost = 7,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    local key = nil
    local displayed_numerator, displayed_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_Sculio_anatomy')
    if displayed_numerator ~= 1 then
        key = "j_Sculio_anatomy_changed_prob"
    end
    return { key = key, vars = { displayed_numerator * 100, displayed_denominator } }
  end,
  calculate = function(self, card, context)
    if context.cardarea == G.play and context.repetition and not context.repetition_only then
      card_id = context.other_card:get_id()

      if card_id < 11 and SMODS.pseudorandom_probability(card, 'anatomy', card_id, card.ability.extra.odds, 'j_Sculio_anatomy') then
        return {
          message = localize('k_again_ex'),
          repetitions = 1
        }
      end
    end
  end
}
