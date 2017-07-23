describe MeterCat::Engine do

  it 'isolates the MeterCat namespace' do
    expect(MeterCat::Engine.isolated).to be(true)
  end
end
