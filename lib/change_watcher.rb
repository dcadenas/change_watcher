require 'change_watcher/file_store'

class ChangeWatcher
  def initialize(&construction_block_dsl)
    construction_block_interpreter = ConstructionBlockInterpreter.new(&construction_block_dsl)

    @data_to_watch_block = construction_block_interpreter.data_to_watch_block
    @on_change_block = construction_block_interpreter.on_change_block
    @store = construction_block_interpreter.store
    @change_test_block = construction_block_interpreter.change_test_block || lambda{|old, new| old != new}
  end

  def check_for_change
    current_value = @data_to_watch_block.call

    if value_changed?(current_value)
      @on_change_block.call(@store.latest_value, current_value) if @on_change_block
      @store.save(current_value)
    end
  end

private 
  def value_changed?(current_value)
    @store.empty? || @change_test_block.call(@store.latest_value, current_value)
  end
  
  class ConstructionBlockInterpreter
    attr_reader :data_to_watch_block, :on_change_block, :store, :change_test_block

    def initialize(&construction_block_dsl)
      instance_eval(&construction_block_dsl)
      raise ArgumentError unless @data_to_watch_block && @store
    end

    def data_to_watch(&data_to_watch_block)
      @data_to_watch_block = data_to_watch_block
    end

    def on_change(&on_change_block)
      @on_change_block = on_change_block
    end

    def store_changes_in(store)
      if store.respond_to?(:to_str)
        @store = FileStore.new(store.to_str)
      else
        @store = store
      end
    end

    def define_change(&change_test_block)
      @change_test_block = change_test_block
    end
  end
end
