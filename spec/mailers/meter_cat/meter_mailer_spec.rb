describe MeterCat::MeterMailer do

  it 'adds MeterCat::MeterHelper as a template helper' do
    modules = MeterCat::MeterMailer._helpers.included_modules
    modules.should include(MeterCat::MetersHelper)
  end

  describe '#report' do

    let(:mail) { MeterCat::MeterMailer.report }
    let(:config) { MeterCat.config }

    it 'uses the configured from address' do
      mail.from.should_not be_nil
      mail.from.should eql([config.from])
    end

    it 'uses the configured to address' do
      mail.to.should_not be_nil
      mail.to.should eql([config.to])
    end

    it 'uses the configured subject' do
      mail.subject.should_not be_nil
      mail.subject.should eql(config.subject)
    end

    it 'generates a multipart email with both text and html' do
      mail.parts.first.content_type.should eql('text/plain; charset=UTF-8')
      mail.parts.second.content_type.should eql('text/html; charset=UTF-8')
    end
  end
end
