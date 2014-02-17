require 'prawn'
require 'yaml'
require 'pry'

CARD_WIDTH = 72 * 2.5
CARD_HEIGHT = 72 * 3.5

cards = YAML.load_file('cards.yml')

Prawn::Document.generate('cards.pdf', page_size: [2.75 * 72, 3.75 * 72], margin: 9) do
  on_first_page = true
  cards.each do |card|
    # binding.pry
    start_new_page unless on_first_page

    # stroke_axis
    stroke do
      rectangle [0, CARD_HEIGHT], CARD_WIDTH, CARD_HEIGHT
    end

    font "Helvetica", style: :bold, size: 12 do
      text_box card['title'], at: [9, CARD_HEIGHT - 9]
    end
    font "Helvetica", style: :normal, size: 8 do
      text_box card['type'], at: [9, CARD_HEIGHT - 27]
    end

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
