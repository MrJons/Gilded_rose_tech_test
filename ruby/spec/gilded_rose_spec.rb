require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do

    SELLIN  = 3
    QUALITY = 8

    context 'standard items' do

      it 'reduces value & qualiy at end of day' do
        items = [Item.new("apple", SELLIN, QUALITY)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq(SELLIN - 1)
        expect(items[0].quality).to eq(QUALITY - 1)
      end

      it 'reduces quality twice as fast after sell by date' do
        SELL_BY_DATE = 0
        items = [Item.new("apple", SELL_BY_DATE, QUALITY)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq(SELL_BY_DATE - 1)
        expect(items[0].quality).to eq(QUALITY - 2)
      end
    end

    context 'Aged Brie' do

      it 'increases the quality of Aged Brie' do
        items = [Item.new("Aged Brie", SELLIN, QUALITY)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq(SELLIN - 1)
        expect(items[0].quality).to eq(QUALITY + 1)
      end
    end

    context 'Sulfuras items' do

      it 'sellin & quality does not diminish' do
        items = [Item.new("Sulfuras, Hand of Ragnaros", SELLIN, QUALITY)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq(SELLIN)
        expect(items[0].quality).to eq(QUALITY)
      end
    end

    context 'backstage passes' do

      it 'increases in quality by 2 when sellin is 10 or less' do
        BACKSTAGE_10_SELLIN = 8
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", BACKSTAGE_10_SELLIN, QUALITY)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq(BACKSTAGE_10_SELLIN - 1)
        expect(items[0].quality).to eq(QUALITY + 2)
      end

      it 'increases in quality by 3 when sellin is 5 or less' do
        BACKSTAGE_5_SELLIN = 4
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", BACKSTAGE_5_SELLIN, QUALITY)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq(BACKSTAGE_5_SELLIN - 1)
        expect(items[0].quality).to eq(QUALITY + 3)
      end

      it 'quality drops to 0 after concert' do
        AFTER_SELLIN = 0
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", AFTER_SELLIN, QUALITY)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq(AFTER_SELLIN - 1)
        expect(items[0].quality).to eq(0)
      end
    end

    context 'max & minimum quality' do
      it 'quality cannot be negative' do
        QUALITY_BASE = 0
        items = [Item.new("apple", SELL_BY_DATE, QUALITY_BASE)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq(SELL_BY_DATE - 1)
        expect(items[0].quality).to eq(QUALITY_BASE)
      end

      it 'quality cannot go above 50' do
        QUALITY_TOP = 50
        items = [Item.new("Aged Brie", SELL_BY_DATE, QUALITY_TOP)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq(SELL_BY_DATE - 1)
        expect(items[0].quality).to eq(QUALITY_TOP)
      end
    end

  end
end
