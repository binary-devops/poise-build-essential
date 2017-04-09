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

describe PoiseBuildEssential::BuildEssentialProviders::SmartOS do
  let(:chefspec_options) { {platform: 'smartos', version: '5.11'} }
  step_into(:poise_build_essential)

  describe 'action :install' do
    recipe do
      poise_build_essential 'build_essential' do
        action :install
      end
    end
    it { is_expected.to install_package('autoconf') }
    it { is_expected.to install_package('binutils') }
    it { is_expected.to install_package('build-essential') }
    it { is_expected.to install_package('gcc47') }
    it { is_expected.to install_package('gmake') }
    it { is_expected.to install_package('pkg-config') }
  end # /describe action :install

  describe 'action :upgrade' do
    recipe do
      poise_build_essential 'build_essential' do
        action :upgrade
      end
    end
    it { is_expected.to upgrade_package('autoconf') }
    it { is_expected.to upgrade_package('binutils') }
    it { is_expected.to upgrade_package('build-essential') }
    it { is_expected.to upgrade_package('gcc47') }
    it { is_expected.to upgrade_package('gmake') }
    it { is_expected.to upgrade_package('pkg-config') }
  end # /describe action :upgrade

  describe 'action :remove' do
    recipe do
      poise_build_essential 'build_essential' do
        action :remove
      end
    end
    it { is_expected.to remove_package('autoconf') }
    it { is_expected.to remove_package('binutils') }
    it { is_expected.to remove_package('build-essential') }
    it { is_expected.to remove_package('gcc47') }
    it { is_expected.to remove_package('gmake') }
    it { is_expected.to remove_package('pkg-config') }
  end # /describe action :remove
end
