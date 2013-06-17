# -*- encoding: utf-8 -*-

require 'spec_helper'

describe TTY::Terminal::Pager, '#available' do
  let(:execs) { ['less', 'more'] }
  let(:system) { TTY::System }

  subject { described_class }

  before { subject.stub(:executables).and_return(execs) }

  context 'when command exists' do
    before {
      system.stub(:exists?).with('less').and_return(true)
      system.stub(:exists?).with('more').and_return(false)
    }

    it 'finds single command' do
      expect(subject.available).to eql('less')
    end
  end

  context 'when no command exists' do
    before { system.stub(:exists?).and_return(false) }

    it "doesn't find command" do
      expect(subject.available).to be_nil
    end
  end
end