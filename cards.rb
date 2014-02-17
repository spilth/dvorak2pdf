require 'prawn'
require 'yaml'
require 'pry'

CARD_WIDTH = 72 * 2.5
CARD_HEIGHT = 72 * 3.5

actions = YAML.load_file('input/cards/actions.yml')
armor = YAML.load_file('input/cards/armor.yml')
characters = YAML.load_file('input/cards/characters.yml')
enemies = YAML.load_file('input/cards/enemies.yml')
goods = YAML.load_file('input/cards/goods.yml')
locations = YAML.load_file('input/cards/locations.yml')
mutations = YAML.load_file('input/cards/mutations.yml')
vehicles = YAML.load_file('input/cards/vehicles.yml')
weapons = YAML.load_file('input/cards/weapons.yml')

cards = []
cards.concat actions
cards.concat armor
cards.concat characters
cards.concat enemies
cards.concat goods
cards.concat locations
cards.concat mutations
cards.concat vehicles
cards.concat weapons

Prawn::Document.generate('output/cards.pdf', page_size: [2.75 * 72, 3.75 * 72], margin: 9) do
  on_first_page = true
  cards.each do |card|
    start_new_page unless on_first_page

    stroke do
      rectangle [0, CARD_HEIGHT], CARD_WIDTH, CARD_HEIGHT
    end

    color = "0000AA"

    if card['type'] == 'Action'
      color = "FF9900"
    end

    if card['type'] == 'Enemy'
      color = "FF0000"
    end

    if card['type'] == 'Character'
      color = "00AA00"
    end

    fill_color color

    font "Helvetica", style: :bold, size: 12 do
      text_box card['title'], at: [9, CARD_HEIGHT - 9], align: :center
    end

    fill_rectangle [0, CARD_HEIGHT - 23], CARD_WIDTH, 18

    fill_color "ffffff"

    fill do
      font "Helvetica", style: :normal, size: 8 do
        text_box card['type'], at: [9, CARD_HEIGHT - 28], align: :center
      end
    end

    fill_color "000000"

    if card['description']
      font "Helvetica", style: :normal, size: 8 do
        text_box card['description'], at: [9, CARD_HEIGHT - 45]
      end
    end

    if card['tokens']
      font "Helvetica", style: :normal, size: 8 do
        text_box "When this card is put into play, place #{card['tokens']} tokens on it.", at: [9, CARD_HEIGHT - 90]
      end
    end

    if card['ability']
      font "Helvetica", style: :normal, size: 8 do
        text_box card['ability'], at: [9, CARD_HEIGHT - 135]
      end
    end

    if card['flavor']
      font "Helvetica", style: :italic, size: 8 do
        text_box card['flavor'], at: [9, CARD_HEIGHT - 180]
      end
    end

    on_first_page = false if on_first_page

  end
end
