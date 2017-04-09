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

describe PoiseBuildEssential::BuildEssentialProviders::Solaris do
  let(:chefspec_options) { {platform: 'solaris2', version: '5.11'} }
  step_into(:poise_build_essential)

  describe 'action :install' do
    recipe do
      poise_build_essential 'build_essential' do
        action :install
      end
    end
    it { is_expected.to install_package('gcc').with(version: '4.8.2') }
    it { is_expected.to install_package('autoconf') }
    it { is_expected.to install_package('automake') }
    it { is_expected.to install_package('bison') }
    it { is_expected.to install_package('gnu-coreutils') }
    it { is_expected.to install_package('flex') }
    it { is_expected.to install_package('gcc-3') }
    it { is_expected.to install_package('gnu-grep') }
    it { is_expected.to install_package('gnu-make') }
    it { is_expected.to install_package('gnu-patch') }
    it { is_expected.to install_package('gnu-tar') }
    it { is_expected.to install_package('make') }
    it { is_expected.to install_package('pkg-config') }
    it { is_expected.to install_package('ucb') }

    context 'on Solaris 10' do
      let(:chefspec_options) { {platform: 'solaris2', version: '5.10'} }
      it { expect { subject }.to raise_error RuntimeError }

      context 'with allow_unsupported_platform' do
        recipe do
          poise_build_essential 'build_essential' do
            action :install
            allow_unsupported_platform true
          end
        end

        it do
          expect(Chef::Log).to receive(:warn)
          # Confirm that no packages or anything else got installed.
          expect(chef_run.run_context.resource_collection.map(&:to_s)).to eq %w{poise_build_essential[build_essential]}
        end
      end # /context with allow_unsupported_platform
    end # /context on Solaris 10
  end # /describe action :install

  describe 'action :upgrade' do
    recipe do
      poise_build_essential 'build_essential' do
        action :upgrade
      end
    end
    it { is_expected.to upgrade_package('gcc').with(version: '4.8.2') }
    it { is_expected.to upgrade_package('autoconf') }
    it { is_expected.to upgrade_package('automake') }
    it { is_expected.to upgrade_package('bison') }
    it { is_expected.to upgrade_package('gnu-coreutils') }
    it { is_expected.to upgrade_package('flex') }
    it { is_expected.to upgrade_package('gcc-3') }
    it { is_expected.to upgrade_package('gnu-grep') }
    it { is_expected.to upgrade_package('gnu-make') }
    it { is_expected.to upgrade_package('gnu-patch') }
    it { is_expected.to upgrade_package('gnu-tar') }
    it { is_expected.to upgrade_package('make') }
    it { is_expected.to upgrade_package('pkg-config') }
    it { is_expected.to upgrade_package('ucb') }
  end # /describe action :upgrade

  describe 'action :remove' do
    recipe do
      poise_build_essential 'build_essential' do
        action :remove
      end
    end
    it { is_expected.to remove_package('gcc') }
    it { is_expected.to remove_package('autoconf') }
    it { is_expected.to remove_package('automake') }
    it { is_expected.to remove_package('bison') }
    it { is_expected.to remove_package('gnu-coreutils') }
    it { is_expected.to remove_package('flex') }
    it { is_expected.to remove_package('gcc-3') }
    it { is_expected.to remove_package('gnu-grep') }
    it { is_expected.to remove_package('gnu-make') }
    it { is_expected.to remove_package('gnu-patch') }
    it { is_expected.to remove_package('gnu-tar') }
    it { is_expected.to remove_package('make') }
    it { is_expected.to remove_package('pkg-config') }
    it { is_expected.to remove_package('ucb') }
  end # /describe action :remove
end
