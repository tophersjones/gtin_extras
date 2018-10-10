require 'spec_helper'

describe GTINExtras do
  it 'has a version number' do
    expect(GTINExtras::VERSION).not_to be nil
  end
end

describe GTIN do
  describe '#upc?' do
    it 'rejects words' do
      expect('foobar'.upc?).to be false
    end
    it 'rejects words and numbers' do
      expect('123foobar'.upc?).to be false
    end
    it 'rejects bad numbers' do
      expect('123'.upc?).to be false
      expect('12345678901'.upc?).to be false
    end
    it 'rejects bad UPC' do
      expect('076378722791'.upc?).to be false
    end
    it 'validates UPC' do
      expect('076308722791'.upc?).to be true
    end
  end
  describe '#ean?' do
    it 'rejects words' do
      expect('foobar'.ean?).to be false
    end
    it 'rejects words and numbers' do
      expect('123foobar'.ean?).to be false
    end
    it 'rejects bad numbers' do
      expect('123'.ean?).to be false
      expect('12345678901'.ean?).to be false
    end
    it 'rejects bad EAN' do
      expect('5010924527481'.ean?).to be false
    end
    it 'validates EAN' do
      expect('5010724527481'.ean?).to be true
    end
  end
  describe '#gs1?' do
    it 'rejects words' do
      expect('foobar'.gs1?).to be false
    end
    it 'rejects words and numbers' do
      expect('123foobar'.gs1?).to be false
    end
    it 'rejects bad numbers' do
      expect('123'.gs1?).to be false
      expect('12345678901'.gs1?).to be false
    end
    it 'rejects bad GS1' do
      expect('10046001693866'.gs1?).to be false
    end
    it 'validates GS1' do
      expect('10048001693866'.gs1?).to be true
    end
  end
  describe '#gtin_structure' do
    it 'rejects words' do
      expect('foobar'.gtin_structure).to be nil
    end
    it 'rejects words and numbers' do
      expect('123foobar'.gtin_structure).to be nil
    end
    it 'returns correct structure' do
      expect('076308722791'.gtin_structure).to be :upc
      expect('5010724527481'.gtin_structure).to be :ean
      expect('10048001693866'.gtin_structure).to be :gs1
    end
  end
end

describe ASIN do
  describe '#asin?' do
    it 'rejects words' do
      expect('foobar'.asin?).to be false
    end
    it 'rejects words and numbers' do
      expect('123foobar'.asin?).to be false
    end
    it 'rejects bad numbers' do
      expect('123'.asin?).to be false
      expect('12345678901'.asin?).to be false
    end
    it 'validates ASIN' do
      expect('B00HG34JU9'.asin?).to be true
    end
  end
end

describe PLU do
  describe '#plu?' do
    it 'rejects words' do
      expect('foobar'.plu?).to be false
    end
    it 'rejects words and numbers' do
      expect('123foobar'.plu?).to be false
    end
    it 'rejects bad numbers' do
      expect('123'.plu?).to be false
      expect('12345678901'.plu?).to be false
    end
    it 'rejects bad PLU' do
      expect('2399'.plu?).to be false
    end
    it 'validates PLU' do
      expect('3499'.plu?).to be true
    end
    it 'validates organic PLU' do
      expect('83499'.plu?).to be true
    end
  end
end

describe ISBN do
  describe '#isbn?' do
    it 'rejects words' do
      expect('foobar'.isbn?).to be false
    end
    it 'rejects words and numbers' do
      expect('123foobar'.isbn?).to be false
    end
    it 'rejects bad numbers' do
      expect('123'.isbn?).to be false
      expect('12345678901'.isbn?).to be false
    end
    it 'rejects bad 10 digit ISBN' do
      expect('1298321987'.isbn?).to be false
    end
    it 'rejects bad 13 digit ISBN' do
      expect('1298321934387'.isbn?).to be false
    end
    it 'validates 10 digit ISBN' do
      expect('9971502100'.isbn?).to be true
    end
    it 'validates 13 digit ISBN' do
      expect('9781234567897'.isbn?).to be true
    end
    it 'validates ISBN with hyphens, spaces, or other characters' do
      expect('960-425-059-0'.isbn?).to be true
      expect('ISBN 978 0 393 34340 3'.isbn?).to be true
    end
  end
end

describe UNSPSC do 
  describe '#unspsc?' do 
    it 'rejects words' do
      expect('foobar'.unspsc?).to be false
    end
    it 'rejects words and numbers' do
      expect('123foobar'.unspsc?).to be false
    end
    it 'rejects bad UNSPSC' do
      expect('49240001'.unspsc?).to be false
    end
    it 'does not validate 10 digit UNSPSC' do
      expect('4320150114'.unspsc?).to be false
    end
    it 'validates 8 digit UNSPSC' do
      expect('43201501'.unspsc?).to be true
    end
  end
  describe '#unspsc_title?' do
    it 'Returns the title of a valid UNSPSC code' do
      expect('49240000'.unspsc_title?).to eq 'Recreation and playground and swimming and spa equipment and supplies'
      expect('43201501'.unspsc_title?).to eq 'Asynchronous transfer mode ATM telecommunications interface cards'
    end
    it 'Returns "No results found" for bad UNSPSC code' do
      expect('49240001'.unspsc_title?).to eq 'No results found'
    end
  end
end
