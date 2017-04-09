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

describe PoiseBuildEssential::Resources::PoiseBuildEssential do
  step_into(:poise_build_essential)
  recipe do
    poise_build_essential 'build_essential'
  end

  context 'with defaults' do
    it { is_expected.to install_poise_build_essential('build_essential').with(allow_unsupported_platform: false) }
  end # /context with defaults

  context 'with an unsupported platform' do
    let(:chefspec_options) { {platform: 'aix', version: '7.1'} }

    it { expect { subject }.to raise_error RuntimeError }

    context 'with allow_unsupported_platform' do
      recipe do
        poise_build_essential 'build_essential' do
          allow_unsupported_platform true
        end
      end
      before do
        expect(Chef::Log).to receive(:warn)
      end

      it { is_expected.to install_poise_build_essential('build_essential').with(allow_unsupported_platform: true) }
      # Confirm that no packages or anything else got installed.
      it { expect(chef_run.run_context.resource_collection.map(&:to_s)).to eq %w{poise_build_essential[build_essential]} }
    end # /context with allow_unsupported_platform
  end # /context with an unsupported platform
end
