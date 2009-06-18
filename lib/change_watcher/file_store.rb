class ChangeWatcher
  class FileStore
    def initialize(path_to_yaml_file)
      @path_to_yaml_file = path_to_yaml_file
    end

    def empty?(yaml_stream = get_yaml_stream)
      yaml_stream.nil? || yaml_stream.documents.empty?
    end

    def latest_value
      yaml_stream = get_yaml_stream
      return nil if empty?(yaml_stream)
      yaml_stream.documents.last.last
    end

    def save(value)
      File.open( @path_to_yaml_file, 'a' ) do |out|
        YAML.dump( [Time.now, value], out )
      end
    end

  private
    def get_yaml_stream
      return nil unless File.exists?(@path_to_yaml_file)
      YAML::load_stream(File.open(@path_to_yaml_file))
    end
  end
end
