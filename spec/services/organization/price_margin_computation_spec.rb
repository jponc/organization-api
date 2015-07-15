require 'rails_helper'
describe Organization::PriceMarginComputation do
  let(:org) { stub('Organization') }
  let(:service) { Organization::PriceMarginComputation.new(org) }


  describe '#compute' do
    before do
      org.stubs(:pricing_policy).returns(Organization::PRICING_POLICIES[policy_sym])
    end

    context 'policy is flexible' do
      let(:policy_sym) { :FLEXIBLE }
      it 'calls compute_flexible' do
        service.expects(:compute_flexible)
        service.compute
      end
    end

    context 'policy is fixed' do
      let(:policy_sym) { :FIXED }
      it 'calls compute_fixed' do
        service.expects(:compute_fixed)
        service.compute
      end
    end

    context 'policy is prestige' do
      let(:policy_sym) { :PRESTIGE }
      it 'calls compute_prestige' do
        service.expects(:compute_prestige)
        service.compute
      end
    end
  end

  describe '#compute_flexible' do
    let(:body) { stub('HTML Body') }
    let(:substring_length) { 300 }
    it 'calls http get with reuters.com and get the count of substring a' do
      Net::HTTP.expects(:get).with('www.reuters.com', '/').returns(body)
      service.expects(:get_substr_length).with(body, 'a').returns(substring_length)
      service.compute_flexible
    end

    it 'divides by 100 the result of get_substr_length' do

      Net::HTTP.stubs(:get)
      service.stubs(:get_substr_length).returns(substring_length)
      expect(service.compute_flexible).to eq(substring_length / 100.0)
    end
  end

  describe '#compute_fixed' do
    let(:body) { stub('HTML Body') }
    it 'calls http get with developer.github.com/v3/#http-redirects and get the count of substring status' do
      Net::HTTP.expects(:get).with('https://developer.github.com', '/v3/#http-redirects').returns(body)
      service.expects(:get_substr_length).with(body, 'status')
      service.compute_fixed
    end
  end

  describe '#compute_prestige' do
    let(:body) { stub('HTML Body') }
    it 'calls http get with www.yourlocalguardian.co.uk/sport/rugby/rss and get count of substring pubDate' do
      Net::HTTP.expects(:get).with('www.yourlocalguardian.co.uk', '/sport/rugby/rss/').returns(body)
      service.expects(:get_substr_length).with(body, 'pubDate')
      service.compute_prestige
    end
  end

  describe '#get_substr_length' do
    let(:body) { stub('Body') }
    let(:substring) { stub('Substring') }
    let(:substrings) { stub('Substrings') }

    it 'gets the number of substring occurences in the body' do
      body.expects(:scan).with(substring).returns(substrings)
      substrings.expects(:length)
      service.get_substr_length(body, substring)
    end
  end

end
