require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  describe CreditCard do

    describe '#create' do
      context "保存ができる" do  
        it "user_idとcutomer_idとcard_idがある場合は保存できること" do
          card = build(:credit_card)
          expect(card).to be_valid
        end
      end

      context "保存ができない場合" do
        it "customer_idが空のときは保存できないこと" do
          card = build(:credit_card, customer_id: nil)
          card.valid?
          expect(card.errors[:customer_id]).to include("can't be blank")
        end
      
        it "card_idが空のときは保存できないこと" do
          card = build(:credit_card, card_id: nil)
          card.valid?
          expect(card.errors[:card_id]).to include("can't be blank")
        end

        it "user_idがない場合は保存できないこと" do
          card = build(:credit_card, user: nil)
          card.valid?
          expect(card.errors[:user]).to include("can't be blank")
        end
      end
    end
  end
end
