require_relative '../lib/cocktail_card_module'

RSpec.describe PrintCocktail do
    #subject{User.new}

    # subject() do
    #     described_class.new('data/users.json')
    # end

    # describe '.new' do
    #     it 'it loads cocktails from json file' do
    #         expect(1 + 1).to eq(2)
    #     end
    # end

    describe 'selected_cocktail_name[cocktail_index]' do
        it 'should provide cocktail name from given index' do
            expect(PrintCocktail.selected_cocktail_name(0)).to eq('Vesper')
        end 
    end

    describe 'total_cocktails' do
        it 'should provide total amount of cocktails' do
            expect(PrintCocktail.total_cocktails).to eq(76)
        end
    end

    # def total_cocktails
    #     @cocktails.length - 1
    # end
end