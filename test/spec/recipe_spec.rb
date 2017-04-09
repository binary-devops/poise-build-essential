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

describe 'poise-build-essential::default' do
  recipe { include_recipe 'poise-build-essential' }

  context 'with defaults' do
    it { is_expected.to install_poise_build_essential('build_essential').with(allow_unsupported_platform: false) }
  end # /context with defaults

  context 'with attributes' do
    before do
      override_attributes['poise-build-essential'] = {}
      override_attributes['poise-build-essential']['action'] = 'upgrade'
      override_attributes['poise-build-essential']['allow_unsupported_platform'] = true
    end

    it { is_expected.to upgrade_poise_build_essential('build_essential').with(allow_unsupported_platform: true) }
  end # /context with attributes
end
