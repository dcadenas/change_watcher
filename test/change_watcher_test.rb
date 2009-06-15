require File.dirname(__FILE__) + "/test_helper"
require 'file_test_helper'
include FileTestHelper

Expectations do
  expect "Something changed" do
    result = "Nothing changed"

    change_watcher = ChangeWatcher.new do
      data_to_watch do
        0
      end

      on_change do
        result = "Something changed"
      end

      store_changes_in TestStore.new
    end
    
    change_watcher.check_for_change
    result
  end

  expect "Nothing changed" do
    result = "Nothing changed"

    change_watcher = ChangeWatcher.new do
      data_to_watch do
        0
      end

      on_change do
        result = "Something changed"
      end

      store_changes_in TestStore.new
    end
    
    change_watcher.check_for_change
    result = "Nothing changed"
    change_watcher.check_for_change
    result
  end

  expect "Nothing changed" do
    result = "Nothing changed"

    change_watcher = ChangeWatcher.new do
      data_to_watch do
        0
      end

      define_change do |old_value, new_value|
        old_value != new_value
      end

      on_change do
        result = "Something changed"
      end

      store_changes_in TestStore.new
    end
    
    change_watcher.check_for_change
    result = "Nothing changed"
    change_watcher.check_for_change
    result
  end

  expect "Something changed" do
    result = "Nothing changed"

    change_watcher = ChangeWatcher.new do
      data_to_watch do
        0
      end

      define_change do |old_value, new_value|
        old_value == new_value
      end

      on_change do
        result = "Something changed"
      end

      store_changes_in TestStore.new
    end
    
    change_watcher.check_for_change
    result = "Nothing changed"
    change_watcher.check_for_change
    result
  end

  expect "It was 0 but now it is 1" do
    watched_value = 0
    result = "Nothing changed"

    change_watcher = ChangeWatcher.new do
      data_to_watch do
        watched_value
      end

      on_change do |old_value, new_value|
        result = "It was #{old_value} but now it is #{new_value}"
      end

      store_changes_in TestStore.new
    end

    change_watcher.check_for_change
    watched_value = 1
    change_watcher.check_for_change
    result
  end

  expect "It was 1 but now it is 2" do
    watched_value = 0
    result = "Nothing changed"

    change_watcher = ChangeWatcher.new do
      data_to_watch do
        watched_value
      end

      on_change do |old_value, new_value|
        result = "It was #{old_value} but now it is #{new_value}"
      end

      store_changes_in TestStore.new
    end
    
    change_watcher.check_for_change
    watched_value = 1
    change_watcher.check_for_change
    watched_value = 2
    change_watcher.check_for_change
    result
  end

  expect false do
    store = TestStore.new

    change_watcher = ChangeWatcher.new do
      data_to_watch do
        0
      end

      store_changes_in store
    end

    change_watcher.check_for_change
    store.empty?
  end

  expect false do
    store = TestStore.new

    change_watcher = ChangeWatcher.new do
      data_to_watch do
        0
      end

      store_changes_in store
    end

    change_watcher.check_for_change
    change_watcher.check_for_change
    store.empty?
  end

  expect true do
    i = 0
    store = TestStore.new

    change_watcher = ChangeWatcher.new do
      data_to_watch do
        i += 1
      end

      store_changes_in store
    end

    change_watcher.check_for_change
    !store.empty?
  end

  expect true do
    with_files do
      change_watcher = ChangeWatcher.new do
        data_to_watch do
          12345678
        end

        store_changes_in "store.yml"
      end

      change_watcher.check_for_change
      !!(File.read("store.yml") =~ /12345678/)
    end
  end
end
