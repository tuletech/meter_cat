describe 'version' do

  it 'has a version constant' do
    MeterCat::VERSION.should_not be_nil
    MeterCat::VERSION.should be_an_instance_of(String)
    MeterCat::VERSION.should =~ /\d+\.\d+\.\d+/
  end
end
