Gem::Specification.new do |s|
  s.name = %q{blast_mavens_multiplayer}
  s.version = '0.1.0'

  s.required_rubygems_version = Gem::Requirement.new('>= 0') if s.respond_to? :required_rubygems_version=
  s.authors = ['tjbladez']
  s.date = %q{2011-04-15}
  s.summary = %q{2D ruby game like bomberman (in beta)}
  s.description = %q{Blast Mavens Multiplayer is 2D game written in ruby using gosu inspired by bomberman (currently in beta). Will be use as base for open AI competition}
  s.email = %q{tjbladez@gmail.com}
  s.has_rdoc = false
  s.bindir = 'bin'
  s.executables = %w{blast_mavens}
  s.default_executable = 'bin/blast_mavens'
  s.homepage = %q{http://github.com/tjbladez/blast_mavens_multiplayer}
  s.post_install_message = %q{Enjoy the game}
  s.add_dependency 'gosu'
end