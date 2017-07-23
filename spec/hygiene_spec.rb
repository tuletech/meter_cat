describe 'coverage' do

  it('passes rubocop') { is_expected.to pass_rubocop }

  it 'has a spec for every file' do
    %w[app lib].each do |dir|
      Dir.glob(File.join(ENGINE_ROOT, dir, '**', '*.{rb,erb,rake}')) do |path|
        next if File.basename(path).match?(/^_/)
        path = path.sub(%r{#{ENGINE_ROOT}/}, '')
        path.should have_a_spec
      end
    end
  end
end
