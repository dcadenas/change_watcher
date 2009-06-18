require File.dirname(__FILE__) + "/../test_helper"
require 'file_test_helper'
include FileTestHelper

Expectations do
  expect nil do
    with_files do
     ChangeWatcher::FileStore.new("store.yml").latest_value
    end
  end

  expect true do
    with_files do
     ChangeWatcher::FileStore.new("store.yml").empty?
    end
  end

  expect true do
    with_files "store.yml" => "" do
     ChangeWatcher::FileStore.new("store.yml").empty?
    end
  end

  expect false do
    with_files "store.yml" => [Time.now, 6969].to_yaml do
     ChangeWatcher::FileStore.new("store.yml").empty?
    end
  end

  expect 6969 do
    with_files "store.yml" => [Time.now, 6969].to_yaml do
     ChangeWatcher::FileStore.new("store.yml").latest_value
    end
  end

  expect 6969 do
    with_files do
      file_store = ChangeWatcher::FileStore.new("store.yml")
      file_store.save(6969)
      file_store.latest_value
    end
  end

  expect 2 do
    with_files do
      file_store = ChangeWatcher::FileStore.new("store.yml")
      file_store.save(1)
      file_store.save(2)
      file_store.latest_value
    end
  end

  expect true do
    with_files do
      file_store = ChangeWatcher::FileStore.new("store.yml")
      file_store.save(12345678)
      file_store.save(87654321)

      file_content = File.read("store.yml")
      !!(file_content =~ /12345678/ && file_content =~ /87654321/)
    end
  end
end
