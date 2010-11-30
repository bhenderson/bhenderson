
class Hoe
  module Bhenderson

    ##
    # specify use of sudo for installing gems.

    attr_accessor :use_sudo, :use_force


    def initialize_bhenderson
    end

    def define_bhenderson_tasks
      desc "Reinstall gem. Sudo is optional parameter."
      task :reinstall_gem, [:sudo, :force] => Rake::Task[:install_gem].prerequisites do |t, args|
        self.use_sudo = !args.sudo.to_s.empty?
        self.use_force = !args.force.to_s.empty?
        reinstall_gem Dir['pkg/*.gem'].first
      end
    end

    # copied from Hoe::Package
    def reinstall_gem name, version = nil
      gem_cmd = Gem.default_exec_format % 'gem'
      sudo    = 'sudo '                  if use_sudo and not Hoe::WINDOZE
      force   = '--force'                if use_force
      local   = '--local'                unless version
      version = "--version '#{version}'" if     version
      sh "#{sudo}#{gem_cmd} install #{force} #{local} #{name} #{version}"
    end
  end
end
