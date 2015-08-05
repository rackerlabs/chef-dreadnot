require 'chefspec'
require_relative 'spec_helper'

describe 'dreadnot::default' do
  before(:each) do
    stub_command('which sudo').and_return(false)
  end

  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }
end
