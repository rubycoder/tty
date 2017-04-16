# encoding: utf-8

RSpec.describe 'rtty new' do

  after { FileUtils.rm_rf tmp_path }

  it "generates cli application" do
    app_name = tmp_path('newcli')

    output = <<-OUT
Creating gem 'newcli'...
      create  tmp/newcli/Gemfile
      create  tmp/newcli/.gitignore
      create  tmp/newcli/lib/newcli.rb
      create  tmp/newcli/lib/newcli/version.rb
      create  tmp/newcli/newcli.gemspec
      create  tmp/newcli/Rakefile
      create  tmp/newcli/README.md
      create  tmp/newcli/bin/console
      create  tmp/newcli/bin/setup
      create  tmp/newcli/.travis.yml
      create  tmp/newcli/.rspec
      create  tmp/newcli/spec/spec_helper.rb
      create  tmp/newcli/spec/newcli_spec.rb
Initializing git repo in #{app_name}
    OUT

    command = "bundle exec rtty new #{app_name} --no-coc --no-color"
    #out, err, status = Open3.capture3(command)
    out = `#{command}`

    expect(out).to eq(output)
    # expect(err).to eq('')
    # expect(status.exitstatus).to eq(0)
  end

  xit "fails without cli name" do
    output = <<-OUT.unindent
      ERROR: 'rtty new' was called with no arguments
      Usage: 'rtty new PROJECT_NAME'\n
    OUT
    command = "bundle exec rtty new"
    out, err, status = Open3.capture3(command)
    expect([out, err, status.exitstatus]).to match_array([output, '', 1])
  end

  xit "displays help" do
    output = <<-OUT
Usage:
  rtty new PROJECT_NAME [OPTIONS]

Options:
      [--coc], [--no-coc]          # Generate a code of conduct file.
                                   # Default: true
  -f, [--force]                    # Overwrite existing files.
  -h, [--help=HELP]                # Display usage information
  -t, [--test=TEST]                # Project test framework
      [--no-color]                 # Disable colorization in output
  -r, [--dry-run], [--no-dry-run]  # Run but do not make any changes.
      [--debug], [--no-debug]      # Run with debug logging.

Description:
  The 'rtty new' command creates a new command line application with a default 
  directory structure and configuration at the specified path.
    OUT

    command = "bundle exec rtty new --help"
    out, err, status = Open3.capture3(command)
    expect(out).to eq(output)
    expect(err).to eq('')
    expect(status.exitstatus).to eq(0)
  end

  def run_app_generator(cli_path)
    Dir.chdir(clid_path)
  end
end
