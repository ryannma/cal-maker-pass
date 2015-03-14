require 'spec_helper'

describe ItemsController do

	describe '#find' do
		context 'when the admin correctly finds a single item' do
			it 'displays that item' do
				Item.should_receive(:find).with('1').and_return(item)
				# something
				get :find_result, {:id => '1'}
      			response.should render_template('find_result')
      		end
      	end

      	context 'when the admin tries find an unavailable item' do
			it 'redirects to index and says item unavailable' do
				# something
      			get :find_result, {:id => '1'}
    		  	response.should redirect_to items_path
      		end
      	end
    end

	describe '#checkout' do
		context 'Checkout with all transactions succeeding' do
			it 'redirects to index and notifies Successful Transaction' do
				# successful transactions happen here
				response.should redirect_to items_path
				expect(flash[:notice]).to match(/^Successful Transaction$/)
			end
		end
	end

	describe '#add' do
		context 'when trying to add a new item to inventory' do
			it 'notifies: Successfully Added' do
				item = build(:item)
				Item.should_receive(:create!).with(item).and_return(item)
				post :create, {:item => item}
				expect(flash[:notice]).to match(/^Successfully Added$/)
			end
		end
		context 'when trying to add an item already in inventory' do
			it 'notifies: Duplicate Item' do
				item = build(:item)
				Item.should_receive(:create!).with(item).and_raise(Item::Duplicate)
				post :create, {:item => item}
				expect(flash[:notice]).to match(/^Duplicate Item$/)
			end
		end
		context 'when trying to add an item of invalid price to inventory' do
			it 'notifies: Invalid Price' do
				item = build(:item)
				Item.should_receive(:create!).with(item).and_raise(Item::InvalidPrice)
				post :create, {:item => item}
				expect(flash[:notice]).to match(/^Invalid Price$/)
			end
		end
		context 'when trying to add an item of invalid quantity to inventory' do
			it 'notifies: Invalid Quantity' do
				item = build(:item)
				Item.should_receive(:create!).with('1').and_raise(Item::InvalidQuantity)
				post :create, {:item => item}
				expect(flash[:notice]).to match(/^Invalid Quantity$/)
			end
		end
	end

	describe '#show' do
		context '' do
			it '' do
			end
		end
	end

end

