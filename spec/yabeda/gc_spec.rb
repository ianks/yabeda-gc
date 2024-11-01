# frozen_string_literal: true

RSpec.describe Yabeda::GC do
  it "has a version number" do
    expect(Yabeda::GC::VERSION).not_to be nil
  end

  subject { Yabeda.collect! }

  GC.stat.each_key do |stat_name|
    it "tracks #{stat_name}" do
      expect { subject }.to(update_yabeda_gauge(Yabeda.gc.__send__(stat_name)).with(be_a(Integer)))
    end
  end
end
