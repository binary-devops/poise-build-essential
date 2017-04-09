#
# Copyright 2017, Noah Kantrowitz
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'spec_helper'

describe PoiseBuildEssential::BuildEssentialProviders::MacOSX do
  let(:chefspec_options) { {platform: 'mac_os_x', version: '10.12'} }
  step_into(:poise_build_essential)
  before do
    stub_command('pkgutil --pkgs=com.apple.pkg.CLTools_Executables').and_return(false)
  end

  describe 'action :install' do
    recipe do
      poise_build_essential 'build_essential' do
        action :install
      end
    end
    it { is_expected.to run_execute('install XCode Command Line tools') }
  end # /describe action :install

  describe 'action :upgrade' do
    recipe do
      poise_build_essential 'build_essential' do
        action :upgrade
      end
    end
    it { is_expected.to run_execute('install XCode Command Line tools') }
  end # /describe action :upgrade

  describe 'action :remove' do
    recipe do
      poise_build_essential 'build_essential' do
        action :remove
      end
    end
    it { expect { subject }.to raise_error NotImplementedError }
  end # /describe action :remove
end
